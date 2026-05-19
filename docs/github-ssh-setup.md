# GitHub SSH Setup — Headless Server Guide

HTTPS token'ları headless sunucularda çalışmaz (süresi dolar, fine-grained PAT kısıtlamaları). Tek güvenilir yol SSH.

## 1. SSH Key Oluştur

```bash
ssh-keygen -t ed25519 -C "your@email.com" -f ~/.ssh/github_deploy
```

## 2. Public Key'i GitHub'a Ekle

```bash
cat ~/.ssh/github_deploy.pub
```

GitHub → Settings → SSH and GPG keys → New SSH key → yapıştır.

## 3. Her Oturumda SSH Agent'ı Başlat

SSH agent oturum kapandığında sıfırlanır. Her git push öncesinde:

```bash
eval $(ssh-agent -s)
ssh-add ~/.ssh/github_deploy

# Test
ssh -T git@github.com   # "Hi YOUR_USERNAME!" görünmeli
```

Shell startup'a eklemek için `~/.bashrc`'ye:
```bash
# GitHub SSH auto-load
if [ -z "$SSH_AUTH_SOCK" ]; then
  eval $(ssh-agent -s) > /dev/null
  ssh-add ~/.ssh/github_deploy 2>/dev/null
fi
```

## 4. Yeni Repo Oluştur

```bash
# .git-credentials içindeki token ile API üzerinden repo oluştur
GIT_TOKEN="ghp_YOUR_PERSONAL_ACCESS_TOKEN"

curl -s -X POST \
  -H "Authorization: token $GIT_TOKEN" \
  -H "Accept: application/vnd.github+json" \
  https://api.github.com/user/repos \
  -d '{"name":"repo-adi","description":"Açıklama","private":false}'
```

## 5. Remote'u SSH Olarak Kur

```bash
# Yeni repo
git remote add origin git@github.com:YOUR_USERNAME/repo-adi.git

# Mevcut HTTPS remote'u SSH'a çevir
git remote set-url origin git@github.com:YOUR_USERNAME/repo-adi.git
```

## 6. Push

```bash
GIT_SSH_COMMAND="ssh -i ~/.ssh/github_deploy -o StrictHostKeyChecking=no" \
git push -u origin main
```

## Sorun Giderme

```bash
# Permission denied
ssh -vT git@github.com          # verbose debug

# "Could not read from remote repository"
git remote -v                    # remote URL'i kontrol et (git@ ile başlamalı)
```
