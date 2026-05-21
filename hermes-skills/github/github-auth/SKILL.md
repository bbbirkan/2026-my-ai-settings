---
name: github-auth
description: "GitHub auth setup: HTTPS tokens, SSH keys, gh CLI login."
version: 1.1.0
author: Hermes Agent
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [GitHub, Authentication, Git, gh-cli, SSH, Setup]
    related_skills: [github-pr-workflow, github-code-review, github-issues, github-repo-management]
---

# GitHub Authentication Setup

This skill sets up authentication so the agent can work with GitHub repositories, PRs, issues, and CI. It covers two paths:

- **`git` (always available)** — uses HTTPS personal access tokens or SSH keys
- **`gh` CLI (if installed)** — richer GitHub API access with a simpler auth flow

## Detection Flow

When a user asks you to work with GitHub, run this check first:

```bash
# Check what's available
git --version
gh --version 2>/dev/null || echo "gh not installed"

# Check if already authenticated
gh auth status 2>/dev/null || echo "gh not authenticated"
git config --global credential.helper 2>/dev/null || echo "no git credential helper"
```

**Decision tree:**
1. If `gh auth status` shows authenticated → you're good, use `gh` for everything
2. If `gh` is installed but not authenticated → use "gh auth" method below
3. If `gh` is not installed → use "git-only" method below (no sudo needed)

---

## Method 1: Git-Only Authentication (No gh, No sudo)

This works on any machine with `git` installed. No root access needed.

### Option A: HTTPS with Personal Access Token (Recommended)

This is the most portable method — works everywhere, no SSH config needed.

**Step 1: Create a personal access token**

Tell the user to go to: **https://github.com/settings/tokens**

- Click "Generate new token (classic)"
- Give it a name like "hermes-agent"
- Select scopes:
  - `repo` (full repository access — read, write, push, PRs)
  - `workflow` (trigger and manage GitHub Actions)
  - `read:org` (if working with organization repos)
- Set expiration (90 days is a good default)
- Copy the token — it won't be shown again

**Step 2: Configure git to store the token**

```bash
# Set up the credential helper to cache credentials
# "store" saves to ~/.git-credentials in plaintext (simple, persistent)
git config --global credential.helper store

# Now do a test operation that triggers auth — git will prompt for credentials
# Username: <their-github-username>
# Password: <paste the personal access token, NOT their GitHub password>
git ls-remote https://github.com/<their-username>/<any-repo>.git
```

After entering credentials once, they're saved and reused for all future operations.

**Alternative: cache helper (credentials expire from memory)**

```bash
# Cache in memory for 8 hours (28800 seconds) instead of saving to disk
git config --global credential.helper 'cache --timeout=28800'
```

**Alternative: set the token directly in the remote URL (per-repo)**

```bash
# Embed token in the remote URL (avoids credential prompts entirely)
git remote set-url origin https://<username>:<token>@github.com/<owner>/<repo>.git
```

**Step 3: Configure git identity**

```bash
# Required for commits — set name and email
git config --global user.name "Their Name"
git config --global user.email "their-email@example.com"
```

**Step 4: Verify**

```bash
# Test push access (this should work without any prompts now)
git ls-remote https://github.com/<their-username>/<any-repo>.git

# Verify identity
git config --global user.name
git config --global user.email
```

### Option B: SSH Key Authentication

Good for users who prefer SSH or already have keys set up.

**Step 1: Check for existing SSH keys**

```bash
ls -la ~/.ssh/id_*.pub 2>/dev/null || echo "No SSH keys found"
```

**Step 2: Generate a key if needed**

```bash
# Generate an ed25519 key (modern, secure, fast)
ssh-keygen -t ed25519 -C "their-email@example.com" -f ~/.ssh/id_ed25519 -N ""

# Display the public key for them to add to GitHub
cat ~/.ssh/id_ed25519.pub
```

Tell the user to add the public key at: **https://github.com/settings/keys**
- Click "New SSH key"
- Paste the public key content
- Give it a title like "hermes-agent-<machine-name>"

**Step 3: Test the connection**

```bash
ssh -T git@github.com
# Expected: "Hi <username>! You've successfully authenticated..."
```

**Step 4: Configure git to use SSH for GitHub**

```bash
# Rewrite HTTPS GitHub URLs to SSH automatically
git config --global url."git@github.com:".insteadOf "https://github.com/"
```

**Step 5: Configure git identity**

```bash
git config --global user.name "Their Name"
git config --global user.email "their-email@example.com"
```

---

## Method 2: gh CLI Authentication

If `gh` is installed, it handles both API access and git credentials in one step.

### Interactive Browser Login (Desktop)

```bash
gh auth login
# Select: GitHub.com
# Select: HTTPS
# Authenticate via browser
```

### Token-Based Login (Headless / SSH Servers)

```bash
echo "<THEIR_TOKEN>" | gh auth login --with-token

# Set up git credentials through gh
gh auth setup-git
```

### Verify

```bash
gh auth status
```

---

## Using the GitHub API Without gh

When `gh` is not available, you can still access the full GitHub API using `curl` with a personal access token. This is how the other GitHub skills implement their fallbacks.

### Setting the Token for API Calls

```bash
# Option 1: Export as env var (preferred — keeps it out of commands)
export GITHUB_TOKEN="<token>"

# Then use in curl calls:
curl -s -H "Authorization: token $GITHUB_TOKEN" \
  https://api.github.com/user
```

### Extracting the Token from Git Credentials

If git credentials are already configured (via credential.helper store), the token can be extracted:

```bash
# Read from git credential store
grep "github.com" ~/.git-credentials 2>/dev/null | head -1 | sed 's|https://[^:]*:\([^@]*\)@.*|\1|'
```

### Helper: Detect Auth Method

Use this pattern at the start of any GitHub workflow:

```bash
# Try gh first, fall back to git + curl
if command -v gh &>/dev/null && gh auth status &>/dev/null; then
  echo "AUTH_METHOD=gh"
elif [ -n "$GITHUB_TOKEN" ]; then
  echo "AUTH_METHOD=curl"
elif [ -f ~/.hermes/.env ] && grep -q "^GITHUB_TOKEN=" ~/.hermes/.env; then
  export GITHUB_TOKEN=$(grep "^GITHUB_TOKEN=" ~/.hermes/.env | head -1 | cut -d= -f2 | tr -d '\n\r')
  echo "AUTH_METHOD=curl"
elif grep -q "github.com" ~/.git-credentials 2>/dev/null; then
  export GITHUB_TOKEN=$(grep "github.com" ~/.git-credentials | head -1 | sed 's|https://[^:]*:\([^@]*\)@.*|\1|')
  echo "AUTH_METHOD=curl"
else
  echo "AUTH_METHOD=none"
  echo "Need to set up authentication first"
fi
```

---

## User Preference: Minimal Permission Prompting

**Birkan dislikes being asked for approval on every GitHub push step.** When a push fails due to auth, take direct action immediately — fix credentials, generate SSH keys, or update tokens — and only report the final result. Do not ask "should I try X?" or "which method do you prefer?" mid-flow. If multiple auth methods exist, pick the fastest one and proceed.

### Birkan Contabo VDS — Known SSH Push Key

On Birkan's Contabo VDS, GitHub SSH push is expected to work through:

```bash
/root/.ssh/trade_push
```

When creating/pushing a new repo, do **not** fall back to HTTPS just because `gh` is not logged in or a PAT returns 403. Use SSH explicitly:

```bash
ssh -i /root/.ssh/trade_push -o IdentitiesOnly=yes -o StrictHostKeyChecking=accept-new -T git@github.com

git remote set-url origin git@github.com:bbbirkan/<repo>.git
GIT_SSH_COMMAND="ssh -i /root/.ssh/trade_push -o IdentitiesOnly=yes -o StrictHostKeyChecking=accept-new" \
  git push -u origin main
```

Pitfall: if a previous failed HTTPS attempt sanitized `origin` back to `https://github.com/...`, SSH will not be used. Always inspect `git remote -v` before retrying.

See `references/birkan-github-ssh-new-repo.md` for the full new-repo push recipe.

## VPS / Headless Server Script

The configuration Birkan uses runs entirely non-interactive (Contabo VDS, no sudo, no browser). `gh auth login --with-token` is **NOT** preferred because it still requires interactive device-code flow and times out under headless conditions. Use the ssh-keygen flow below:

```bash
# 1. Generate key (no passphrase, headless-safe)
ssh-keygen -t ed25519 -C "hermes-$(date +%s)" -f /root/.ssh/<repo_name> -N ""

# 2. Show public key for the user to add at https://github.com/settings/ssh/new
cat /root/.ssh/<repo_name>.pub

# 3. Wait for user to confirm they added it, then:
ssh-keyscan -t ed25519 github.com >> /root/.ssh/known_hosts

# 4. Start agent and add key
eval "$(ssh-agent -s)"
ssh-add /root/.ssh/<repo_name>

# 5. Point the local repo to SSH
git remote set-url origin git@github.com:<owner>/<repo>.git

# 6. Done — push works non-interactively from now on
git push -u origin <branch>
```

**Key principle:** SSH key + `ssh-keyscan` avoids **both** the interactive `gh` flow **and** the fine-grained PAT scope-edit dance. One keypair per repo is fine.

## Troubleshooting

See `references/github-ssh-setup-session.md` for a full session transcript of setting up SSH push access on a headless Contabo VDS (no browser, no interactive `gh`, fine-grained PAT failing with 403).

| Problem | Solution |
|---------|----------|
| `git push` asks for password | GitHub disabled password auth. Use a personal access token as the password, or switch to SSH |
| `remote: Permission to X denied` | Token may lack `repo` scope — regenerate with correct scopes |
| `fatal: Authentication failed` | Cached credentials may be stale — run `git credential reject` then re-authenticate |
| `ssh: connect to host github.com port 22: Connection refused` | Try SSH over HTTPS port: add `Host github.com` with `Port 443` and `Hostname ssh.github.com` to `~/.ssh/config` |
| `git push` hangs / `git remote set-url` → push silently fails | In headless environments with no tty, long-running pushes may timeout at the terminal tool layer. Use a tighter timeout (e.g. 30s) and poll the push status: check `git log` on the remote after 10s, or use `git push` from a background process (`git push &`) |
| Credentials not persisting | Check `git config --global credential.helper` — must be `store` or `cache` |
| Multiple GitHub accounts | Use SSH with different keys per host alias in `~/.ssh/config`, or per-repo credential URLs |
| `gh: command not found` + no sudo | Use git-only Method 1 above — no installation needed |
| `gh auth login` device code times out (60s limit) | SSH key fallback: generate `ed25519` key, print public key for user to paste into GitHub Settings → SSH keys, then `git remote set-url origin git@github.com:owner/repo.git` and push |
| Token present but 403 on push | Token is read-only or repo-mismatched. Check token has `repo` scope and repository access includes the target repo. If fine-grained PAT, edit token permissions directly. Do not ask user for new token unless edit fails |
| `gh auth login` hangs/timeout in non-interactive environments | **Headless/VDS systems cannot run interactive `gh auth login`.** The browser/device-code flow stalls. Preferred fix: skip `gh` entirely, use SSH keygen + `ssh-keyscan github.com >> ~/.ssh/known_hosts` + `git remote set-url origin git@github.com:owner/repo.git`. SSH agent handles auth silently after initial key setup. |
| Fine-grained PAT returns 403 even with `Contents: Read` | Fine-grained PAT requires **Contents: Read and write** (not just Read). Also verify the token is explicitly granted access to the target repository under "Repository access". Edit existing token at https://github.com/settings/personal-access-tokens rather than generating a new one. |
| SSH push fails with `Host key verification failed` | `~/.ssh/known_hosts` is missing GitHub's host key. Fix: `ssh-keyscan -t ed25519 github.com >> ~/.ssh/known_hosts`. Then retry push. Do not use `StrictHostKeyChecking=no` in production — it disables MITM protection. |
