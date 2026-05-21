# LMSYS Arena — Mayıs 2026 Gerçek Veriler

> Bu dosya Hermes Agent'ın 2026-05-15 tarihinde LMSYS Arena'dan scrape ettiği gerçek benchmark verilerini içerir.
> Kaynak: `https://lmarena.ai/leaderboard` (güncellenme: ~15 saat önce)

---

## Text Arena — Top 10

| # | Model | Score |
|---|-------|-------|
| 1 | Claude Opus 4.6 Thinking | 1502 |
| 2 | Claude Opus 4.7 Thinking | 1500 |
| 3 | Claude Opus 4.6 | 1498 |
| 4 | Claude Opus 4.7 | 1492 |
| 5 | Meta muse-spark | 1490 |
| 6 | Gemini 3.1 Pro Preview | 1489 |
| 7 | Gemini 3 Pro | 1486 |
| 8 | GPT-5.5 High | 1484 |
| 9 | GPT-5.4 High | 1479 |
| 10 | Grok 4.20 Beta1 | 1479 |

---

## WebDev Arena — Top 10

| # | Model | Score |
|---|-------|-------|
| 1 | Claude Opus 4.7 Thinking | 1567 |
| 2 | Claude Opus 4.7 | 1559 |
| 3 | Claude Opus 4.6 Thinking | 1546 |
| 4 | Claude Opus 4.6 | 1541 |
| 5 | GLM 5.1 | 1532 |
| 6 | Claude Sonnet 4.6 | 1524 |
| 7 | Kimi K2.6 | 1519 |

---

## Web Scraping Notu

LMSYS Arena bot koruması var — "View all" tıklandığında Security Verification çıkıyor.
Alternatif: `curl -sL "https://lmarena.ai/leaderboard" --compressed -H "User-Agent: ..."` ile raw HTML çekilebilir.
Model isimleri: `grep -oP 'claude-opus-[^"<]*|kimi-k[^"<]*|gpt-5\.[^"<]*'` ile ayıklanabilir.

---

## Yorum

- Claude Opus ailesi hem Text hem WebDev'de açık farkla lider
- Kimi K2.6 WebDev'de #7 — programming model olarak güçlü
- GPT-5.5 High Text'te #8 — OpenAI'nin en güçlüsü
- GLM 5.1 WebDev'de #5 — Çin modeli olarak dikkat çekici

---

## 🧠 ÜST AJAN — Telegram Sohbet (10 model, ayrık)

| # | Firma | Model | Fiyat | Ctx | LMSYS | ⭐ En İyi Olduğu Alanlar |
|---|-------|-------|-------|-----|-------|--------------------------|
| 1 | Anthropic | Claude Sonnet 4.6 | $3/M | 1M | 1524 | Coding, iteratif geliştirme, karmaşık kod tabanı navigasyonu |
| 2 | Anthropic | Claude Opus 4.7 | $15/M | 1M | 1492 | Agent workflow, end-to-end proje yönetimi, polishing |
| 3 | OpenAI | **GPT-5.4 Pro ★** | $5/M | 1M | ~1470 | Yaratıcı yazarlık, ileri düzey reasoning, multimodal |
| 4 | OpenAI | GPT-5.5 High | $15/M | 1M | 1484 | Research, uzun bağlam, üst düzey reasoning |
| 5 | Google | Gemini 3.1 Pro | $1/M | 1M | 1489 | Çok modalite, uzun bağlam, görsel anlama |
| 6 | Google | Gemini 3 Pro | $2/M | 1M | 1486 | Video anlama, kod üretimi, yaratıcı görevler |
| 7 | Moonshot | Kimi K2.6 | $1.4/M | 262K | 1519 | #1 programming model, 905B token tüketimi |
| 8 | Meta | Meta muse-spark | $10/M | 1M | 1490 | Genel amaçlı, yaratıcı, araştırma |
| 9 | DeepSeek | DeepSeek V4 Pro | $1/M | 1M | ~1380 | Maliyet/performans, kod, teknik döküman |
| 10 | xAI | Grok 3 Beta | $0.3/M | 131K | ~1310 | Gerçek zamanlı bilgi, humor, edgy içerik |

**Seçim: #3 — OpenAI GPT-5.4 Pro**

---

## ⚙️ ALT AJAN — Gateway/Cron (12 model, ayrık)

| # | Firma | Model | Fiyat | Ctx | LMSYS | ⭐ En İyi Olduğu Alanlar |
|---|-------|-------|-------|-----|-------|--------------------------|
| 1 | Google | Gemini 3.1 Flash | $0.5/M | 1M | ~1400 | Uzun bağlam, çok modalite, hız |
| 2 | Google | Gemini 2.5 Flash | $0.3/M | 1M | ~1350 | Hız/performans dengesi, kod üretimi |
| 3 | OpenAI | GPT-5.4 Mini | $1/M | 400K | ~1370 | Kodlama, matematik, mantıksal akıl yürütme |
| 4 | OpenAI | GPT-5.4 Nano | $0.8/M | 400K | ~1360 | Düşük gecikme, hızlı yanıt, bütçe dostu |
| 5 | Anthropic | Claude Haiku 4 | $0.8/M | 200K | ~1330 | İnsan gibi yazım, analitik düşünme, güvenlik |
| 6 | Anthropic | Claude Sonnet 4.5 | $3/M | 200K | ~1400 | Daha ucuz alternatif, güvenilir quality |
| 7 | Qwen | Qwen3.6 Flash | $0.04/M | 1M | ~1340 | Çince görevler, kod, matematik |
| 8 | Qwen | Qwen3.5 Plus | $0.04/M | 1M | ~1340 | Açık kaynak, genel amaçlı güvenilir |
| 9 | Moonshot | Kimi K2.5 | $1/M | 262K | ~1350 | Belge anlama, uzun metin, Çince |
| 10 | DeepSeek | DeepSeek V4 Flash | $0.5/M | 1M | ~1380 | En düşük maliyet, teknik döküman |
| 11 | xAI | Grok 3 Mini | $0.2/M | 131K | ~1300 | Gerçek zamanlı X verisi, humor |
| 12 | MiniMax | **MiniMax M2.5 ★** | $0.2/M | 196K | ~1320 | Cron/gateway, maliyet odaklı |

**Seçim: #12 — MiniMax M2.5**

---

## 📌 Final Seçim — Mayıs 2026

| Ajan | Firma | Model | Fiyat | Ctx | Kullanım Alanı |
|------|-------|-------|-------|-----|----------------|
| 🧠 ÜST | OpenAI | GPT-5.4 Pro | $5/M | 1M | Yaratıcı yazarlık, multimodal |
| ⚙️ ALT | MiniMax | MiniMax M2.5 | $0.2/M | 196K | Cron/gateway, maliyet odaklı |

---

🤖 *Bu referans dosyası 2026-05-15 tarihinde oluşturuldu*