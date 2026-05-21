# Session Note: GitHub SSH Key Setup on Contabo VDS
## 2026-05-14 — Birkan Kalyon

### Context
Server: Contabo VDS (207.180.204.66). No sudo. No interactive `gh` CLI (times out). No browser. Fine-grained PAT returned 403 on push despite `Contents: Read` permission.

### Working Path (chronological)

| Attempt | Method | Result |
|---------|--------|--------|
| 1 | `.git-credentials` with fine-grained PAT | 403 — PAT has only `Read`, needs `Read and write` |
| 2 | `gh auth login` (browser/device code) | Timeout (60s) — headless, no browser |
| 3 | `gh auth login --with-token` | Same timeout — still needs interactive flow |
| 4 | SSH keygen + `ssh-keyscan` + agent | ✅ SUCCESS |

### Exact working commands

```bash
# Generate key
ssh-keygen -t ed25519 -C "hermes-agent-trade-push" -f /root/.ssh/trade_push -N ""

# Show public key to user
cat /root/.ssh/trade_push.pub
# User adds it at https://github.com/settings/ssh/new

# After user confirms:
ssh-keyscan -t ed25519 github.com >> /root/.ssh/known_hosts

# Start agent and load key
eval "$(ssh-agent -s)"
ssh-add /root/.ssh/trade_push

# Switch remote to SSH
git remote set-url origin git@github.com:bbbirkan/2026_Trade-Bots.git

# Push — works non-interactively
git push -u origin master:main --force
```

### Key gotchas

1. `ssh-keyscan` is **mandatory** — without it you get `Host key verification failed` even with a valid key.
2. `eval "$(ssh-agent -s)"` is needed in every new shell — the agent does not auto-start.
3. `gh` CLI is **not worth installing** on headless VPS if the only goal is push/pull. SSH key flow is faster and zero-interactive after initial setup.
4. Fine-grained PAT scope editing is slower than generating a new SSH keypair. Prefer SSH for Birkan's setup.
5. If the user says "tokenlemi hizli" (is token faster), the answer is **NO** — for this setup SSH is faster because PAT requires scope debugging and potential token regeneration.

### Persistent state
The keypair `/root/.ssh/trade_push` and `known_hosts` entry remain valid across sessions. Future pushes on this repo or any other repo using `git@github.com:` remote do NOT need re-auth.
