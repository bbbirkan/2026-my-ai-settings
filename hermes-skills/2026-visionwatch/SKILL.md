---
name: 2026-visionwatch
description: |
  YouTube video içerik analiz motoru — Claude Vision + Groq Whisper API.
  Video URL ver → transkript + görsel analiz → içerik özeti + öneriler döner.
  FastAPI servisi, port 8001. ANTHROPIC_API_KEY ve GROQ_API_KEY gerektirir.

  TRIGGER bu skill'i şu durumlarda çağır:
  - YouTube video analizi, içerik incelemesi istendiğinde
  - "visionwatch", "video analiz", "video ne anlatıyor" dendiğinde
  - Claude Vision + video içerik pipeline sorulduğunda

version: 1.0.0
tags: [youtube, video-analysis, claude-vision, groq, fastapi]
---

# VisionWatch — YouTube Video Content Analyzer

**Dizin:** `/root/2026-visionwatch`
**Repo:** `github.com/bbbirkan/2026-visionwatch`
**Port:** 8001

## Ne Yapar

YouTube URL ver → video indir → Groq Whisper ile transkripsiyon → Claude Vision ile analiz → içerik raporu.

```
YouTube URL
    ↓
yt-dlp ile video/ses indir
    ↓
Groq Whisper API → transkript
    ↓
Claude Vision + transkript → analiz
    ↓
{özet, temalar, öneriler, timestamp'ler}
```

## Gerekli Env

```
ANTHROPIC_API_KEY=...   # Claude Vision için
GROQ_API_KEY=...        # Whisper transkripsiyon için
```

## API

```bash
# Video analiz et
curl -X POST http://localhost:8001/analyze \
  -H "Content-Type: application/json" \
  -d '{"url": "https://youtube.com/watch?v=VIDEO_ID"}'

curl http://localhost:8001/health
```

## Kurulum

```bash
cd /root/2026-visionwatch
cp .env.example .env
# .env'e ANTHROPIC_API_KEY ve GROQ_API_KEY ekle
pip install -r requirements.txt
uvicorn main:app --port 8001

# Veya launcher:
python launcher.py
```

## Masaüstü Paket

```bash
bash build.sh
cp .env dist/.env
# dist/visionwatch → çift tıkla
```
