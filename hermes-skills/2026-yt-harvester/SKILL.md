---
name: 2026-yt-harvester
description: |
  YouTube transkript çıkarıcı — 4 planlı A→B→C→D fallback zinciri.
  Plan A: yt-dlp subtitle, Plan B: Groq Whisper API,
  Plan C: YouTube Data API v3, Plan D: Deeplx transkripsiyon.
  FastAPI servisi, port 8003. Masaüstü launcher mevcut.

  TRIGGER bu skill'i şu durumlarda çağır:
  - YouTube video transkripti, altyazı, içerik çıkarma istendiğinde
  - "yt-harvester", "nexus-1", "transkript al" dendiğinde
  - Whisper API, yt-dlp subtitle, fallback chain sorulduğunda

version: 1.0.0
tags: [youtube, transcript, whisper, yt-dlp, fastapi]
---

# YT Harvester — YouTube Transcript Engine

**Dizin:** `/root/youtube-transcript-engine`
**Repo:** `github.com/bbbirkan/youtube-transcript-engine`
**Port:** 8003

## Ne Yapar

YouTube URL'si ver → 4 planlı fallback zinciriyle transkript döner:

```
Plan A — yt-dlp subtitle (en hızlı, API key gereksiz)
    ↓ başarısız
Plan B — Groq Whisper API (ses indir → transkripsiyon)
    ↓ başarısız
Plan C — YouTube Data API v3 (resmi caption API)
    ↓ başarısız
Plan D — Deeplx transkripsiyon (son çare)
```

## API

```bash
# Transkript al
curl -X POST http://localhost:8003/transcript \
  -H "Content-Type: application/json" \
  -d '{"url": "https://youtube.com/watch?v=VIDEO_ID"}'

# Sağlık kontrolü
curl http://localhost:8003/health
```

## Kurulum & Çalıştırma

```bash
cd /root/youtube-transcript-engine/core
pip install -r requirements.txt
uvicorn main:app --port 8003

# Veya launcher ile (browser açar):
python launcher.py
```

## Masaüstü Paket

```bash
bash build.sh
cp .env dist/.env
# dist/yt-harvester → çift tıkla
```

## Kritik Kural

> yt-dlp PyInstaller bundle içine GÖMÜLMEMELİ — YouTube algoritmaları haftalık değişir.
> Her zaman sistem binary'sini kullan veya runtime'da indir.

## Response Formatı

```json
{
  "url": "...",
  "plan_used": "A",
  "transcript": "...",
  "language": "tr",
  "duration": 320
}
```
