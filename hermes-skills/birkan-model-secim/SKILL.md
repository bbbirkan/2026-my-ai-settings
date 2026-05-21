---
name: birkan-model-secim
description: "Birkan için aylık AI model seçim kararı — 60+ benchmark sitesinden gerçek verilerle deep research, profesyonel PDF tablo oluşturur. Sadece PDF atar, Telegram'a mesaj yazmaz. Her ay başı çalışır. Her firmadan max 2 model kuralı."
trigger:
  - "Haziran model seçeceğiz"
  - "model secim"
  - "PDF model"
  - "aylık model"
  - "model seçimi"
  - "benchmark"
  - "deep research"
  - "model güncelle"
  - "siteleri tara"
---

# 🤖 Birkan Model Seçim Skill'i (v4 — Deep Research Edition)

Bu skill, Birkan'ın her ay başı talep ettiği AI model seçim sürecini tam otomasyonla çalıştırır. Sadece PDF oluşturur ve atar — Telegram'a mesaj yazmaz.

> **Kaynak:** Bu skill, Birkan'ın sağladığı 2026 benchmark rehberi ile oluşturulmuştur. 60+ benchmark sitesi, 8 kategori, tam metodoloji dahil.

---

## 🔄 Çalışma Formatı (Deep Research Döngüsü)

### ⚠️ ÖNEMLİ — Model İsimlendirme Sistemi (2026-05-15)
Kullanıcı model seçerken "3 numaralı model" gibi PDF tablo satır numaralarını kullanır.
Bu numaralar TABLO SATIRI numarasıdır — model ID değil!

**ÜST Model Sıralaması (Kalite):**
| Tablo Satırı | Model | Özellik |
|--------------|-------|---------|
| 3 | GPT-5.5 | LiveBench %80.7 — en yüksek |
| 2 | Claude Opus 4.6 | SWE-bench %75.6 |
| 7 | DeepSeek V4 Pro | $0.55/$2.75, açık ağırlıklı |
| 1 | Claude Opus 4.7 | Acil durum için |

**ALT Model Sıralaması (Maliyet):**
| Tablo Satırı | Model | Özellik |
|--------------|-------|---------|
| 7 | GLM-4.7 | LiveBench %84.9, $0.40/$1.75 |
| 1 | Gemini 3 Flash | SWE-bench %75.8, $0.15/$0.60 |
| 2 | MiniMax M2.5 | %75.8 SWE-bench, $0.05/$0.20 |
| 8 | DeepSeek V4 Flash | 1M context, $0.13/$0.25 |

### ⚠️ Memory Format Kuralı (KRİTİK!)
- Memory'ye yazarken TEMİZ, OKUNABİLİR format kullan
- Sıkıştırılmış/abbrevie edilmiş format KABUL EDİLMEZ
- Örnek KÖTÜ: `ÜST1=GPT-5.5($2.50/$10·liveb80.7%)`
- Örnek İYİ:
  ```
  ÜST (Kalite):
    1) GPT-5.5 — $2.50 / $10 — LiveBench %80.7
    2) Claude Opus 4.6 — $3 / $15 — SWE-bench %75.6
  ```
- Kullanıcı "okunmuyor" dedi = anında düzelt

### ADIM 1 — Deep Research Prompt Üret
Birkan "model seçimi yapalım" dediğinde, bu prompt'u kullan:

```
Aşağıdaki 60+ benchmark sitesinden gerçek verileri çekerek TÜRKÇE bir rapor hazırla.
Tüm sayıları doğrula — kafadan yazma.

ÜST AJAN (15 model) + ALT AJAN (20 model) = 35 model

Her model için şu verileri topla:
1. Model tam adı ve ID
2. Input fiyat ($/M token) — OpenRouter veya model provider sitesinden
3. Output fiyat ($/M token)
4. Context length (token)
5. LMSYS Text Arena ELO skoru (lmarena.ai/leaderboard)
6. LMSYS WebDev Arena ELO skoru
7. LiveBench genel skoru (livebench.ai)
8. SWE-bench Verified % çözülme oranı (swebench.com)
9. Intelligence Index v4.0 (artificialanalysis.ai)
10. ⭐ En iyi olduğu 2-3 alan (açıklamayla)

ALT AJANLAR için + ortalama maliyet/görev (varsa)

ŞARTLAR:
- Sadece ücretli modeller (ücretsiz modelleri PAS GEÇ)
- Her firmadan max 2 model
- ÜST ve ALT listeleri ayrık olmalı (ortak model YOK)
- ⭐ sütunu: her modelin gerçekten en iyi olduğu alanlar
- Türkçe raporla
- Sayıları mümkün olduğunca doğrula (birden fazla kaynaktan kontrol et)
```

### ADIM 2 — Browser ile Taramasını Yaptır
Subagent'lara paralel tarama yaptır:

```python
delegate_task([
    # 1. LMSYS ELO skorları
    {"goal": "lmarena.ai/leaderboard → Text Arena TOP 20 + WebDev Arena TOP 20 ELO skorları"},
    # 2. LiveBench + SWE-bench
    {"goal": "livebench.ai genel skorlar + swebench.com verified oranları"},
    # 3. Artificial Analysis fiyat/hız
    {"goal": "artificialanalysis.ai fiyat/hız + Intelligence Index v4.0"},
    # 4. OpenRouter anlık fiyatlar
    {"goal": "openrouter.ai/models → TOP modellerin anlık $/M fiyatları"},
    # 5. Ek benchmark siteleri (URL listesinden 5-10 tanesi)
    {"goal": "Tarama listesi: codesota.com, arcprize.org, lastexam.ai, epoch.ai/frontiermath, mmmu-benchmark.github.io, mathvista.github.io, webarena.dev, jykoh.com/vwa, os-world.github.io"},
    # 6. Agent/Tool benchmarkları
    {"goal": "AgentBench, tau-bench, MLE-bench, GAIA leaderboard"},
    # 7. Safety/Trust benchmarkları
    {"goal": "AILuminate, TrustLLM, HarmBench, HELM safety"}
])
```

### ADIM 3 — Verileri Kontrol Et
- Toplanan verilerde tutarsızlık varsa tekrar tarama yap
- "% kaç başarı" gibi tutarsız verileri elem
- Emin olmadığın verileri "N/A" olarak işaretle

### ADIM 4 — PDF Oluştur
execute_code ile ReportLab PDF oluştur (kod aşağıda).

### ADIM 5 — Telegram'a PDF At
send_message action='send' target='telegram' message='MEDIA:/path/to/file.pdf'

---

## 🔗 60+ Benchmark Sitesi (Tam Liste — Birkan'dan Alınan)

> Bu liste deep research için kullanılacak. Tüm URL'ler browser ile taranabilir.

### 🎯 LMSYS / Arena Sistemleri
| # | Site | URL | Odak |
|---|------|-----|------|
| 1 | **LMArena** | lmarena.ai | ELO skorları (Text, WebDev, Code Arena) |
| 2 | **LMArena Chatbot** | huggingface.co/spaces/lmarena-ai/chatbot-arena | Canlı karşılaştırma |
| 3 | **Artificial Analysis** | artificialanalysis.ai | Intelligence Index v4.0, fiyat/hız, TPS |
| 4 | **AA Models** | artificialanalysis.ai/models | Model detayları |
| 5 | **AA Leaderboards** | artificialanalysis.ai/leaderboards/providers | Sağlayıcı sıralaması |
| 6 | **AA Methodology** | artificialanalysis.ai/methodology | Metodoloji açıklaması |
| 7 | **AA LiveCodeBench** | artificialanalysis.ai/evaluations/livecodebench | Kod benchmark |
| 8 | **AA GPQA Diamond** | artificialanalysis.ai/evaluations/gpqa-diamond | GPQA detayları |
| 9 | **AA HLE** | artificialanalysis.ai/evaluations/humanitys-last-exam | Son sınav |
| 10 | **AA AIME** | artificialanalysis.ai/evaluations/aime | Olimpiyat matematiği |
| 11 | **AA LCR** | artificialanalysis.ai/evaluations/aa-lcr | Language understanding |
| 12 | **AA Image** | artificialanalysis.ai/image | Görsel üretim |
| 13 | **AA Image Models** | artificialanalysis.ai/image/models | Görsel model detayları |
| 14 | **AA Video Leaderboard** | artificialanalysis.ai/video/leaderboard/text-to-video | Video üretim |
| 15 | **LiveBench** | livebench.ai | Kirlenme-dirençli akademik |
| 16 | **LiveBench PDF** | livebench.ai/livebench.pdf | Teknik doküman |

### 📊 Model Karşılaştırma & Fiyat Platformları
| # | Site | URL | Odak |
|---|------|-----|------|
| 17 | **LLM-Stats** | llm-stats.com | Bileşik skor |
| 18 | **LLM-Stats Leaderboard** | llm-stats.com/leaderboards/llm-leaderboard | Model sıralaması |
| 19 | **LLM-Stats Open LLM** | llm-stats.com/leaderboards/open-llm-leaderboard | Açık modeller |
| 20 | **BenchLM** | benchlm.ai | 230+ model × 190+ benchmark |
| 21 | **Vellum** | vellum.ai/llm-leaderboard | Frontier karşılaştırma |
| 22 | **Onyx** | onyx.app/llm-leaderboard | Tier görünümü |
| 23 | **HF Open LLM** | huggingface.co/spaces/open-llm-leaderboard/open_llm_leaderboard | Açık LLM arşiv |
| 24 | **HF Open LLM Docs** | huggingface.co/docs/leaderboards/en/open_llm_leaderboard/archive | Dokümantasyon |
| 25 | **HF OpenEvals Archive** | huggingface.co/collections/OpenEvals/archived-open-llm-leaderboard-2024-2025 | Arşiv 2024-25 |
| 26 | **HF MMLU-Pro** | huggingface.co/spaces/TIGER-Lab/MMLU-Pro | MMLU-Pro |
| 27 | **HF Open ASR** | huggingface.co/spaces/hf-audio/open_asr_leaderboard | Konuşma tanıma |
| 28 | **HF TTS Arena** | huggingface.co/spaces/TTS-AGI/TTS-Arena-V2 | Text-to-speech |
| 29 | **HF LLM Perf** | huggingface.co/spaces/ArtificialAnalysis/LLM-Performance-Leaderboard | Performans |
| 30 | **HF OpenVLM** | huggingface.co/spaces/opencompass/open_vlm_leaderboard | Vizyon modelleri |
| 31 | **HF GAIA** | huggingface.co/spaces/gaia-benchmark/leaderboard | GAIA agent |
| 32 | **HF Blog AA** | huggingface.co/blog/leaderboard-artificial-analysis | Blog |
| 33 | **PricePerToken** | pricepertoken.com | Anlık fiyatlar |
| 34 | **OpenRouter Rankings** | openrouter.ai/rankings | Popülarite sıralaması |
| 35 | **OpenRouter API** | openrouter.ai/api/v1/models | Model listesi + fiyat |
| 36 | **iInternal AI** | iternal.ai/llm-selection-guide | LLM seçim rehberi |
| 37 | **AwesomeAgents** | awesomeagents.ai/leaderboards/audio-understanding-benchmarks-leaderboard | Agent benchmarkları |
| 38 | **CodeSOTA Code-Gen** | codesota.com/code-generation | Kod üretimi SOTA |
| 39 | **CodeSOTA LLM** | codesota.com/llm | LLM karşılaştırma |
| 40 | **CodeSOTA Speech** | codesota.com/speech | Konuşma SOTA |

### 🧮 Kodlama & Yazılım Mühendisliği Benchmarkları
| # | Site | URL | Odak |
|---|------|-----|------|
| 41 | **SWE-bench Live** | swe-bench-live.github.io | GitHub issue çözme (canlı) |
| 42 | **SWE-bench** | swebench.com | SWE-bench ana sayfa |
| 43 | **Scale Leaderboard** | labs.scale.com/leaderboard | Scale SEAL |
| 44 | **Scale HLE** | labs.scale.com/leaderboard/humanitys_last_exam | Son sınav |
| 45 | **LiveCodeBench** | livecodebench.github.io | Kod benchmark (canlı) |
| 46 | **Aider Leaderboard** | aider.chat/docs/leaderboards | Polyglot kod |
| 47 | **T-Bench** | tbench.ai | Terminal benchmark |
| 48 | **BigCodeBench** | bigcode-bench.github.io | Pratik kod |
| 49 | **CodeSOTA** | codesota.com/code-generation | Kod SOTA |
| 50 | **MorphLLM SWE-Pro** | morphllm.com/swe-bench-pro | SWE-Pro |
| 51 | **Poolside** | poolside.ai | Kod benchmark |
| 52 | **Upstage Solar** | upstage.ai | Solar Pro model |
| 53 | **Arcee AI** | arcee.ai | Domain-adaptive LLM |
| 54 | **KwaiKAT** | kwaik.at | Coder benchmark |
| 55 | **LiquidAI** | liquid.ai | State-space model |
| 56 | **NVIDIA Nemotron** | NVIDIA/HuggingFace | Nemotron model |

### 🧠 Akıl Yürütme & Matematik
| # | Site | URL | Odak |
|---|------|-----|------|
| 57 | **GPQA** | github.com/idavidrein/gpqa | Lisansüstü bilim QA |
| 58 | **HLE** | lastexam.ai | Son akademik sınav |
| 59 | **FrontierMath** | epoch.ai/frontiermath | Araştırma matematiği |
| 60 | **ARC-AGI** | arcprize.org | Akıcı zekâ testleri |
| 61 | **AIME** | aime.ai | Olimpiyat matematiği |
| 62 | **Epoch AGI Safety** | agi.safe.ai | AGI güvenlik metrikleri |
| 63 | **Epoch AI** | epoch.ai | Araştırma raporları |

### 🖼️ Multimodal & Görsel
| # | Site | URL | Odak |
|---|------|-----|------|
| 64 | **MMMU-Pro** | mmmu-benchmark.github.io | Üniversite görsel QA |
| 65 | **MathVista** | mathvista.github.io | Görsel matematik |
| 66 | **WebArena** | webarena.dev | Web sandbox agent |
| 67 | **VWA** | jykoh.com/vwa | Visual web arena |
| 68 | **OSWorld** | os-world.github.io | Desktop computer use |

### 🤖 Agent & Tool-Use Benchmarkları
| # | Site | URL | Odak |
|---|------|-----|------|
| 69 | **τ²-bench** | github.com/sierra-research/tau-bench | Tool + policy |
| 70 | **THUDM AgentBench** | github.com/THUDM/AgentBench | Agent benchmark |
| 71 | **Gorilla BFCL** | gorilla.cs.berkeley.edu/leaderboard.html | Function calling |
| 72 | **HAL Princeton** | hal.cs.princeton.edu | Holistic agent |
| 73 | **MLE-bench** | github.com/openai/mle-bench | ML agent |
| 74 | **BenchmarkingAgents** | benchmarkingagents.com/agent-benchmarks | Agent sıralaması |
| 75 | **Sierra Tau-Bench** | github.com/sierra-research/tau-bench | Tau bench detay |
| 76 | **OpenAI MLE-bench** | github.com/openai/mle-bench | ML engineering |
| 77 | **AIR-Bench** | github.com/OFA-Sys/AIR-Bench | Audio info retrieval |
| 78 | **MMAU-Pro** | sakshi113.github.io/mmau_homepage | Ses akıl yürütme |

### 🔒 Güvenlik & Safety
| # | Site | URL | Odak |
|---|------|-----|------|
| 79 | **AILuminate** | mlcommons.org/benchmarks/ailuminate | Endüstri güvenlik |
| 80 | **HELM Safety** | crfm.stanford.edu/helm | Holistic safety |
| 81 | **HELM AIR-Bench** | crfm.stanford.edu/2024/08/08/air-bench.html | AIR-Bench açıklama |
| 82 | **TrustLLM** | trustllmbenchmark.github.io | 6 boyut güvenilirlik |
| 83 | **HarmBench** | harmbench.org | Jailbreak dayanıklılığı |
| 84 | **WMDP** | wmdp.ai | WMDP benchmark |
| 85 | **Libra** | libra-leaderboard.github.io | Libra leaderboard |

---

## 🗂️ Deep Research Sonuçlarını Kaydetme

Her tarama sonucunu şu dosyaya kaydet:

```
~/.hermes/research/{AY}-{YIL}/
  ├── lmarena-elo.md
  ├── livebench-swebench.md
  ├── artificialanalysis.md
  ├── openrouter-pricing.md
  ├── coding-benchmarks.md
  ├── reasoning-benchmarks.md
  ├── multimodal.md
  ├── agent-benchmarks.md
  └── safety-benchmarks.md
```

Dosya adı formatı: `{kaynak-adi}-{tarih}.md`
İçerik: Türkçe tablo formatında veriler

---

## 📊 PDF Oluşturma (Çalışan Kod — v4)

```python
from reportlab.pdfgen import canvas as pdfcanvas
from reportlab.lib.pagesizes import A4
from reportlab.lib.units import cm
from reportlab.lib import colors
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont

pdfmetrics.registerFont(TTFont('DejaVu', '/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf'))
pdfmetrics.registerFont(TTFont('DejaVu-Bold', '/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf'))

OUT = "/root/Hermes-Model-Secim-{AY}-{YIL}.pdf"
w, h = A4
MARG = 1.2*cm
BODY_BOT = 1.8*cm

# Renkler
C_NAVY=colors.HexColor('#0a0f1e'); C_CYAN=colors.HexColor('#00d4ff')
C_AMBER=colors.HexColor('#ffb800'); C_MAGENTA=colors.HexColor('#e03997')
C_EMERALD=colors.HexColor('#00c875'); C_CRIMSON=colors.HexColor('#ff3366')
C_WHITE=colors.white; C_LGRAY=colors.HexColor('#e8e8f0')
C_DGRAY=colors.HexColor('#1a1a2e'); C_CARD=colors.HexColor('#111827')
C_BORDER=colors.HexColor('#2a2a4a'); C_PURPLE=colors.HexColor('#7c3aed')

c = pdfcanvas.Canvas(OUT, pagesize=A4)

# Sayfa 1 — KAPAK
# (Tam kod: aşağıda "PDF Sayfa Şablonları" bölümünde)

# Sayfa 2 — ÜST AJANLAR
# (Firma kolonu AYRI, Model kolonu AYRI — üst üste binmez!)

# Sayfa 3 — ALT AJANLAR
# (Maliyet/görev kolonu ayrı, renk kodlu)

# Sayfa 4 — FİNAL SEÇİM + STRATEJİK NOTLAR

c.save()
print(f"PDF tamam: {OUT}")
```

### Tablo Hücre Kuralları (KRİTİK!)
- `#` kolonu → ortalanmış bold amber
- `Firma` → sola hizalı, **soluk gri** (#8888aa), ayrı kolon, **firma KOLONU YOKSE modelin yanına firma parantezi içinde yazılır**
- `Model` → bold beyaz, ayrı kolon
- `Fiyat` → ortalanmış, açık gri
- `⭐ Alan` → 6pt, çok satırlı wrap (max 52 karakter/satır)

### PDF Sayfa Şablonları

#### Sayfa 1 — Kapak
```python
c.setFillColor(C_NAVY); c.rect(0,0,w,h,fill=1,stroke=0)
for i in range(25):
    g=int(16+i*0.8); c.setFillColorRGB(0.04,0.06,g/255)
    c.rect(0,i*h/25,w,h/25+1,fill=1,stroke=0)
c.setFillColor(C_CYAN);    c.rect(0,0,0.35*cm,h,fill=1,stroke=0)
c.setFillColor(C_MAGENTA); c.rect(0.35*cm,0,0.08*cm,h,fill=1,stroke=0)
c.setFont('DejaVu-Bold',40); c.setFillColor(C_WHITE)
c.drawString(MARG+0.5*cm,h-1.9*cm,"FRONTIER")
c.setFillColor(C_CYAN)
c.drawString(MARG+0.5*cm,h-2.85*cm,"MATRIX")
c.setFont('DejaVu',11); c.setFillColor(C_LGRAY)
c.drawString(MARG+0.5*cm,h-3.6*cm,"AI Model Seçimi — {Ay} {Yil}")
# Vitrin kartları (4 adet)
cards=[("TEXT ELO","1500",C_CYAN,"#1","Anthropic · Claude Opus 4.7",False),
       ("WEBDEV ELO","1567",C_AMBER,"#1","Anthropic · Claude Opus 4.7",False),
       ("SWE-BENCH","87.6%",C_EMERALD,"REKOR","Anthropic · Claude Opus 4.7",True),
       ("COST/GÖREV","$0.002",C_CRIMSON,"EN DÜŞÜK","DeepSeek · V4 Flash",True)]
```

#### Sayfa 2 — ÜST AJANLAR (Firma ayrı kolon!)
```python
# KOLON GENİŞLİKLERİ — Firma 1.8cm, Model 2.4cm (ayrık!)
cw2=[0.4*cm, 1.8*cm, 2.4*cm, 0.85*cm, 0.85*cm, 0.7*cm,
     1.1*cm, 1.2*cm, 1.1*cm, 1.1*cm, 4.35*cm]
hdrs2=['#','Firma','Model','$/M\nin','$/M\nout','Ctx',
       'Text\nELO','WebDev\nELO','Live\nBench','SWE\nbench','⭐ En İyi Alan']
# Firma kolonu ayrı yazılır — üst üste binmez!
for ci,cell in enumerate(row):
    if ci==1:  # Firma — soluk gri, sola hizalı
        c.setFont('DejaVu',7); c.setFillColor(colors.HexColor('#8888aa'))
        c.drawString(rx+0.1*cm,row_y-row_h+0.18*cm,cell)
    elif ci==2:  # Model — bold beyaz
        c.setFont('DejaVu-Bold',7); c.setFillColor(C_WHITE)
        c.drawString(rx+0.1*cm,row_y-row_h+0.18*cm,cell)
```

#### Sayfa 4 — Final Seçim
```python
# İki büyük kutu — ÜST (cyan border) ve ALT (purple border)
bx1=MARG+0.5*cm; bx2=MARG+8.5*cm; by_=h-11.0*cm; bh_=7.5*cm; bw_=8.0*cm
c.setFillColor(colors.HexColor('#0a1520')); c.setStrokeColor(C_CYAN)
c.roundRect(bx1,by_,bw_,bh_,8,fill=1,stroke=1)
# ALT kutusu
c.setFillColor(colors.HexColor('#0a1520')); c.setStrokeColor(C_PURPLE)
c.roundRect(bx2,by_,bw_,bh_,8,fill=1,stroke=1)
```

---

## 📋 Kullanım Senaryosuna Göre Hızlı Seçim

| Amacınız | Bakılacak Siteler |
|----------|-------------------|
| Genel "en iyi sohbet modeli" | LMArena Overall + AA Intelligence Index |
| Kodlama agent'ı | SWE-bench Live, LiveCodeBench, CodeSOTA |
| Tool-calling / API | BFCL v3/v4, τ²-bench, GAIA |
| Computer-use / browser | OSWorld, WebArena, VWA |
| Bilim / matematik araştırma | GPQA Diamond, HLE, FrontierMath, ARC-AGI |
| Görsel akıl yürütme | MMMU-Pro, OpenVLM Leaderboard, MathVista |
| Sesli AI | MMAU-Pro, AIR-Bench, HF Open ASR |
| Fiyat / hız optimizasyonu | Artificial Analysis (TPS + fiyat), PricePerToken |
| Güvenlik / compliance | AILuminate, TrustLLM, HarmBench, HELM Safety |
| Açık-ağırlıklı (self-host) | LLM-Stats Open LLM, BenchLM |
| Açık kaynak kodlama | BigCodeBench, Aider, T-Bench |
| Agent benchmark | HAL Princeton, MLE-bench, BenchmarkingAgents |

---

## ⚠️ Metodolojik Uyarılar (CRITICAL)

1. **Saturasyon:** MMLU, HumanEval, MBPP, GSM8K, MATH-500 — frontier modellerde ayırt edici değil.
2. **Veri kontaminasyonu:** Public benchmarklar eğitim verisine sızar. LiveBench, LiveCodeBench daha güvenilir.
3. **Scaffold etkisi:** Agent benchmarklarında aynı model + farklı harness arasında 5–10 puan fark.
4. **Self-reported vs. Independent:** Model üreticisinin raporladığı skor ile bağımsız ölçümler farklıdır.
5. **Tek skor tek hikâye değildir:** En az 3 farklı kaynak birlikte değerlendir.
6. **HF Open LLM Leaderboard emekli (Haziran 2025):** 2026 muadilleri: LLM-Stats Open LLM, BenchLM.
7. **Reward-hacking:** Berkeley RDI 2026 — tek benchmark'a güvenme.

---

## 🚫 Önemli Kurallar

1. **Sadece PDF atılır — Telegram'a mesaj yazılmaz** (aksi belirtilmedikçe)
2. **Türkçe karakterler için DejaVu font kullanılır** — aksi halde çıkmaz
3. **Her firma max 2 model** — ayrık seçim (disjoint set)
4. **Ücretsiz modeller pas geçilir** — güvenilirlik endişesi
5. **Memory güncellenir** — seçilen model kombinasyonu kaydedilir
6. **Skill otomatik GitHub'a push edilir** — bilgi-ve-projeler/Skills/birkan-model-secim/
7. **Firma kolonu ayrı yazılır** — üst üste binmez, modelden ayrı hücrede

---

## 🔗 İlgili Skills

- `ai-skill-pipeline` — Genel bilgi işleme pipeline
- `birkan-ai-model-scout` — Model benchmark bilgileri
- `hermes-agent` — Hermes konfigürasyonu
- `uncensored-model-router` — Sansür swap

---

*Bu skill Birkan'ın model seçim sürecini ~5 dakikaya indirir. 60+ benchmark sitesi, deep research döngüsü, tam metodoloji dahil.*
*Kaynak: Birkan'ın sağladığı 2026 LLM Karşılaştırma Rehberi | 60+ benchmark sitesi derlemesi*