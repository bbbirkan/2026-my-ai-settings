#!/bin/bash
# bootstrap.sh — 2026-my-ai-settings setup
# Usage: bash bootstrap.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo "=== 2026-my-ai-settings bootstrap ==="
echo ""

# ─── 1. Claude Code settings ──────────────────────────────────────────────────
echo "[1/4] Claude Code settings..."
mkdir -p "$CLAUDE_DIR"

if [ -f "$CLAUDE_DIR/settings.json" ]; then
  echo "  settings.json already exists — skipping (backup: $CLAUDE_DIR/settings.json.bak)"
  cp "$CLAUDE_DIR/settings.json" "$CLAUDE_DIR/settings.json.bak"
fi
cp "$SCRIPT_DIR/claude-code/settings.json" "$CLAUDE_DIR/settings.json"
echo "  ✓ settings.json → $CLAUDE_DIR/"

if [ -f "$CLAUDE_DIR/settings.local.json" ]; then
  echo "  settings.local.json already exists — skipping (backup kept)"
  cp "$CLAUDE_DIR/settings.local.json" "$CLAUDE_DIR/settings.local.json.bak"
fi
cp "$SCRIPT_DIR/claude-code/settings.local.json" "$CLAUDE_DIR/settings.local.json"
echo "  ✓ settings.local.json → $CLAUDE_DIR/"

# ─── 2. CLAUDE.md template ────────────────────────────────────────────────────
echo ""
echo "[2/4] CLAUDE.md template..."
CLAUDE_MD_DEST="/root/CLAUDE.md"
if [ "$HOME" != "/root" ]; then
  CLAUDE_MD_DEST="$HOME/CLAUDE.md"
fi

if [ -f "$CLAUDE_MD_DEST" ]; then
  echo "  CLAUDE.md already exists at $CLAUDE_MD_DEST"
  echo "  Template saved as: $CLAUDE_MD_DEST.template"
  cp "$SCRIPT_DIR/CLAUDE.md.template" "$CLAUDE_MD_DEST.template"
else
  cp "$SCRIPT_DIR/CLAUDE.md.template" "$CLAUDE_MD_DEST"
  echo "  ✓ CLAUDE.md → $CLAUDE_MD_DEST"
  echo "  Edit it: replace YOUR_* placeholders with your actual values"
fi

# ─── 3. Orchester (optional) ──────────────────────────────────────────────────
echo ""
echo "[3/4] Orchester multi-agent routing..."
read -p "  Install Orchester? (Claude+OpenCode+AGY smart routing) [y/N]: " install_orch
if [[ "$install_orch" =~ ^[Yy]$ ]]; then
  ORCH_DIR="/root/orchester"
  read -p "  Install directory [$ORCH_DIR]: " custom_dir
  ORCH_DIR="${custom_dir:-$ORCH_DIR}"

  mkdir -p "$ORCH_DIR"
  cp "$SCRIPT_DIR/orchester/"*.py "$ORCH_DIR/"
  cp "$SCRIPT_DIR/orchester/requirements.txt" "$ORCH_DIR/"
  echo "  ✓ Orchester files → $ORCH_DIR/"

  # Install dependencies
  if command -v pip3 &>/dev/null; then
    pip3 install -r "$ORCH_DIR/requirements.txt" -q
    echo "  ✓ Dependencies installed"
  fi

  # systemd service
  read -p "  Install as systemd service? [y/N]: " install_svc
  if [[ "$install_svc" =~ ^[Yy]$ ]]; then
    PYTHON_PATH=$(which python3.11 2>/dev/null || which python3)
    sed "s|YOUR_ORCHESTER_DIR|$ORCH_DIR|g; s|YOUR_PYTHON_PATH|$PYTHON_PATH|g" \
      "$SCRIPT_DIR/orchester/orchester.service" \
      > /etc/systemd/system/orchester.service
    systemctl daemon-reload
    systemctl enable --now orchester
    echo "  ✓ orchester.service enabled and started"
    echo "  Test: curl http://localhost:8006/health"
  fi
else
  echo "  Skipped."
fi

# ─── 4. GitHub SSH reminder ───────────────────────────────────────────────────
echo ""
echo "[4/4] GitHub SSH..."
if [ -f ~/.ssh/id_ed25519 ] || ls ~/.ssh/*.pub &>/dev/null 2>&1; then
  echo "  SSH keys found. Make sure one is added to GitHub."
else
  echo "  No SSH key found. Generate one:"
  echo "    ssh-keygen -t ed25519 -C 'your@email.com' -f ~/.ssh/github_deploy"
  echo "    cat ~/.ssh/github_deploy.pub  # add to GitHub Settings → SSH keys"
fi
echo "  See: docs/github-ssh-setup.md"

echo ""
echo "=== Done! ==="
echo ""
echo "Next steps:"
echo "  1. Edit $CLAUDE_MD_DEST — fill in YOUR_* placeholders"
echo "  2. Restart Claude Code to pick up new settings"
if [[ "$install_orch" =~ ^[Yy]$ ]]; then
  echo "  3. systemctl status orchester"
fi
