---
name: birkan-video-watch
description: |
  Herhangi bir videoyu izleme, analiz etme ve özetleme yeteneği.
  YouTube, TikTok, Instagram, Loom, lokal MP4 desteklenir.
  yt-dlp ile indirir, ffmpeg ile frame çeker, Groq Whisper ile transkript alır.

  Bu skill'i şu durumlarda kullan:
  - Video izle, video analiz et, video özet, YouTube analizi
  - "bu videoyu izle", "videoyu özetle", "hookunu çıkar"
  - /watch komutu verildiğinde
  - Piyasa haberleri videosu, Fed açıklaması, haber analizi
---

# 🎬 Video Watch Skill

Birkan'ın video izleme ve analiz sistemi. yt-dlp + ffmpeg pipeline'ı.

## Araçlar (sunucuda kurulu)
-  v2026.03.17 → /usr/local/bin/yt-dlp
-  → /usr/bin/ffmpeg

## Kullanım

Kullanıcı bir video URL'si verdiğinde şu adımları uygula:

### Adım 1 — Video İndir
```bash
# Transcript/altyazı al (önce ücretsiz YouTube altyazısı)
yt-dlp --write-auto-sub --write-sub --sub-lang tr,en   --skip-download -o /tmp/video_%(id)s   VIDEO_URL

# Eğer altyazı yoksa — ses indir (Whisper için)
yt-dlp -x --audio-format mp3 --audio-quality 0   -o /tmp/video_%(id)s.mp3 VIDEO_URL
```

### Adım 2 — Frame Çek
```bash
# Önce videoyu indir
yt-dlp -o /tmp/video_%(id)s.mp4 VIDEO_URL

# Frame'lere böl (her 10 saniyede 1 frame, max 50 frame)
ffmpeg -i /tmp/video_ID.mp4 -vf fps=0.1 /tmp/frames_%03d.jpg -loglevel quiet
```

### Adım 3 — Analiz Et
Frame'leri ve transkriptr birleştirerek analiz et.

## Kullanım Senaryoları

| Senaryo | Komut |
|---------|-------|
| Genel özet | "Bu videoyu özetle: URL" |
| Hook analizi | "Bu videonun hookunu analiz et: URL" |
| Piyasa haberi | "Bu Fed açıklamasını analiz et: URL" |
| Belirli bölüm | "URL - 2:30 ile 5:00 arası ne diyor?" |
| Rakip analizi | "Bu rakip videosunun yapısını çıkar: URL" |

## Desteklenen Platformlar
YouTube, TikTok, Twitter/X, Instagram, Vimeo, Loom, Dailymotion + 1000 site

## Limitler
- Max 100 frame (token bütçesi)
- Private/login gerektiren içerik desteklenmiyor
- En iyi: 10 dakika altı videolar

## Pitfall: YouTube Bot Protection

YouTube aggressively blocks headless/bot access. When `yt-dlp` fails with:
- `Sign in to confirm you're not a bot`
- `No supported JavaScript runtime could be found`
- Empty `timedtext` API responses

**Do NOT waste retries on yt-dlp flags.** Immediately switch to the jina.ai text-extraction fallback:

```bash
# Extract at least title + visible description via jina.ai
curl -sL "https://r.jina.ai/http://www.youtube.com/watch?v=VIDEO_ID" -A "Mozilla/5.0"
```

This returns the page text (title, channel, description, related videos). It is NOT a transcript, but it gives enough context for a summary. Report to the user that the transcript is unavailable due to bot protection, but metadata was extracted.

**Additional fallbacks (all usually fail):**
- `curl "https://www.youtube.com/api/timedtext?v=ID&lang=en&fmt=json3"` → returns empty body on headless servers
- `yt-dlp --extractor-args "youtube:player_client=android"` → still triggers bot check
- `youtube-transcript-api` Python package → same bot protection, requires `pip` which may not be installed. On this system use `uv pip install openai-whisper` if `uv` is available (`which uv`). Do NOT try plain `pip` — it is not installed.

**Do not attempt these — they waste time. jina.ai is the only reliable fallback.**

### When jina.ai fallback also fails (e.g. YouTube cookie wall blocks everything)

```bash
# jina.ai strips JS, but the cookie consent wall may still obscure content
curl -sL "https://r.jina.ai/http://www.youtube.com/watch?v=VIDEO_ID" -A "Mozilla/5.0"
```

If the output is only "Sign in to confirm you're not a bot" and no real metadata, then **all YouTube access methods have failed**. In this case:

1. **If the video is ABOUT a paper/article** (Nature, arXiv, blog) → skip YouTube entirely, fetch the primary source via `r.jina.ai/http://nature.com/articles/...` or browser.
2. **If the user insists on the video itself** → ask them to paste the transcript manually, or upload the video file directly.
3. **Never attempt browser navigation to extract YouTube transcripts.** Even after accepting/rejecting cookies, the transcript panel is behind a shadow-DOM or async load that the browser tool cannot reliably reach. Multiple session attempts (May 2026) confirmed this is a dead end.

**If the YouTube video is ABOUT a paper/article (like a Nature paper review):**
Skip transcript entirely and go straight to the primary source (Nature.com, arXiv, etc.). Extract the full text via `r.jina.ai/http://...` or browser, then summarize. The video is secondary.

**Browser tool is NOT a reliable transcript source.** YouTube's cookie consent dialog (`Before you continue to YouTube`) blocks content even after clicking reject/accept, and the transcript panel is not accessible via standard DOM extraction.

## Trade Bot Kullanımı
Piyasa haberlerini, Fed açıklamalarını, CNBC/Bloomberg videolarını analiz ederek
sentiment puanı ve özet çıkar. Örnek:
"Bu CNBC videosunu izle ve BTC üzerindeki etkisini değerlendir: URL"
