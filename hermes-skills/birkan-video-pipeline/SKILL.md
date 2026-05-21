---
name: birkan-video-pipeline
description: |
  3 kademeli akıllı video anlama pipeline'ı — ÇEK → DİNLE → İZLE.
  YouTube, TikTok, Instagram, Loom, lokal MP4 desteklenir.
  Her kademe başarısız olunca bir sonrakine geçer, kullanıcıya ne yaptığını söyler.
  Analiz Orchester'a gönderilir (localhost:8006). Tüm geçici dosyalar işlem sonrası otomatik silinir.
tags: [video, youtube, transcript, whisper, ffmpeg, yt-dlp, vision, frame-analysis, orchester]
---

# Video Pipeline Skill — Çek → Dinle → İzle

## Ne Zaman Kullanılır (Trigger)
- "Bu videoyu izle / analiz et / özetle" + URL
- YouTube, TikTok, Instagram, Vimeo, Loom, X linki verildiğinde
- Lokal `.mp4 / .mov / .mkv` analiz edilecekse
- Birkan özellikle belirtmediği sürece en hafif kademeyle başla

---

## Disk Temizleme — ZORUNLU KURAL

**Her işlem sonrası geçici dosyalar silinir. İstisna yok.**

```bash
# İşlem biter bitmez çalıştır:
rm -f /tmp/video_* /tmp/frames_*.jpg /tmp/video_part_*.mp3 2>/dev/null
echo "Geçici dosyalar temizlendi ✓"
```

Kullanıcı "videoyu sakla / kaydet" derse → işlem öncesi sor, gerekiyorsa `/root/videos/` gibi kalıcı bir yere kopyala, sonra /tmp'yi yine temizle.

---

## Analiz — Orchester'a Gönder

Transkript veya frame'ler hazırlandıktan sonra analiz **Orchester**'a gönderilir.

```bash
# Orchester çalışıyor mu kontrol et
ORCH_STATUS=$(curl -s http://localhost:8006/health 2>/dev/null | python3 -c "import sys,json; print(json.load(sys.stdin).get('status',''))" 2>/dev/null)

if [ "$ORCH_STATUS" = "ok" ]; then
  # Orchester'a gönder
  RESULT=$(curl -s -X POST http://localhost:8006/orchestrate \
    -H "Content-Type: application/json" \
    -d "$(python3 -c "
import json, sys
task = sys.argv[1]
print(json.dumps({'task': task, 'mode': 'smart'}))
" "[KULLANICI İSTEĞİ]\n\nTranskript:\n[TRANSKRİPT]")" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('synthesis',''))")
  echo "$RESULT"
else
  # Orchester yoksa Claude CLI ile analiz et
  echo "[Orchester erişilemiyor, Claude ile analiz ediyorum...]"
  claude -p --dangerously-skip-permissions \
    "[KULLANICI İSTEĞİ]\n\nTranskript:\n[TRANSKRİPT]"
fi
```

**Orchester smart mod:** basit soru → Claude, orta → Claude+OpenCode, zor → 3 CLI konsey.

---

## 3 Bağımsız Mod — Ne Zaman Hangisi?

### Mod Seçim Kuralı

```
Kullanıcı "izle / iyi anla / derinlemesine analiz et" dedi?
  → İZLE modunu kullan (görsel bağlam kritik)

İçerik görsel mi? (demo, grafik, kod ekranı, sunum slaytı)
  → Sen karar ver: İZLE moduna geç, "izliyorum" de

Standart bilgi sorusu, özet, transkript yeterli mi?
  → ÇEK → başarısız → DİNLE

Her şey başarısız?
  → SOR
```

**Her modda kullanıcıya söyle:**
- "Transkripti çektim ✓"
- "Ses indirip Whisper ile dinledim ✓"
- "İzliyorum — frame analizi yapıyorum, biraz token harcayacak..."
- "Erişemedim, şunları deneyebilirsin..."

---

### Modların Avantajları

| Mod | Hız | Maliyet | Ne Kazandırır |
|-----|-----|---------|---------------|
| **ÇEK** | Saniyeler | Sıfır | Altyazı/transkript varsa anında al |
| **DİNLE** | 1-3dk | Düşük (Groq) | Altyazı yoksa sesi Whisper ile metne çevir |
| **İZLE** | 3-10dk | Orta (token) | Görsel bağlam, grafik, demo, kod ekranı, slayt |

---

## Mod A — ÇEK → DİNLE (Boru Hattı)

### A1 — ÇEK: Deneme 1 (Standart)

```bash
yt-dlp --write-auto-sub --write-sub --sub-lang tr,en \
  --skip-download -o /tmp/video_%(id)s VIDEO_URL

ls /tmp/video_*.vtt /tmp/video_*.srt 2>/dev/null
```

Altyazı dosyası bulunduysa → Orchester'a gönder → disk temizle → **dur**.

### A2 — ÇEK: Deneme 2 (Bot koruması varsa)

```bash
# Android client ile dene
yt-dlp --extractor-args "youtube:player_client=android" \
  --write-auto-sub --skip-download -o /tmp/video_%(id)s VIDEO_URL

# Hala yok? Cookies ile dene
yt-dlp --cookies-from-browser chrome \
  --write-auto-sub --skip-download -o /tmp/video_%(id)s VIDEO_URL

# Hala yok? jina.ai (metadata + açıklama, tam transkript değil)
curl -sL "https://r.jina.ai/VIDEO_URL" -A "Mozilla/5.0" | head -200
```

Altyazı bulunduysa → Orchester'a gönder → disk temizle → **dur**.
İkinci denemeden sonra da yok → **DİNLE'ye geç**.

### A3 — DİNLE: Groq Whisper Fallback

```bash
# Ses indir (mp3)
yt-dlp -x --audio-format mp3 --audio-quality 0 \
  -o /tmp/video_%(id)s.%(ext)s VIDEO_URL

# Groq Whisper ile transkript al
source ~/.hermes/.env 2>/dev/null || true
TRANSCRIPT=$(curl -s https://api.groq.com/openai/v1/audio/transcriptions \
  -H "Authorization: Bearer $GROQ_API_KEY" \
  -F "file=@/tmp/video_ID.mp3" \
  -F "model=whisper-large-v3" \
  -F "language=tr" | python3 -c "import sys,json; print(json.load(sys.stdin)['text'])")

# HEMEN ses dosyasını sil
rm -f /tmp/video_*.mp3

echo "Ses transkripte çevrildi, ses dosyası silindi ✓"
# → Orchester'a gönder
```

**Ses 25MB'ı aşarsa (uzun video):**
```bash
# ffmpeg ile parçala (10 dakikalık dilimler)
ffmpeg -i /tmp/video_ID.mp3 -f segment -segment_time 600 \
  -c copy /tmp/video_part_%03d.mp3
# Her parçayı ayrı Whisper'a gönder, birleştir
# Tüm parçaları bitince: rm -f /tmp/video_part_*.mp3
```

DİNLE de başarısız → **SOR**.

---

## Kademe 3 — İZLE (Pahalı, Frame Analizi)

**Ne zaman kullanılır:**
- Transkript alındı ama konu görsel anlama gerektiriyor (grafik, demo, teknik görsel)
- Transkript hiç alınamadı ama video kritik
- Kendi kararın: içerik görsel bağlam olmadan tam anlaşılamıyorsa

**Kullanıcıya söyle:** "İçeriği tam anlamak için frame analizi yapıyorum, biraz token harcayacak."

```bash
# Video indir
yt-dlp -o /tmp/video_%(id)s.mp4 VIDEO_URL

# Süreye göre frame rate hesapla
DURATION=$(ffprobe -i /tmp/video_ID.mp4 -show_entries format=duration \
  -v quiet -of csv="p=0" | cut -d. -f1)

if [ $DURATION -le 30 ]; then FPS=1
elif [ $DURATION -le 180 ]; then FPS=0.5
else FPS=0.2
fi

# Max 100 frame (token bütçesi)
ffmpeg -i /tmp/video_ID.mp4 -vf "fps=${FPS}" \
  /tmp/frames_%03d.jpg -loglevel quiet

# Frame'leri analiz et (Claude Vision + transkript)
# Analiz bittikten sonra HEMEN temizle:
rm -f /tmp/video_ID.mp4 /tmp/frames_*.jpg
echo "Video ve frame'ler silindi ✓"
```

Frame'leri + transkripti birleştirerek → Orchester'a gönder.

---

## Kademe 4 — SOR

Her şey başarısız olduğunda:

```
Şu yöntemlerle erişmeye çalıştım ama olmadı:
- yt-dlp (altyazı, android client, cookies)
- jina.ai metin çıkarıcı
- Ses indirme + Groq Whisper

Seçeneklerin:
1. Transkripti kendin kopyala yapıştır
2. Video dosyasını yükle (lokal MP4)
3. Videonun konusunu anlat, oradan devam edelim
```

---

## İZLE Moduna Kendi Kararınla Geçme Kriterleri

Kullanıcı söylemese bile izle:
- İçerik görsel demo veya ekran kaydı ise
- Transkript aldın ama anlamak için "görmek" gerekiyorsa
- "Daha iyi anla / derinlemesine analiz et" gibi istekler

Transkript yeterliyse **asla** izleme — gereksiz token ve zaman.

---

## Desteklenen Platformlar
YouTube, TikTok, Twitter/X, Instagram, Vimeo, Loom, Dailymotion, Twitch VOD + 1000+ site

## Limitler
| Limit | Detay |
|-------|-------|
| En iyi sonuç | 10 dakika altı |
| Max frame | 100 |
| Max Whisper | 25 MB (~50dk mono ses) |
| Private içerik | Desteklenmiyor |

## Araçlar (VPS'te kurulu)
- `yt-dlp` v2026.03.17 → `/usr/local/bin/yt-dlp`
- `ffmpeg` → `/usr/bin/ffmpeg`
- `GROQ_API_KEY` → `~/.hermes/.env`
- Orchester API → `http://localhost:8006`

---

## Eski Skill'lerle İlişki
Bu skill `birkan-video-watch` + `birkan-ai-video` yerine geçer.
- `birkan-video-watch` → arşivde
- `birkan-ai-video` → arşivde (Mac path'leri içeriyordu)
