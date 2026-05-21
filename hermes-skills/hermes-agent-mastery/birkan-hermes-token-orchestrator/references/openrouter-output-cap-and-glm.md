# OpenRouter Output Cap + GLM-4.7 Debug Notes

## OpenRouter 402 with huge requested tokens

Observed failure pattern:

```text
HTTP 402: This request requires more credits, or fewer max_tokens.
You requested up to 65536 tokens...
```

Root cause in Hermes context:

- `model.max_tokens` was unset.
- Some provider/model profiles default to very high output caps (64K/128K).
- OpenRouter treats requested max output tokens as part of affordability checks.
- The user did not necessarily request a 64K response; it can come from provider defaults.

Durable fix:

```bash
hermes config set model.max_tokens 8192
```

Important:

- This is **output cap**, not input/context limit.
- It does not stop large-context reading.
- It only limits one response's maximum generated output.

For unusually large generated reports/code/PDF text:

```bash
hermes config set model.max_tokens 32768
# run the large-output task
hermes config set model.max_tokens 8192
```

Prefer chunked files/artifacts over giant chat responses.

---

## GLM-4.7 empty content diagnosis

Initial smoke test showed GLM returning empty visible `content` in some calls.
GLM was not broken.

Cause:

- GLM-4.7 can spend many tokens on reasoning.
- With low max output tokens, the response can hit length before visible content appears.
- GLM-4.7 Flash was worse in this respect during testing.

Working GLM settings:

```json
{
  "model": "z-ai/glm-4.7",
  "reasoning": {"effort": "low"},
  "max_tokens": 1200
}
```

Confirmed:

- Normal text response works.
- Tool-call works when arguments are explicit.
- `report_status` was called correctly with `model_id=z-ai/glm-4.7` and `status=ok`.

Pitfalls:

- Do not confuse `z-ai/glm-4.7` with `z-ai/glm-4.7-flash`.
- If visible content is empty, inspect reasoning/finish_reason before declaring model failure.
- Retry with low reasoning + higher max_tokens before fallback.

🤖 *Bu doküman Hermes Agent tarafından oluşturuldu*
