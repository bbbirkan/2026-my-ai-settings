---
name: 2026-channel-router
description: |
  YouTube kanal analiz yönlendirici — VisionWatch veya YouTube Mini'ye trafik yönlendirir.
  Kanal URL'si ver → tüm videoları tara → her video için transkript + analiz → toplu rapor.
  FastAPI servisi, port 8000. YouTube ekosisteminin ana giriş noktası.

  TRIGGER bu skill'i şu durumlarda çağır:
  - YouTube kanal analizi, tüm videoları tarama istendiğinde
  - "channel-router", "kanal tara", "kanalın tüm videolarını analiz et" dendiğinde
  - VisionWatch ve YouTube Mini arasında yönlendirme mantığı sorulduğunda

version: 1.0.0
tags: [youtube, channel-analysis, routing, visionwatch, youtube-mini, fastapi]
---

# Channel Router — YouTube Channel Analysis Router

**Dizin:** `/root/2026-channel-router`
**Repo:** `github.com/bbbirkan/2026-channel-router`
**Port:** 8000

## Ne Yapar

YouTube kanal URL'si ver → kanal videolarını listele → her video için engine seçimi → toplu analiz raporu.

```
Kanal URL
    ↓
yt-dlp ile video listesi çek
    ↓
Her video için:
  - Derin analiz → VisionWatch (port 8001)
  - Hafif metadata → YouTube Mini (port 8002)
    ↓
Toplu rapor: {channel_name, results: [{url, title, description, transcript}]}
```

## API

```bash
# Kanal analizi başlat
curl -X POST http://localhost:8000/scrape \
  -H "Content-Type: application/json" \
  -d '{
    "channel_url": "https://youtube.com/@kanal",
    "max_videos": 20,
    "engine": "visionwatch"
  }'

# Sonuç al
curl http://localhost:8000/status

curl http://localhost:8000/health
```

## Response Formatı

```json
{
  "channel_name": "Kanal Adı",
  "channel_url": "https://youtube.com/@kanal",
  "engine": "visionwatch",
  "total": 20,
  "processed": 20,
  "results": [
    {
      "url": "...",
      "title": "...",
      "description": "...",
      "transcript": "..."
    }
  ]
}
```

## Kurulum

```bash
cd /root/2026-channel-router
pip install -r requirements.txt
uvicorn main:app --port 8000

# Veya launcher:
python launcher.py
```

## Env (Opsiyonel)

```
VISIONWATCH_URL=http://localhost:8001
YOUTUBE_MINI_URL=http://localhost:8002
```
