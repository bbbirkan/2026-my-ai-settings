---
name: birkan-desktop-packaging
description: |
  Python/FastAPI uygulamasını masaüstüne (Windows .exe, macOS .app) ve Chrome Extension'a
  paketleme rehberi. Tauri 2.0 + PyInstaller sidecar mimarisi, yt-dlp external binary
  stratejisi, code signing (macOS notarization, Windows Azure Artifact Signing), CORS
  konfigürasyonu. Birkan'ın YouTube transkript sistemi (VisionWatch, YouTube Mini, Channel
  Router) baz alınarak hazırlanmıştır. 2026 production-ready.
version: "1.0"
platforms: [claude, hermes]
tags: [desktop, packaging, tauri, pyinstaller, chrome-extension, youtube, fastapi]
---

# Birkan Desktop Packaging Skill

Python FastAPI uygulamasını üç platforma dağıtma rehberi:
- **Chrome Extension** (Manifest V3)
- **Windows** (.exe, tek tıkla çalışır)
- **macOS** (.app, App Store olmadan)

---

## MİMARİ KARAR TABLOSU (Değiştirme)

| Katman | Seçim | Neden |
|--------|-------|-------|
| Masaüstü shell | **Tauri 2.0** | Electron: 200MB RAM / 120MB installer. Tauri: 40MB RAM / 3MB installer |
| Python paketleyici | **PyInstaller** | Nuitka 2026'da AV'ye daha çok takılıyor (malware yazarları Nuitka kullanıyor) |
| yt-dlp | **Dışarıda, runtime'da güncelle** | YouTube haftada değişiyor → frozen içinde olursa uygulama kırılır |
| Tarayıcı | **Chrome MV3** | V2 öldü, tek standart |
| macOS imzalama | **notarytool** (altool öldü) | Gatekeeper zorunlu, $99/yıl Apple Developer |
| Windows imzalama | **Azure Artifact Signing** ($9.99/ay) | EV sertifika 2024'ten beri SmartScreen'i bypass etmiyor |

---

## KRİTİK KURAL #1 — yt-dlp FROZEN PAKETE GİRMEZ

YouTube'un PO Token ve nsig algoritmaları bazen haftalık değişiyor.
yt-dlp PyInstaller içine paketlenirse → uygulama kırılır, kullanıcıya yeni versiyon indirtmek gerekir.

**Doğru yol:**
```python
# startup.py — FastAPI başlarken çağır
import asyncio, os, platform, httpx
from pathlib import Path

def get_ytdlp_path() -> Path:
    base = Path(os.environ.get("APPDATA", Path.home() / ".config")) / "birkan-app"
    base.mkdir(exist_ok=True)
    name = "yt-dlp.exe" if platform.system() == "Windows" else "yt-dlp"
    return base / name

async def ensure_ytdlp():
    path = get_ytdlp_path()
    if not path.exists():
        # GitHub Releases'tan indir
        system = platform.system().lower()
        fname = "yt-dlp.exe" if system == "windows" else f"yt-dlp_macos" if system == "darwin" else "yt-dlp"
        url = f"https://github.com/yt-dlp/yt-dlp/releases/latest/download/{fname}"
        async with httpx.AsyncClient() as client:
            r = await client.get(url, follow_redirects=True)
            path.write_bytes(r.content)
            path.chmod(0o755)
    return path

async def update_ytdlp():
    path = get_ytdlp_path()
    proc = await asyncio.create_subprocess_exec(str(path), "--update-to", "nightly")
    await proc.wait()
```

---

## ADIM 1 — FastAPI Hazırlığı

### CORS Ekle (Chrome Extension için zorunlu)
```python
# main.py
from fastapi.middleware.cors import CORSMiddleware

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],        # veya ["chrome-extension://<extension_id>"]
    allow_methods=["*"],
    allow_headers=["*"],
)
```

### Dinamik Port
```python
import os
PORT = int(os.environ.get("API_PORT", 8000))
```
Tauri, boş port bulup `API_PORT` env değişkeni olarak Python'a geçirir.

---

## ADIM 2 — PyInstaller Binary

```bash
# requirements-build.txt
pip install pyinstaller

# AV false positive azaltmak için bootloader'ı yerel derle
git clone https://github.com/pyinstaller/pyinstaller
cd pyinstaller/bootloader && python ./waf all && cd ../..
pip install ./pyinstaller

# Binary oluştur
pyinstaller --onefile --name api-server \
  --hidden-import uvicorn.logging \
  --hidden-import uvicorn.loops.auto \
  --hidden-import uvicorn.protocols.http.auto \
  --hidden-import pydantic \
  main.py

# Çıktı: dist/api-server (Linux/Mac) veya dist/api-server.exe (Windows)
```

**Cross-compilation YOK.** Windows .exe → Windows makinesinde. Mac .app → Mac'te.
GitHub Actions kullan (aşağıda).

---

## ADIM 3 — Tauri 2.0 Kurulum

```bash
npm create tauri-app@latest -- --template vanilla
cd birkan-app

# Python sidecar eklentisi
cargo add tauri-plugin-shell
```

### tauri.conf.json
```json
{
  "bundle": {
    "externalBin": ["binaries/api-server"]
  },
  "plugins": {
    "shell": {
      "open": true
    }
  }
}
```

### Binary'yi doğru konuma koy
```bash
# Tauri, binary adına platform suffix ekler:
# api-server-x86_64-pc-windows-msvc.exe   (Windows)
# api-server-x86_64-apple-darwin           (Mac Intel)
# api-server-aarch64-apple-darwin          (Mac M1/M2)

cp dist/api-server src-tauri/binaries/api-server-$(rustc -vV | grep host | cut -d' ' -f2)
```

### src-tauri/capabilities/default.json
```json
{
  "permissions": ["shell:allow-execute", "shell:allow-spawn"]
}
```

### main.rs — Python'u otomatik başlat
```rust
use tauri_plugin_shell::ShellExt;

tauri::Builder::default()
    .plugin(tauri_plugin_shell::init())
    .setup(|app| {
        let sidecar = app.shell().sidecar("api-server").unwrap();
        sidecar.spawn().unwrap();
        Ok(())
    })
    .run(tauri::generate_context!())
    .unwrap();
```

---

## ADIM 4 — Chrome Extension (Manifest V3)

### manifest.json
```json
{
  "manifest_version": 3,
  "name": "Birkan YouTube Tool",
  "permissions": ["storage", "activeTab", "scripting"],
  "host_permissions": ["https://www.youtube.com/*", "http://localhost/*"],
  "background": { "service_worker": "background.js" },
  "content_scripts": [{
    "matches": ["https://www.youtube.com/*"],
    "js": ["content.js"],
    "world": "MAIN"
  }]
}
```

### content.js — YouTube verisini yakala
```javascript
// YouTube'un kendi fetch'ini monkey-patch et
const originalFetch = window.fetch;
window.fetch = async (...args) => {
  const response = await originalFetch(...args);
  const url = args[0].toString();
  if (url.includes('/youtubei/v1/player') || url.includes('/api/timedtext')) {
    const clone = response.clone();
    clone.json().then(data => {
      chrome.runtime.sendMessage({ type: 'youtube_data', url, data });
    }).catch(() => {});
  }
  return response;
};
```

### background.js — Localhost'a ilet
```javascript
chrome.runtime.onMessage.addListener((msg) => {
  if (msg.type === 'youtube_data') {
    fetch('http://localhost:8000/ingest', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(msg.data)
    }).catch(console.error);
  }
});
```

---

## ADIM 5 — macOS Code Signing

**Gereksinimler:** Apple Developer Program ($99/yıl), Xcode CLI tools

### entitlements.plist (PyInstaller için zorunlu)
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" ...>
<plist version="1.0"><dict>
  <key>com.apple.security.cs.allow-jit</key><true/>
  <key>com.apple.security.cs.allow-unsigned-executable-memory</key><true/>
  <key>com.apple.security.cs.disable-library-validation</key><true/>
</dict></plist>
```

### İmzalama + Notarization
```bash
# İmzala
codesign --deep --force \
  --sign "Developer ID Application: BIRKAN KALYON (TEAM_ID)" \
  --entitlements entitlements.plist \
  --options runtime \
  BirkanApp.app

# Notarize
xcrun notarytool submit BirkanApp.app \
  --apple-id "YOUR_APPLE_ID@example.com" \
  --team-id "TEAM_ID" \
  --password "APP_SPECIFIC_PASSWORD" \
  --wait

# Zımbala (offline çalışması için)
xcrun stapler staple BirkanApp.app
```

---

## ADIM 6 — Windows Code Signing

**Önemli:** EV sertifika 2024'ten beri SmartScreen'i bypass etmiyor.
Kendi kullanım için imzalama zorunlu değil. Dağıtım için:

**Türkiye'den bireysel:** Azure Artifact Signing kullanılamıyor (coğrafi kısıt).
→ DigiCert/Sectigo OV sertifikası al + SmartScreen için indirme sayısını bekle.

```bash
# sign.exe (signtool.exe değil — modern araç)
dotnet tool install --global sign

sign code azure-key-vault "**/*.exe" \
  --azure-key-vault-url "https://VAULT.vault.azure.net/" \
  --azure-key-vault-certificate "CERT_NAME" \
  --azure-key-vault-client-id "CLIENT_ID" \
  --azure-key-vault-client-secret "SECRET" \
  --azure-key-vault-tenant-id "TENANT_ID"
```

---

## ADIM 7 — GitHub Actions CI/CD

```yaml
# .github/workflows/build.yml
name: Build Desktop App
on: [push]
jobs:
  build-windows:
    runs-on: windows-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v5
        with: { python-version: '3.11' }
      - run: pip install -r requirements.txt pyinstaller
      - run: pyinstaller --onefile --name api-server main.py
      - uses: dtolnay/rust-toolchain@stable
      - run: npm ci && npm run tauri build
        working-directory: ./desktop

  build-macos:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v5
        with: { python-version: '3.11' }
      - run: pip install -r requirements.txt pyinstaller
      - run: pyinstaller --onefile --name api-server main.py
      - uses: dtolnay/rust-toolchain@stable
      - run: npm ci && npm run tauri build
        working-directory: ./desktop
      # Notarization adımları buraya ekle (Apple credentials secret olarak)
```

---

## SIKÇA KARŞILAŞILAN SORUNLAR

| Sorun | Neden | Çözüm |
|-------|-------|-------|
| Mac'te "uygulama hasarlı" uyarısı | Notarization yok | `xattr -cr App.app` (kendi kullanım) veya notarize et |
| Windows'ta Defender uyarısı | PyInstaller imzasız | Yerel bootloader derle veya imzala |
| Extension localhost'a bağlanamıyor | CORS eksik | FastAPI'ye CORSMiddleware ekle |
| yt-dlp "403 forbidden" | PO Token eksik | yt-dlp --update-to nightly ile güncelle |
| Mac açılışta Python sidecar başlamıyor | Binary suffix yanlış | `rustc -vV | grep host` ile doğru suffix'i kontrol et |

---

## İLGİLİ PROJELER (Birkan)
- `github.com/bbbirkan/2026-channel-router` — Paketlenecek ana proje
- `github.com/bbbirkan/2026-visionwatch` — VisionWatch API
- `github.com/bbbirkan/2026-youtube-mini` — YouTube Mini API
- [[project-youtube-ecosystem]]
- [[reference-desktop-packaging-research]]
