---
name: 2026-youtube-mini
description: |
  Hafif YouTube metadata çekici — API key gerektirmez.
  Video URL ver → başlık, açıklama, kanal, süre, görüntüleme sayısı döner.
  FastAPI servisi, port 8002. Channel Router tarafından kullanılır.

  TRIGGER bu skill'i şu durumlarda çağır:
  - YouTube video metadata, başlık, açıklama, istatistik istendiğinde
  - "youtube-mini", "metadata çek", "API key olmadan YouTube" dendiğinde
  - Hızlı, hafif YouTube bilgisi gerektiğinde (analiz değil, sadece meta)

version: 1.0.0
tags: [youtube, metadata, lightweight, fastapi, no-api-key]
---

# YouTube Mini — Lightweight Metadata Extractor

**Dizin:** `/root/2026-youtube-mini`
**Repo:** `github.com/bbbirkan/2026-youtube-mini`
**Port:** 8002

## Ne Yapar

YouTube video veya kanal URL'si ver → yt-dlp ile metadata çeker → JSON döner.
API key gerektirmez. VisionWatch'tan daha hafif, sadece metadata.

## API

```bash
# Video metadata
curl -X POST http://localhost:8002/video \
  -H "Content-Type: application/json" \
  -d '{"url": "https://youtube.com/watch?v=VIDEO_ID"}'

# Kanal videoları listesi
curl -X POST http://localhost:8002/channel \
  -H "Content-Type: application/json" \
  -d '{"url": "https://youtube.com/@kanal", "max_videos": 10}'

curl http://localhost:8002/health
```

## Kurulum

```bash
cd /root/2026-youtube-mini
pip install -r requirements.txt
uvicorn main:app --port 8002

# Veya launcher:
python launcher.py
```

## Response Formatı

```json
{
  "url": "...",
  "title": "...",
  "description": "...",
  "channel": "...",
  "duration": 320,
  "view_count": 15000,
  "upload_date": "20260519"
}
```

## Channel Router ile İlişkisi

Channel Router (`port 8000`) hafif sorgular için YouTube Mini'yi,
derin analizler için VisionWatch'ı kullanır.
