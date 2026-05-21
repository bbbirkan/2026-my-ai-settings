# Tasiyici (Heighliner) Model — May 2026

## Selection: `deepseek/deepseek-chat` (OpenRouter)

**Rationale:**
- Carrier model for 3-tier orchestration (Ameleler → Şefler → Patron)
- Main transport/workhorse for routine request handling
- Cost-effective, reliable on OpenRouter
- Alternative candidates considered but rejected this month

## Config Path
```bash
grep "default:" /root/.hermes/config.yaml
# Expected output: default: deepseek/deepseek-chat
```

## Verification
After model switch, verify active model:
```bash
hermes config path
cat /root/.hermes/config.yaml | head -5
```

## Related Tiers (May 2026)
- **Ameleler (Workers):** Tasiyici Heighliner (eski DeepSeek-V4-Flash), MiniMax-M2.5, Gemini-3-Flash
- **Şefler (Chiefs):** GLM-4.7, Grok-4.20, DeepSeek-V4-Pro, Claude-Opus-4.7
- **Patron (Executive):** GPT-5.5 & Claude-Opus-4.6

## Notes
- Model selection updates monthly (start of month)
- User prefers Turkish comms, direct answers
- No re-asking for permission on routine model switches after decision made
