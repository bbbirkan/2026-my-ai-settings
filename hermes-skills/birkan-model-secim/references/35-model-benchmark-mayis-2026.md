# 35 Model Benchmark Verileri — Mayıs 2026
> Bu dosya Birkan'ın sağladığı gerçek benchmark verilerini içerir. Her ay başı güncellenir.
> Kaynak: LMSYS Arena · LiveBench · SWE-bench · Artificial Analysis · OpenRouter API · Stanford HAI 2026

---

## 🧠 ÜST AJANLAR — 15 Model (Kalite Odaklı)

| # | Firma | Model | $/M in | $/M out | Ctx | Text ELO | WebDev ELO | LiveBench | SWE-bench | ⭐ En İyi Olduğu Alanlar |
|---|-------|-------|--------|---------|-----|---------|-----------|---------|---------|--------------------------|
| 1 | Anthropic | Claude Opus 4.7 ★ | $5.00 | $25.00 | 1M | 1500 | 1567 | 83.5% | 87.6% | Karmaşık otonom süreçler, adaptive thinking, hata öngörü |
| 2 | Anthropic | Claude Sonnet 4.6 | $3.00 | $15.00 | 1M | 1468 | 1524 | 76.1% | 77.4% | Günlük mimari kodlama, PR inceleme, kurumsal RAG |
| 3 | OpenAI | GPT-5.5 | $5.00 | $30.00 | 1.1M | 1484 | 1501 | 80.7% | 82.6% | Görsel-mantıksal akıl yürütme, terminal otomasyonu |
| 4 | Google | Gemini 3.1 Pro | $2.00 | $12.00 | 1M | 1489 | 1450 | 79.9% | 78.8% | Uygun maliyetli frontier zeka, çok modlu analiz |
| 5 | DeepSeek | DeepSeek V4 Pro | $1.74 | $3.48 | 1M | 1459 | 1458 | 89.8% | 80.6% | Açık ağırlıklı otonom kodlama, MoE 1.6T parametre |
| 6 | xAI | Grok 4.20 | $2.00 | $6.00 | 2M | 1476 | 1397 | 87.0% | N/A | 2M bağlamda kurumsal araştırma, X veri çapraz analiz |
| 7 | Alibaba | Qwen 3.6 Max | $1.04 | $6.24 | 262K | 1458 | 1491 | 76.7% | ~70% | Çok dilli Asya/Avrupa akıl yürütme, Python/C++ kod |
| 8 | Z.ai | GLM-5.1 | $1.40 | $4.40 | 203K | 1472 | 1532 | 72.5% | 58.4% | Döngüsel kodlama, frontend UI tasarımı, repo yönetimi |
| 9 | Moonshot | Kimi K2.6 | $0.95 | $4.00 | 262K | 1461 | 1519 | 89.6% | 80.2% | 200+ tool calling, ajan orkestrasyonu |
| 10 | Xiaomi | MiMo-V2.5-Pro | $1.00 | $3.00 | 1M | 1463 | 1472 | 60.1% | 54.0% | Donanım/OS ajan orkestrasyonu, düşük gecikmeli süreçler |
| 11 | Meta | Muse Spark | N/A | N/A | N/A | 1490 | 1509 | N/A | N/A | Kapalı ekosistem metin üretimi, görsel mantık sentezi |
| 12 | Mistral | Mistral Large 3 | $0.50 | $1.50 | 128K | N/A | 1223 | N/A | N/A | Sovereign RAG sistemleri, lokal veritabanı sorgulama |
| 13 | MiniMax | MiniMax M2.7 | $0.28 | $1.20 | 196K | 1407 | 1407 | N/A | 75.4% | İleri düzey NPC diyalogları, dinamik hikaye üretimi |
| 14 | Baidu | Ernie 5.1 | N/A | N/A | N/A | 1472 | N/A | N/A | N/A | Çin/Asya regülasyon uyumlu metin analizi |
| 15 | ByteDance | Seed 2.0 Pro | N/A | N/A | N/A | 1456 | N/A | N/A | N/A | Sosyal medya algoritmaları, çok modlu veri işleme |

---

## ⚙️ ALT AJANLAR — 20 Model (Maliyet + Hız Odaklı)

| # | Firma | Model | $/M in | $/M out | Ctx | Text ELO | WebDev ELO | LiveBench | SWE-bench | Mlyt/Görev | ⭐ En İyi Olduğu Alanlar |
|---|-------|-------|--------|---------|-----|---------|-----------|---------|---------|-----------|--------------------------|
| 1 | OpenAI | GPT-5.4 Mini | $0.75 | $4.50 | 400K | 1455 | 1399 | N/A | 23.6% | ~$0.022 | Sistem yönlendirme, müşteri hizmetleri botları, JSON manipülasyonu |
| 2 | Google | Gemini 3 Flash | $0.50 | $3.00 | 1M | 1473 | 1437 | N/A | 35.0% | ~$0.015 | 1M bağlamda hızlı belge ayrıştırma, video zaman damgası |
| 3 | DeepSeek | DeepSeek V4 Flash ★ | $0.13 | $0.25 | 1M | 1434 | 1368 | 91.6% | 44.0% | ~$0.002 | Devasa log analizi, RAG indeksleme (EN İYİ FİYAT) |
| 4 | xAI | Grok 4.3 | $1.25 | $2.50 | 1M | 1454 | 1389 | 53.2% | N/A | ~$0.020 | Gerçek zamanlı akış verisi, X corpus trend analizi |
| 5 | Alibaba | Qwen 3.6 Plus | $0.33 | $1.95 | 1M | 1446 | 1460 | N/A | 56.6% | ~$0.009 | Boilerplate kod üretimi, çok dilli anlamsal çıkarım |
| 6 | Z.ai | GLM-4.7 | $0.40 | $1.75 | 203K | 1443 | 1440 | 84.9% | N/A | ~$0.009 | Hızlı frontend prototipleme, web uygulaması iskelesi |
| 7 | Moonshot | Kimi K2.5 | $0.40 | $1.90 | 262K | 1432 | 1408 | 85.0% | 76.8% | ~$0.010 | Orta katman araç kullanımı, ağ geçidi sınıflandırma |
| 8 | Xiaomi | MiMo-V2-Flash | $0.10 | $0.30 | 262K | 1337 | N/A | N/A | N/A | ~$0.002 | Uç cihaz veri ayrıştırma, IoT/mobil komut işleme |
| 9 | NVIDIA | Nemotron 3 Super | $0.10 | $0.50 | 262K | N/A | N/A | 63.2% | 25.0% | ~$0.002 | 214 token/sn GPU hızlandırmalı terminal otomasyonu |
| 10 | Inception AI | Mercury 2 | $0.25 | $0.75 | 128K | N/A | 1165 | N/A | N/A | ~$0.005 | 919 token/sn — kesintisiz gerçek zamanlı sesli asistanlar |
| 11 | IBM | Granite 4.1-8B | $0.05 | $0.10 | 131K | N/A | 1199 | N/A | N/A | ~$0.001 | Kurumsal veri yönetişimi, regülasyon analizi |
| 12 | Poolside | Laguna M.1 | N/A | N/A | 131K | N/A | N/A | N/A | 72.5% | N/A | Kapalı ağlarda alana özgü kod asistanlığı |
| 13 | Mistral | Mistral Medium 3.5 | $1.75 | $5.25 | 256K | N/A | N/A | N/A | N/A | ~$0.034 | GDPR uyumlu sentetik metin sınıflandırması |
| 14 | Upstage | Solar Pro 3 | $0.15 | $0.60 | 128K | N/A | N/A | 26.0% | N/A | ~$0.003 | Asya dilleri hızlı OCR, form yapısı çıkarımı |
| 15 | Arcee AI | Trinity-Large | $0.22 | $0.85 | 262K | N/A | 1245 | N/A | 63.2% | ~$0.005 | Alana özgü ince ayar, yapısal kod dizimi düzeltmeleri |
| 16 | KwaiKAT | KAT-Coder Pro | $0.21 | $0.83 | 256K | N/A | 1258 | N/A | N/A | ~$0.005 | Kod editörü içi anlık otomatik tamamlama |
| 17 | LiquidAI | LFM-2-24B | $0.03 | $0.12 | 33K | N/A | N/A | N/A | N/A | ~$0.001 | Ultra-ucuz state-space modelleme, sabit bellek izi |
| 18 | Anthropic | Claude Haiku 4 | $1.00 | $5.00 | 200K | ~1330 | N/A | N/A | N/A | ~$0.015 | Köprü yönlendirici, kararlı JSON çıktı |
| 19 | Anthropic | Claude Sonnet 4.5 | $3.00 | $15.00 | 200K | ~1400 | N/A | N/A | N/A | ~$0.045 | Düşük maliyetli kurumsal RAG |
| 20 | Baidu | Ernie 5.0 | N/A | N/A | N/A | 1450 | N/A | N/A | N/A | N/A | Çince legacy sistem entegrasyonu |

---

## ✅ Final Seçim — Mayıs 2026

| Ajan | Model | $/M in | $/M out | Context | Text ELO | WebDev ELO | SWE-bench | Kullanım |
|------|-------|--------|---------|---------|---------|-----------|---------|---------|
| 🧠 **ÜST** | Claude Opus 4.7 | $5.00 | $25.00 | 1M | 1500 | 1567 | 87.6% | Telegram / Karmaşık Görevler |
| ⚙️ **ALT** | DeepSeek V4 Flash | $0.13 | $0.25 | 1M | 1434 | 1368 | 44.0% | Gateway / Cron / RAG |

---

## 🎨 PDF Tasarım Notları (ÖNEMLİ)

### Kolon Genişlikleri — Doğru Değerler
**ÜST AJAN tablosu:**
```
cw2 = [0.4*cm, 1.8*cm, 2.4*cm, 0.85*cm, 0.85*cm, 0.7*cm, 1.1*cm, 1.2*cm, 1.1*cm, 1.1*cm, 4.35*cm]
      #  |Firma |Model   |$/M in|$/M out|Ctx   |Text   |WebDev |Live  |SWE   |⭐
```

**ALT AJAN tablosu:**
```
cw3 = [0.35*cm, 1.6*cm, 2.0*cm, 0.75*cm, 0.75*cm, 0.7*cm, 1.0*cm, 1.1*cm, 1.0*cm, 0.9*cm, 1.2*cm, 4.5*cm]
      #   |Firma |Model  |$/M in|$/M out|Ctx  |Text   |WebDev |Live  |SWE   |Mlyt |⭐
```

**KRİTİK KURAL:** Firma kolonu minimum 1.6cm olmalı — "Anthropic", "DeepSeek", "ByteDance" gibi isimler sığmalı. Model kolonu 2.0cm+ olmalı. İkisi ayrık yazılmalı (firma + model AYRI hücrede, üst üste BINMEMELİ).

### PDF Sayfa Düzeni
- **Sayfa 1:** Kapak — vitrin kartları (Text ELO, WebDev ELO, SWE-bench, Maliyet/Görev), radar dekorasyonu, gradient arka plan
- **Sayfa 2:** ÜST AJANLAR tablosu — 15 model, renk kodlu kolonlar
- **Sayfa 3:** ALT AJANLAR tablosu — 20 model, mor/kırmızı tema  
- **Sayfa 4:** FİNAL SEÇİM — iki büyük kutu (ÜST + ALT), metrikler, stratejik notlar

### Renk Kodlaması (Sabit)
- 🔵 **Cyan** (`#00d4ff`) → Text Arena ELO
- 🟡 **Amber** (`#ffb800`) → WebDev Arena ELO
- 🟣 **Magenta** (`#e03997`) → LiveBench
- 🟢 **Emerald** (`#00c875`) → SWE-bench
- 🔴 **Crimson** (`#ff3366`) → Maliyet / Maliyet-Görev
- ⚪ **White** → Model adı (bold)
- ⬛ **Soluk gri** → Firma adı (soluk, sola hizalı)

### Tasarım Felsefesi — "Frontier Matrix"
- Arka plan: derin koyu lacivert (#0a0f1e)
- Sol kenar dekoratif şerit (cyan + magenta)
- Kartlar: koyu gri (#111827), renkli üst şerit
- Radar/grafik elementleri: sayfa 1'de görsel merak
- Tablolar: her satır alternatif arka plan, seçili satır yeşil highlight

---

## 📌 Stratejik Notlar

- 100 ELO fark = ~%64 kazanma ihtimali | 200 ELO fark = ~%76 kazanma ihtimali
- Thinking tokenler = hidden reasoning tokens — çıktı olarak fatura edilir
- DeepSeek V4 Flash çıktı maliyeti $0.25 — GPT-5.5 çıktı maliyeti $30.00 (120 kat fark!)
- Ücretsiz modeller pas geçildi — güvenilirlik endişesi (Birkan kararı)
- Her firma max 2 model kuralı — ÜST ve ALT listeler ayrık (disjoint)