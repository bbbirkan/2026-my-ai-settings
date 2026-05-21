---
name: 2026-hermes-trello-agent
description: |
  Haftalık Trello AI ajanı — Pazartesi 09:00'de otomatik çalışır.
  Trello listesindeki kartları Claude ile analiz eder, her kart için eylem belirler
  (ARAŞTIR|YAZ|PLANLA|KOD|GEÇER), çalışmayı yapar, karta yorum ekler, Telegram'a rapor gönderir.
  FastAPI servisi, port 8005. TRELLO_API_KEY, TRELLO_TOKEN ve ANTHROPIC_API_KEY gerektirir.

  TRIGGER bu skill'i şu durumlarda çağır:
  - Trello otomasyon, haftalık kart analizi istendiğinde
  - "trello-agent", "trello AI", "kartları analiz et" dendiğinde
  - APScheduler cron, haftalık ajan raporu sorulduğunda

version: 1.0.0
tags: [trello, ai-agent, weekly-automation, telegram, fastapi, apscheduler, claude]
---

# Hermes Trello Agent — Weekly AI Card Processor

**Dizin:** `/root/2026-hermes-trello-agent`
**Repo:** `github.com/bbbirkan/2026-hermes-trello-agent`
**Port:** 8005

## Ne Yapar

```
Pazartesi 09:00 (otomatik) veya POST /run (manuel)
    ↓
TRELLO_LIST_ID'deki tüm kartları çek
    ↓
Her kart için Claude analiz: ARAŞTIR | YAZ | PLANLA | KOD | GEÇER
    ↓
Belirlenen eylemi gerçekleştir
    ↓
Trello kartına AI çalışma yorumu ekle
    ↓
Telegram'a haftalık rapor gönder
```

## Dosya Yapısı

- `main.py` — FastAPI + APScheduler (Pazartesi 09:00 cron)
- `trello.py` — Trello API client (kartlar, yorumlar, listeler)
- `agent.py` — Claude analiz + eylem motoru
- `telegram.py` — Haftalık rapor gönderici
- `launcher.py` — Masaüstü başlatıcı (port 8005 → browser)
- `build.sh` — PyInstaller masaüstü paketi

## Kurulum

```bash
cd /root/2026-hermes-trello-agent
cp .env.example .env
# .env doldur (aşağıya bak)
pip install -r requirements.txt
uvicorn main:app --port 8005
```

## Gerekli Env

```
TRELLO_API_KEY=...       # trello.com/app-key
TRELLO_TOKEN=...         # trello.com/app-key → Token oluştur
TRELLO_BOARD_ID=...      # trello.com/b/BOARD_ID/...
TRELLO_LIST_ID=...       # GET /lists endpoint'inden bul
ANTHROPIC_API_KEY=...    # Claude analiz için
TELEGRAM_BOT_TOKEN=...   # Opsiyonel — rapor için
TELEGRAM_CHAT_ID=...     # Opsiyonel — rapor için
```

## API

```bash
# Manuel çalıştır
curl -X POST http://localhost:8005/run

# Son çalışma sonucu
curl http://localhost:8005/status

# Board listelerini gör (TRELLO_LIST_ID bulmak için)
curl http://localhost:8005/lists

curl http://localhost:8005/health
```

## Trello ID Nasıl Bulunur

**Board ID:** `https://trello.com/b/BOARD_ID/board-name` → BOARD_ID al

**List ID:** Servis çalışırken:
```bash
curl http://localhost:8005/lists
```

## Masaüstü Paket

```bash
bash build.sh
cp .env dist/.env
# dist/trello-agent → çift tıkla
```
