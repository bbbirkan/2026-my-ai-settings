# OpenRouter Model Fiyatları — Hızlı Referans

> 2026-05-15 tarihinde çekilen güncel fiyatlar. Token başına maliyet.

---

## En Ucuz Modeller (Input fiyatına göre sıralı)

| Model | Input ($/M) | Output ($/M) | Context |
|-------|------------|--------------|---------|
| inclusionai/ling-2.6-flash | $0.010 | $0.030 | 262K |
| ibm-granite/granite-4.0-h-micro | $0.017 | $0.110 | 131K |
| mistralai/mistral-nemo | $0.020 | $0.030 | 131K |
| meta-llama/llama-3.1-8b-instruct | $0.020 | $0.050 | 16K |
| deepseek/deepseek-v4-flash | $0.130 | $0.250 | 1M |
| minimax/minimax-m2.7 | $0.280 | $1.20 | 196K |
| google/gemma-3-4b-it | $0.040 | $0.140 | 131K |
| qwen/qwen3.5-9b | $0.040 | $0.150 | 262K |
| tencent/hy3-preview | $0.070 | $0.260 | 262K |
| google/gemini-2.0-flash-lite | $0.070 | $0.300 | 1M |

---

## Kalite/Ücret Dengesi İyi Olanlar

| Model | Input ($/M) | Output ($/M) | Context | Kullanım |
|-------|------------|--------------|---------|---------|
| moonshotai/kimi-k2.6 | $0.73 | $3.49 | 262K | Telegram konuşma (seninle) |
| deepseek/deepseek-v3.1-terminus | $0.27 | $0.95 | 163K | Arka plan reasoning |
| qwen/qwen3-vl-8b-instruct | $0.08 | $0.50 | 131K | Basit görevler |
| anthropic/claude-sonnet-4 | $3.00 | $15.00 | 1M | Yüksek kalite gereken iş |
| nousresearch/hermes-2-pro-llama-3-8b | $0.14 | $0.14 | 8K | Sansürsüz görevler |

---

## Ücretsiz Modeller (Free Tier)

| Model | Input | Output | Context |
|-------|-------|--------|---------|
| deepseek/deepseek-v4-flash:free | $0 | $0 | 1M |
| openrouter/free | $0 | $0 | 200K |
| inclusionai/ring-2.6-1t:free | $0 | $0 | 262K |
| openai/gpt-oss-120b:free | $0 | $0 | 131K |

---

## Birkan'ın Tercih Ettiği Yapı

| Katman | Model | Sebep |
|--------|-------|-------|
| Telegram (seninle) | `moonshotai/kimi-k2.6` | Kalite/ücret dengesi iyi |
| Arka plan (cron/sub-agent) | `deepseek/deepseek-chat-v3-24m` veya `minimax-minimaxi` | Ucuz, yeterli |
| Yüksek reasoning | `anthropic/claude-sonnet-4` | Kalite gerekliyse |

---

## Not

- Google Gemini free tier tükendi = 429 RESOURCE_EXHAUSTED. OpenRouter'a key vermek Gemini kota sorununu çözmez.
- Model layering (Telegram için bir model, gateway için başka) normal bir Hermes davranışıdır — kullanıcıya açıklamaya gerek yok.

🤖 *Bu referans Hermes Agent tarafından oluşturuldu | 2026-05-15*