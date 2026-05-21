# Model Scout — Benchmark & Price Check Workflow

> Mayıs 2026 itibarıyla Birkan'ın istediği yöntem: LMSYS Arena + Artificial Analysis + OpenRouter API fiyatları

---

## Hızlı Fiyat Sorgulama (OpenRouter API)

```bash
# Tek model sorgula
curl -s -H "Authorization: Bearer $OPENROUTER_API_KEY" \
  "https://openrouter.ai/api/v1/models?search=claude-opus-4" | python3 -c "
import sys,json
data = json.load(sys.stdin)['data']
for m in data:
    price_in = float(m.get('pricing',{}).get('prompt',0))*1_000_000
    price_out = float(m.get('pricing',{}).get('completion',0))*1_000_000
    ctx = m.get('context_length',0)
    print(f\"{m['id']}: \${price_in:.2f}/\${price_out:.2f} | {ctx:,} ctx\")
"

# Çoklu model sorgula (anahtar kelimelerle)
curl -s -H "Authorization: Bearer $OPENROUTER_API_KEY" \
  "https://openrouter.ai/api/v1/models?search=gemini-3-pro&qwen3-flash" | python3 -c "
import sys,json
data = json.load(sys.stdin)['data']
keywords = ['gemini-3', 'qwen3', 'deepseek', 'claude-opus']
for m in data:
    mid = m['id'].lower()
    if any(k.lower() in mid for k in keywords):
        price_in = float(m.get('pricing',{}).get('prompt',0))*1_000_000
        price_out = float(m.get('pricing',{}).get('completion',0))*1_000_000
        ctx = m.get('context_length',0)
        print(f\"{m['id']}: \${price_in:.2f}/\${price_out:.2f} | {ctx:,} ctx\")
"
```

---

## Benchmark Siteleri

| Site | URL | Ne Verir |
|------|-----|----------|
| LMSYS Chatbot Arena | https://lmarena.ai/leaderboard | ELO skorları (genel zeka) |
| Artificial Analysis | https://artificialanalysis.ai/models | Intelligence index, hız, context, fiyat |
| OpenRouter Rankings | https://openrouter.ai/rankings | Popülerlik sıralaması |

### LMSYS Arena'dan ELO Çekme
Browser ile `https://lmarena.ai/leaderboard` aç → Text tablosundan skorları oku.

**Güncel ELO Sıralaması (Mayıs 2026):**
| Sıra | Model | ELO |
|------|-------|-----|
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

## Artificial Analysis — Intelligence Index

**10 Benchmark Ortalaması:** GDPval-AA, τ²-Bench Telecom, Terminal-Bench Hard, SciCode, AA-LCR, AA-Omniscience, IFBench, Humanity's Last Exam, GPQA Diamond, CritPt

**Zeka Sıralaması:**
1. GPT-5.5 (xhigh) — En yüksek
2. GPT-5.5 (high)
3. Claude Opus 4.7 (max)
4. Gemini 3.1 Pro Preview

**Hız (token/s):**
1. Mercury 2 → 905 t/s
2. Gemini 3.1 Flash-Lite → 338 t/s

**Context:**
1. Llama 4 Scout → **10M**
2. Grok 4.20 → 2M
3. Deepseek V4 Flash/Pro → 1M

---

## Fiyat/Performans — OpenRouter Gerçek Fiyatlar (Mayıs 2026)

### 🟢 En İyi Değer
| Model | Input | Output | Context |
|-------|-------|--------|---------|
| deepseek/deepseek-v4-flash:free | FREE | FREE | 1M |
| qwen/qwen3.5-flash-02-23 | $0.07 | $0.26 | 1M |
| mistralai/mistral-nemo | $0.02 | $0.03 | 131K |
| meta-llama/llama-4-scout | $0.08 | $0.30 | 327K |

### 🟡 Orta Seviye
| Model | Input | Output | Context |
|-------|-------|--------|---------|
| deepseek/deepseek-v4-pro | $0.43 | $0.87 | 1M |
| minimax/minimax-m2.7 | $0.28 | $1.20 | 196K |
| google/gemini-3.1-flash-lite | $0.25 | $1.50 | 1M |

### 🔴 Premium
| Model | Input | Output | Context |
|-------|-------|--------|---------|
| anthropic/claude-sonnet-4.6 | $3.00 | $15.00 | 1M |
| anthropic/claude-opus-4.7 | $5.00 | $25.00 | 1M |
| kimi-k2.6 | $0.73 | $3.49 | 262K |

---

## Önemli Kural

**Birkan model seçimini kendisi yapıyor.** Ben sadece güncel benchmark + fiyat tablosunu sunacağım, "değiştirelim mi?" diye sormayacağım. Ona bırakacağım.

---

🤖 *Bu referans dosyası Hermes Agent tarafından oluşturuldu | 2026-05-15*
