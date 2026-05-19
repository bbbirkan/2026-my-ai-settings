# Orchester — Zero-API-Key Multi-Agent Routing

Claude Code + OpenCode + Gemini CLI'ı tek bir OpenAI-compatible API arkasında birleştiren smart routing sistemi.

**Özellik:** API key yok. Sadece subscription.

## Nasıl Çalışır

```
Gelen soru → Claude sınıflandırır → basit/orta/zor
  basit  → Claude tek başına              (~10s)
  orta   → Claude + OpenCode paralel      (~35s)
  zor    → 3 CLI konsey, max 3 tur        (~60-90s)
```

## Gereksinimler

```bash
# CLI'ların kurulu ve auth'lu olması gerekiyor
claude --version       # Anthropic Pro subscription
opencode --version     # OpenCode subscription
gemini --version       # Google subscription / free tier

pip install -r requirements.txt
```

Root olarak çalışıyorsanız bubblewrap bypass gerekli:
```bash
export CLAUDE_CODE_BUBBLEWRAP=1
```

## Çalıştırma

### Direkt CLI
```bash
python3 terminal_orchester.py "Sorum nedir?"
python3 terminal_orchester.py --mode smart "Karmaşık mimari sorusu"
python3 terminal_orchester.py --mode chain "Adım adım analiz"
```

### FastAPI Servisi (port 8006)
```bash
uvicorn main:app --port 8006 --host 127.0.0.1
```

### systemd Servisi
```bash
# orchester.service içindeki YOUR_* değerlerini doldurun
cp orchester.service /etc/systemd/system/
systemctl enable --now orchester
```

## API Endpointleri

| Endpoint | Açıklama |
|----------|----------|
| `POST /v1/chat/completions` | OpenAI-compatible (Hermes entegrasyonu için) |
| `POST /orchestrate` | Smart routing — mode: smart/parallel/chain/sequential |
| `POST /debate` | Claude-only 3 persona tartışma |
| `GET /health` | Durum kontrolü |
| `GET /debates` | Kaydedilen tartışmalar |

## Hermes Entegrasyonu

`~/.hermes/config.yaml`'a şunu ekleyin:
```yaml
model:
  default: terminal-orchester
  provider: custom:orchester
custom_providers:
  - name: orchester
    base_url: http://localhost:8006/v1
    api_mode: chat_completions
agent:
  max_turns: 1      # loop önleme — kritik
toolsets: []        # agentic loop önleme — kritik
```

## Orkestrasyon Modları

| Mod | Pipeline | Süre |
|-----|----------|------|
| `smart` | Claude sınıflandırır → otomatik seçim | ~10-90s |
| `parallel` | Claude + OpenCode paralel → Gemini sentez | ~35s |
| `chain` | Claude → OpenCode → Gemini sırayla | ~45s |
| `sequential` | Gemini taslak → Claude+OpenCode eleştiri → Gemini final | ~50s |

## Test Sonuçları

| Soru | Seviye | Süre |
|------|--------|------|
| "nasılsın" | basit | ~11s |
| async vs threading | orta | ~36s |
| AI orkestrasyon mimarisi | zor | ~54s |
