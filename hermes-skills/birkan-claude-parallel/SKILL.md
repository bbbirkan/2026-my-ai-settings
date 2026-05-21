---
name: birkan-claude-parallel
description: |
  Boris Cherny yöntemiyle 5 paralel Claude Code session yönetimi.
  Root sunucuda CLAUDE_CODE_BUBBLEWRAP bypass ile tmux üzerinden
  eş zamanlı 5 bağımsız Claude instance çalıştırma rehberi.

  TRIGGER bu skill'i şu durumlarda çağır:
  - "paralel claude", "5 claude", "aynı anda" bahsi geçtiğinde
  - Boris Cherny ipucu #1 veya worktree sorulduğunda
  - Büyük işleri birden fazla agent'a bölmek istendiğinde
---

# Birkan Paralel Claude — 5 Eş Zamanlı Session

Boris Cherny'nin #1 üretkenlik sırrı: 5 Claude'u aynı anda çalıştır.

## Sunucu Durumu

- **Root sorunu çözüldü:** `CLAUDE_CODE_BUBBLEWRAP=1` ~/.bashrc'de kalıcı
- **Default mod:** `bypassPermissions` — hiç prompt yok
- **Script:** `/root/claude-parallel.sh`

## Hızlı Başlangıç

```bash
# Herhangi bir proje dizininde 5 paralel session aç:
./claude-parallel.sh /root/2026-visionwatch

# Hepsinde claude'u da otomatik başlat:
./claude-parallel.sh /root/2026-visionwatch --start
```

## tmux Kontrolleri

| Tuş | Eylem |
|-----|-------|
| `Ctrl+B → 1` | C1 penceresine geç |
| `Ctrl+B → 2..5` | C2–C5 arası geçiş |
| `Ctrl+B → n` | Sonraki pencere |
| `Ctrl+B → d` | Session'ı bırak (arka planda çalışır) |
| `tmux attach -t claude-parallel` | Geri bağlan |

## İş Bölümü Stratejisi

Her Claude'a farklı bir rol ver:

| Pencere | Görev |
|---------|-------|
| C1 | Yeni özellik geliştirme |
| C2 | Test yazma / çalıştırma |
| C3 | Bug fix |
| C4 | Kod review / refactor |
| C5 | Dokümantasyon / CLAUDE.md güncelleme |

## Sub-Agent Gönderme

Bir Claude'dan diğerine iş gönder:

```
C1'deki Claude'a şunu söyle:
"Bu auth modülü için test yaz, ben C2'de API'yi geliştiriyorum"
```

## Boris'in Kuralı

> "Birden fazla konuşma aynı dosyayı düzenlemesin."
> Her Claude'a ayrı dosya/modül ver. Conflict yok, merge yok.

## Mevcut Projeler

```bash
./claude-parallel.sh /root/2026-visionwatch      # YouTube projesi
./claude-parallel.sh /root/anvilon-web-prod       # Anvilon sitesi
./claude-parallel.sh /root/2026-trucking-survival-sim  # Trucking sim
./claude-parallel.sh /root/bilgi-ve-projeler      # Skills repo
```
