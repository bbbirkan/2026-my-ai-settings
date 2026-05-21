# Terminal Orchester v0.1 — 3 CLI Birbirine Bağlandı

> Öğrenilen tarih: 2026-05-19  
> Durum: v0.1 çalışıyor, `/root/2026-orchester/terminal_orchester.py`

## Vizyon

3 farklı AI CLI aracı birbirinin çıktısını alarak konuşuyor:
- **Claude Code CLI** (`claude -p`) → Anthropic Pro üyeliği
- **OpenCode CLI** (`opencode run`) → OpenCode Zen üyeliği, DeepSeek v4 Pro
- **Hermes CLI** (`hermes -z`) → OpenRouter üyeliği, GPT-5.5

**Sıfır API maliyeti** — hepsi flat-rate subscription.

## Headless Çalıştırma Komutları

```bash
# Claude — Pro üyelik, pipe'da çalışır
claude -p --dangerously-skip-permissions --output-format text "prompt"

# OpenCode — TTY gerektirir! script wrapper zorunlu
script -q -c "opencode run --dangerously-skip-permissions 'prompt'" /dev/null

# Hermes — -z flag ile direkt headless
hermes -z "prompt"
```

## Kritik Teknik Not: OpenCode TTY Sorunu

OpenCode pipe'a yazı yazmıyor — TTY algıladığında çalışıyor.
Çözüm: `script -q -c "..." /dev/null` ile pseudo-TTY oluştur.

Python asyncio'da:
```python
import shlex
cmd_str = f"opencode run --dangerously-skip-permissions {shlex.quote(prompt)}"
proc = await asyncio.create_subprocess_exec(
    "script", "-q", "-c", cmd_str, "/dev/null",
    stdout=asyncio.subprocess.PIPE, ...
)
```

Çıktı filtreleme: `>` ile başlayan satırlar (örn: `> build · deepseek-v4-pro`) meta bilgidir, filtrele.

## Orkestrasyon Modları

### PARALLEL (önerilen)
```
Görev → Claude + OpenCode (aynı anda) → Hermes sentezi → Final
```
3 API çağrısı, en hızlı, Hermes en güçlü sentezi yapar.

### CHAIN
```
Görev → Claude → OpenCode (Claude'u görür) → Hermes (ikisini görür) → Final
```
4 API çağrısı, sıralı, her ajan bir öncekini eleştirir.

### SEQUENTIAL
```
Görev → Hermes taslak → Claude + OpenCode eleştiri (paralel) → Hermes final
```
5 API çağrısı, en kapsamlı, Hermes kendi taslağını düzeltir.

## Örnek Çalıştırma

```bash
cd /root/2026-orchester
python3 terminal_orchester.py --mode parallel "Sorun veya görev"
python3 terminal_orchester.py --mode chain "Sorun veya görev"
python3 terminal_orchester.py --mode sequential "Sorun veya görev"
```

FastAPI olarak (port 8006):
```bash
uvicorn main:app --port 8006
# POST /debate {"task": "soru", "rounds": 1}  ← eski mod (claude -p x3)
```

Yeni terminal_orchester için ayrı endpoint eklenecek (v0.2).

## Mevcut Servisler ve Portlar

| Port | Servis | Dizin |
|------|--------|-------|
| 8000 | channel-router | `/root/2026-channel-router` |
| 8001 | visionwatch | `/root/2026-visionwatch` |
| 8002 | youtube-mini | `/root/2026-youtube-mini` |
| 8003 | yt-harvester | `/root/youtube-transcript-engine` |
| 8004 | medium-reader | `/root/2026-medium-reader` |
| 8005 | trello-agent | `/root/2026-hermes-trello-agent` |
| 8006 | orchester | `/root/2026-orchester` |

## Sonraki Adımlar (v0.2 için)

- [ ] `main.py`'ye `/orchestrate` endpoint ekle → terminal_orchester entegrasyonu
- [ ] 3 CLI'ın çıktılarını canlı stream et (WebSocket)
- [ ] Her CLI için timeout ve retry mantığı iyileştir
- [ ] Hermes'i Orkestratör olarak kullan: Hermes görevi bölsün, Claude + OpenCode'a versin
