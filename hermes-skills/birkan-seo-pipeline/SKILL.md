---
name: seo-pipeline
description: |
  Claude Code için 4 komutlu, veri odaklı tam SEO pipeline'ı.
  Marka sesi belirleme → fırsat bulma → brief oluşturma → makale yazma
  döngüsünü otomatize eder. Ahrefs, DataForSEO veya SEMrush entegrasyonu.

  TRIGGER bu skill'i şu durumlarda çağır:
  - SEO içerik üretimi istendiğinde
  - "anahtar kelime araştırması", "SERP analizi", "içerik brief" istendiğinde
  - "SEO yazısı yaz", "organik trafik" konuşulduğunda
  - /start-here, /find-opportunities, /create-brief, /write-content komutları girildiğinde
---

# SEO Pipeline — 4 Komutlu İçerik Makinesi

Kurulumdan yayına hazır makaleye kadar tam döngü SEO pipeline'ı.

**Kaynak:** https://github.com/seo-plugin/seo  
**Yerel:** `/Users/birkan/Desktop/Work /00 Github PROJELERI/seo/`

## 4 Komut, Tam Pipeline

```
/start-here       → Marka sesi + site profili + rakip analizi (bir kez)
/find-opportunities → Keyword fırsatları bul ve önceliklendir
/create-brief     → Seçilen fırsat için data-destekli brief
/write-content    → Brieften yayına hazır makale
```

## Komut Detayları

### `/start-here` — Kurulum (Bir Kez)
```
Üretir:
  brand/brand-voice.md      # Marka sesi profili
  brand/site-profile.md     # Domain metrikleri + keyword snapshot
  brand/competitors.md      # Rakip profilleri + keyword overlap

Gereksinim: Sadece WebFetch (yerleşik) — hiç API key gerekmez!
```

### `/find-opportunities` — Fırsat Keşfi
```
Üretir:
  campaigns/opportunities.md              # Sürekli büyüyen tracker
  campaigns/YYYY-MM-DD/daily-opportunities.html  # Günlük rapor

Gereksinim: Ahrefs, DataForSEO veya SEMrush (birini seç)
```

### `/create-brief` — Brief Oluşturma
```
Üretir:
  campaigns/YYYY-MM-DD/{slug}-brief.html   # Detaylı content brief
  campaigns/YYYY-MM-DD/screenshots/        # SERP ekran görüntüleri

Gereksinim: SEO data sağlayıcı + isteğe bağlı Firecrawl
```

### `/write-content` — Makale Yazımı
```
Üretir:
  campaigns/YYYY-MM-DD/{slug}-article.md  # CMS'e hazır markdown

Gereksinim: Brief (SEO data gerekmez)
```

## Kurulum Seviyeleri

| Hedef | Minimum Gereksinim |
|-------|-------------------|
| Marka sesi + site profili | Hiçbir şey (WebFetch yerleşik) |
| JS render + tam site haritası | Firecrawl MCP |
| Keyword araştırması + fırsatlar | Ahrefs, DataForSEO veya SEMrush |
| Tam pipeline | Firecrawl + SEO sağlayıcıdan biri |

Plugin hangi SEO sağlayıcının bağlı olduğunu **otomatik tespit eder.**

## Dahili Skill'ler

| Skill | Kapsam |
|-------|--------|
| `seo-analysis` | Keyword araştırması, SERP analizi, fırsat bulma |
| `brief-building` | Brief montajı, başlık yapısı, schema seçimi |
| `humanizer` | AI içeriği insan gibi yeniden yazma |
| `brand-voice` | Ses profili çıkarma |
| `reports` | HTML SEO raporları |

## Çıktı Klasörü Yapısı

```
brand/
├── brand-voice.md      (14 günlük cache)
├── site-profile.md     (7 günlük cache)
└── competitors.md      (14 günlük cache)

campaigns/
├── opportunities.md    (append-only tracker)
└── YYYY-MM-DD/
    ├── daily-opportunities.html
    ├── {slug}-brief.html
    ├── {slug}-article.md
    └── screenshots/
```
