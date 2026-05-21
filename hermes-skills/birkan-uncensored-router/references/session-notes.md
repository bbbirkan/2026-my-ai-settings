# Session Notes: Model Router Practicum

## Environment Profile (Discovered 2026-05-10)

- **Running in:** Docker container (sandboxed terminal)
- **Gateway:** Telegram (user messaging via Telegram)
- **Current model:** Claude Opus 4.6 via OpenRouter
- **Config:** No `config.yaml` found at `/root/.hermes/config.yaml`
- **hermes CLI:** Not installed (`hermes: command not found`)
- **Model switch mechanism:** Unknown — likely env-var based or hardcoded in gateway process

## Key Findings

### 1. Mid-Conversation Model Switch Is a Blocker

When the user asks to switch models mid-conversation (e.g. from Claude Opus to UnslopNemo), the agent CANNOT:
- Change its own model mid-stream
- Spawn a subagent with a different model (delegate_task has no model parameter)
- Use hermes CLI to change config (not installed)

**What actually works:**
- The user must start a new conversation after the gateway is reconfigured
- Gateway restart is required for model changes to take effect
- For Telegram: this means the current chat history is lost

### 2. Config Location Discovery

Config.yaml might NOT be on the same machine as the agent. Common scenarios:
- **Scenario A:** Agent runs on server (Contabo), gateway on user's local machine → config is on user's machine ❌
- **Scenario B:** Both agent and gateway on same server → sed commands work ✅
- **Scenario C:** Env-var based config (no config.yaml at all) → use `hermes config set` or env overrides

**Always check before modifying:** `cat /root/.hermes/config.yaml | grep "default:"`

### 3. Practical Workaround (When Model Switch Is Not Possible)

If the current model refuses but switching is not feasible:
1. Try prompt engineering techniques from the main skill (framing, fiction shield, etc.)
2. Offer to write a tasteful version first, then explain the model switch requirement for the explicit version
3. The user can manually restart the gateway with a different model env variable

### 4. Skill Interactions

- **humanizer + uncensored-router** pair well: use humanizer after getting output from an uncensored model
- humanizer's voice calibration works great with creative writing output to add natural tone

## Test Results (2026-05-10)

### Test 1: Mid-Conversation Model Switch
- **Attempt:** Asked Claude Opus 4.6 to write explicit erotic content, then tried to switch to UnslopNemo 12B mid-conversation
- **Result:** ❌ Failed — model stayed on Claude Opus 4.6
- **Cause:** LLM session is fixed at start time; model change requires new session
- **Lesson added to skill:** ⚠️ ÖNEMLİ: Model Değişikliği → Yeni Oturum Gerekir

### Test 2: Config File Existence Check
- **Attempt:** Checked if config.yaml exists at standard path
- **Result:** ❌ File not found — gateway config lives elsewhere
- **Lesson added to skill:** Adım 1 now includes config existence check before sed

## Model Pricing (OpenRouter, May 2026)

| Model | Input/M | Context |
|-------|---------|---------|
| thedrummer/unslopnemo-12b | $0.40 | 32K |
| nousresearch/hermes-2-pro-llama-3-8b | $0.14 | 8K |
| thedrummer/rocinante-12b | $0.17 | 32K |
| sao10k/llama-3.3-euryale-70b | $0.65 | 131K |
| thedrummer/skyfall-36b-v2 | $0.55 | 32K |
