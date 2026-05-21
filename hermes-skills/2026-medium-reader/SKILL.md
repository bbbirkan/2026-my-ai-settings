---
name: 2026-medium-reader
description: |
  Medium makale içerik çıkarıcı — YouTube transkript sistemine benzer.
  Birkan'ın paralı Medium üyeliği cookie'si ile paywalled makaleleri okur ve
  markdown formatında içerik döner. FastAPI servisi, port 8004.
  MEDIUM_SID ve MEDIUM_UID cookie'si gerektirir.

  TRIGGER bu skill'i şu durumlarda çağır:
  - Medium makale okuma, içerik çıkarma istendiğinde
  - "medium-reader", "medium makale çek", "medium paywall" dendiğinde
  - Makale içeriğini scrape/extract etmek istendiğinde

version: 1.0.0
tags: [medium, scraper, cookie-auth, fastapi, paywall, markdown]
---

# Medium Reader — Paywall Article Extractor

**Dizin:** `/root/2026-medium-reader`
**Repo:** `github.com/bbbirkan/2026-medium-reader`
**Port:** 8004

## Ne Yapar

Medium URL ver → cookie auth ile makaleye gir → BeautifulSoup ile parse et → markdownify ile dönüştür → zengin içerik JSON döner.

```
Medium URL
    ↓
Cookie auth (MEDIUM_SID + MEDIUM_UID)
    ↓
BeautifulSoup parse: başlık, yazar, tarih, okuma süresi, tag'ler
    ↓
markdownify ile markdown içerik
    ↓
{url, title, author, published_at, reading_time, tags, content, word_count, paywalled}
```

## Kurulum

```bash
cd /root/2026-medium-reader
cp .env.example .env

# Cookie'leri al:
# Chrome → F12 → Application → Cookies → medium.com
# "sid" ve "uid" değerlerini .env'e yapıştır:
MEDIUM_SID=...
MEDIUM_UID=...

pip install -r requirements.txt
uvicorn main:app --port 8004
```

## API

```bash
# Makale çek
curl -X POST http://localhost:8004/extract \
  -H "Content-Type: application/json" \
  -d '{"url": "https://medium.com/@yazar/makale-basligi"}'

curl http://localhost:8004/health
```

## Response Formatı

```json
{
  "url": "...",
  "title": "...",
  "author": "...",
  "published_at": "2026-05-10T10:00:00",
  "reading_time": 5,
  "tags": ["AI", "Python"],
  "content": "# Başlık\n\nMarkdown içerik...",
  "word_count": 1200,
  "paywalled": true
}
```

## Masaüstü Paket

```bash
bash build.sh
cp .env dist/.env
# dist/medium-reader → çift tıkla
```

## Önemli Not

Bu araç **okuyucu/scraper**'dır, **yazar değil**. YouTube transkript sistemi gibi çalışır:
URL ver → içeriği çek → markdown olarak sun.
