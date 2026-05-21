---
name: ai-video-watch
description: |
  Claude'a herhangi bir videoyu izleme yeteneği kazandıran skill — yt-dlp ile indirir, ffmpeg ile frame çeker, transcript alır, Claude'a iletir. /watch komutu ile çalışır.

  TRIGGER bu skill'i şu durumlarda çağır:
  - video izle, video analiz et, YouTube video, /watch komutu, yt-dlp bahsi geçtiğinde
kurulum: ~/.claude/skills/watch (git clone yapıldı)
kaynak: https://github.com/bradautomates/claude-video
---

# claude-video — `/watch` Skill

Claude normalde video göremez. Bir YouTube linki verirsen tahmin eder ya da caption'dan okur. Bu skill bunu çözer: **Claude videoyu gerçekten izler.**

## 💡 Ne Zaman Kullanılır

- Bir YouTube videosunu özetlemek istediğinde (20 dakikalık videoyu 30 saniyede kavramak)
- Rakip / viral içeriğin yapısını analiz etmek istediğinde ("hook nasıl kurulmuş?")
- Ekran kaydındaki bir bug'ı Claude'a göstermek istediğinde
- TikTok, Vimeo, Instagram, Loom gibi platformlardaki içerikleri işlemek için
- Lokal `.mp4 / .mov / .mkv / .webm` dosyalarını analiz etmek için

## 🚀 Kurulum

```bash
# Yapıldı ✅
git clone https://github.com/bradautomates/claude-video.git ~/.claude/skills/watch
```

**Bağımlılıklar** (macOS'ta otomatik kurulur, bunlar zaten mevcut):
- `ffmpeg` ✅ — frame extraction
- `yt-dlp` ✅ — video indirme

**Opsiyonel API Key** (altyazısı olmayan videolar için):
```
~/.config/watch/.env
GROQ_API_KEY=...    # tercih edilen (ucuz + hızlı)
OPENAI_API_KEY=...  # fallback
```

## 📖 Kullanım

```bash
# Temel kullanım
/watch https://youtu.be/VIDEO_ID bu videoda ne anlatılıyor?

# Belirli bir bölüm
/watch https://youtu.be/VIDEO_ID --start 0:30 --end 1:30 bu bölümde ne var?

# Lokal dosya
/watch ~/Movies/ekran-kaydi.mp4 UI nerede bozuluyor?

# Hook analizi
/watch https://youtu.be/VIRAL_VIDEO ilk 5 saniye nasıl kurulmuş?

# Özet
/watch https://youtu.be/UZUN_VIDEO özet yaz
```

## ⚙️ Nasıl Çalışır

1. **URL/path** → `yt-dlp` ile indirir (YouTube, TikTok, Vimeo, X, Instagram + 400 site)
2. **Frame extraction** → `ffmpeg` ile otomatik frame rate hesaplayarak çeker
   - ≤30s → ~30 frame | 1-3dk → ~60 frame | max 100 frame, max 2fps
3. **Transcript** → önce native caption (ücretsiz), yoksa Whisper API (Groq/OpenAI)
4. **Claude'a iletir** → frame'ler görüntü olarak + transcript zaman damgalı
5. **Claude cevaplar** → "izlemiş biri gibi" — tahmin değil, gerçek analiz

## ⚠️ Limitler

| Limit | Detay |
|---|---|
| En iyi sonuç | 10 dakika altı videolar |
| Max frame | 100 (token bütçesi için) |
| Max Whisper upload | 25 MB (~50dk mono ses) |
| Private platformlar | Desteklenmiyor (login gerektiren siteler) |

## 📁 Referanslar

- [GitHub Repo](https://github.com/bradautomates/claude-video)
- [Kurulum dizini](file:///Users/birkan/.claude/skills/watch)
- Yapımcı: [@bradautomates](https://github.com/bradautomates)
