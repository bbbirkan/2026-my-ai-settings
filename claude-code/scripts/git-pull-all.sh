#!/bin/bash
# Oturum başlangıcında tüm Work projelerini GitHub ile senkronize eder

WORK_DIR="/Users/birkan/Desktop/Work "
LOG="/tmp/claude-git-pull.log"

echo "=== Git Pull All — $(date '+%Y-%m-%d %H:%M') ===" > "$LOG"

updated=0
skipped=0
failed=0

find "$WORK_DIR" -maxdepth 2 -name ".git" -type d 2>/dev/null | while read gitdir; do
  project=$(dirname "$gitdir")
  name=$(basename "$project")

  cd "$project" 2>/dev/null || continue

  # Remote yoksa atla
  remote=$(git remote 2>/dev/null | head -1)
  [ -z "$remote" ] && echo "⏭ $name (remote yok)" >> "$LOG" && continue

  # Uncommitted değişiklik varsa çekme — üzerine yazma
  dirty=$(git status --short 2>/dev/null | wc -l | tr -d ' ')
  if [ "$dirty" -gt "0" ]; then
    echo "⚠ $name ($dirty uncommitted değişiklik, atlandı)" >> "$LOG"
    continue
  fi

  branch=$(git branch --show-current 2>/dev/null)
  [ -z "$branch" ] && continue

  # Fast-forward pull (çakışma yaratmaz)
  result=$(git pull --ff-only origin "$branch" 2>&1)
  if echo "$result" | grep -q "Already up to date"; then
    echo "✓ $name (güncel)" >> "$LOG"
  elif echo "$result" | grep -q "Fast-forward\|Updating"; then
    echo "⬇ $name (güncellendi)" >> "$LOG"
    updated=$((updated + 1))
  else
    echo "✗ $name (hata: $result)" >> "$LOG"
  fi
done

echo "" >> "$LOG"
echo "Tamamlandı." >> "$LOG"
cat "$LOG"
