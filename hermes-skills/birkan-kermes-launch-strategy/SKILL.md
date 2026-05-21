---
name: birkan-kermes-launch-strategy
description: |
  Kermes projesinin GitHub/Product Hunt/Hacker News lansman stratejisi.
  Araştırmaya dayalı: OpenClaw (372K yıldız) rekabet analizi, boşluk tespiti,
  "subscription mode" positioning, lansman günü saat sıralaması, topluluk stratejisi.

  TRIGGER bu skill'i şu durumlarda çağır:
  - "kermes lansmanı", "nasıl büyütürüz", "github trending" konuşulduğunda
  - Product Hunt, Hacker News, Reddit lansman planı sorulduğunda
  - Kermes'in rakipleriyle karşılaştırması istendiğinde
  - "insanların kalbini kazanmak", "viral olmak" bahsedildiğinde
---

# Kermes Lansman Stratejisi

> Araştırma tarihi: 2026-05-19
> Kaynaklar: GitHub Trending verileri, Product Hunt playbook, HN launch guide

---

## Rekabet Haritası

| Araç | Odak | GitHub Yıldız | Kermes'e Tehdit |
|------|------|---------------|-----------------|
| **OpenClaw** | Kişisel AI asistan, 22+ platform, self-hosted | 372K+ ⭐ | Farklı segment — rakip değil |
| **LiteLLM** | 100+ provider proxy, unified interface | ~35K ⭐ | Doğrudan rakip |
| **RouteLLM** (UC Berkeley) | ML classifier ile model routing | ~15K ⭐ | Doğrudan rakip |
| **Bifrost** | Go tabanlı AI gateway, semantic cache | Yükselen | Doğrudan rakip |
| **Langfuse** | Cost observability (ClickHouse aldı) | Kurumsal | Tamamlayıcı |
| **Hermes** | Mesajlaşma hub, memory, skills | — | Temel/partner |

### OpenClaw Nedir?
- Peter Steinberger tarafından Kasım 2025'te başlatıldı
- 60 günde React'ı geçti — GitHub tarihinin en hızlı büyüyen projesi
- Özellikler: WhatsApp, Telegram, Discord, iMessage, Slack + 17 platform daha
- Self-hosted, 100% lokal, zero cloud
- Segment: Kişisel AI asistan. Kermes: maliyet optimizasyon katmanı. **Çakışmıyor.**

---

## Kermes'in Stratejik Boşluğu

**LiteLLM ve RouteLLM:** API → ucuz API routing. Token yine harcanır.

**Kermes:** Zaten ödediğin subscription'ı kullanır. **Sıfır ek token maliyeti.**

```
LiteLLM:   API ($$$) → Ucuz API ($)      — hâlâ para gider
Kermes:    Subscription (zaten ödendi) → claude -p / gemini / opencode → $0
```

**Tek cümle fark:**
> "LiteLLM ucuz API'ye yönlendirir. Kermes zaten ödediğin subscription'ı kullanır."

Bu cümle HN ve Reddit'te tartışma açar.

---

## Lansman Öncesi Hazırlık (2-3 hafta)

### 1. Demo GIF — En Kritik Adım
- `kermes stats` → önceki ay $87 → bu ay $31
- 15 saniyelik terminal kaydı
- Product Hunt gallery'sine ve README'ye ekle
- GIF olmadan Product Hunt'ta üst sıra çok zor

### 2. Blog Yazısı (HN için payload)
- Platform: dev.to veya kişisel site
- Başlık: *"I had $50/month in AI subscriptions and was still paying $240/month in API bills"*
- İçerik: Birkan'ın gerçek hikayesi + nasıl çözdüğü
- Bu yazı HN post'unun linki olacak

### 3. İlk 10 Beta Kullanıcı
- Hermes kullanıcı topluluğuna ulaş
- "Hermes kullanıyorsanız Kermes'i deneyin"
- Onların yorumları lansman günü silah olur
- Gerçek testimonial > her türlü marketing

### 4. README Kontrol Listesi
- [x] Hook: "Your AI subscriptions are sitting idle"
- [x] Kişisel hikaye: 10 günde $80
- [x] Gerçek sayılar: $87/ay → $31/ay
- [x] Karşılaştırma tabloları (Hermes, OpenCode)
- [ ] Demo GIF (henüz yok)
- [ ] `kermes stats` ekran görüntüsü (henüz yok)

---

## Lansman Günü Saat Sıralaması

**Gün: Salı** (araştırma: Salı en iyi gün — engineers check news before standup)
**Hafta: Ayın 2. veya 3. haftası**

```
00:01 PST  →  Product Hunt yükle (24 saatlik pencereyi tam kullan)
09:00 PST  →  Hacker News "Show HN:" post
09:30 PST  →  Reddit: r/LocalLLaMA + r/selfhosted + r/MachineLearning
10:00 PST  →  Twitter/X thread
12:00 PST  →  Discord/Slack toplulukları (Hermes, OpenCode, LiteLLM)
```

---

## Platform Başlıkları

### Hacker News
```
Show HN: Kermes – I was paying $240/mo in API costs while my subscriptions sat idle
```
- Teknik dil, sayıyla açılış
- Marketing dili yasak (HN kültürü)
- "Show HN:" prefix Show tab'a düşürür — daha az rekabet, daha uzun pencere
- Upvote isteme — HN algoritması voting ring'i tespit eder

### Product Hunt
**Tagline:** `Your AI subscriptions are sitting idle. Kermes puts them to work.`
**Gallery:** Demo GIF en başta, screenshots, ASCII maliyet tablosu
**Açıklama:** Kısa, fayda odaklı, sayılar öne

### Reddit Başlığı (r/LocalLLaMA)
```
Built a cost routing layer for Hermes: routes to claude -p/gemini/opencode subscriptions 
instead of burning API tokens. Went from $240/mo to $31/mo. Open source.
```

---

## İlk 48 Saat — Altın Pencere

- Her yoruma **1 saat içinde** cevap ver
- HN teknik sorularına **derinlemesine** yanıt (upvote çarpanı)
- "RouteLLM ile farkı ne?" sorusuna hazır cevap:
  > "RouteLLM routes between cheap and expensive APIs — you still pay per token. Kermes routes to your existing subscriptions. Zero extra token cost."
- Feature request gelirse: "added to roadmap" + GitHub issue aç
- İlk 48 saatte gelen feedback v0.2 roadmap'ını belirler

---

## Topluluk Hedefleri

| Platform | Hedef kitle | Mesaj |
|----------|-------------|-------|
| r/LocalLLaMA | Self-host, maliyet bilinçli | Subscription routing |
| r/selfhosted | Privacy, no-cloud | Local, Hermes entegre |
| r/MachineLearning | Teknik | RouteLLM karşılaştırması |
| HN | Senior devs, skeptic | Sayılar ve teknik detay |
| Product Hunt | Genel tech | Demo GIF, maliyet tasarrufu |
| Hermes Discord | Mevcut kullanıcılar | Drop-in upgrade |

---

## Zaman Çizelgesi

```
Şimdi         →  Geliştirme devam
Hazır olunca  →  Demo GIF + blog yazısı (1 hafta)
+1 hafta      →  10 beta kullanıcı + feedback
+1 hafta      →  Lansman Salı, koordineli tüm platformlar
+48 saat      →  Yorum yönetimi, momentum koru
+1 ay         →  v0.2: CLI subscription routing tam entegrasyon
```

---

## Birkan'ın Gerçek Hikayesi (lansman materyali)

```
Subscriptions ödendi:
  Claude Pro        $20/ay  ✓
  ChatGPT Plus      $20/ay  ✓
  Gemini Advanced   $10/ay  ✓
  ─────────────────────────
  Toplam            $50/ay  ✓ kontrol altında

10 günde API faturası:  $80
Tahmini aylık:          $240
─────────────────────────────
Boşa giden:             $190/ay
```

---

## Kaynaklar

- [OpenClaw GitHub](https://github.com/openclaw/openclaw)
- [Product Hunt Launch Playbook (30x #1)](https://dev.to/iris1031/product-hunt-launch-playbook-the-definitive-guide-30x-1-winner-1pbh)
- [How to launch a dev tool on Hacker News](https://www.markepear.dev/blog/dev-tool-hacker-news-launch)
- [RouteLLM — 85% cost reduction](https://github.com/topics/llm-cost-reduction)
- [Top AI Gateways 2026](https://www.getmaxim.ai/articles/top-5-ai-gateways-for-optimizing-llm-cost-in-2026/)
- [Token optimization saves up to 80%](https://www.obviousworks.ch/en/token-optimization-saves-up-to-80-percent-llm-costs/)
