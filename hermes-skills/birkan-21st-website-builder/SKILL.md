---
name: birkan-21st-website-builder
description: |
  21st.dev MCP + Framer Motion + Claude Code ile tek komutla
  profesyonel web sitesi oluşturma. 10.000$+ değerinde site,
  0 saat tasarım çalışması. Boris Cherny yöntemi.

  TRIGGER bu skill'i şu durumlarda çağır:
  - "web sitesi yap", "landing page", "21st.dev" bahsi geçtiğinde
  - "framer motion", "animasyonlu site" istendiğinde
  - Hızlı prototip veya prodüksiyon sitesi gerektiğinde
---

# 21st.dev Web Site Builder

## Gereksinimler

```bash
node --version    # 18+ olmalı
npm install -g @anthropic-ai/claude-code
npm install framer-motion
```

Hesaplar:
- [21st.dev](https://21st.dev) — ücretsiz hesap (MCP URL için)
- `ANTHROPIC_API_KEY` env değişkeni tanımlı

## Kurulum (tek seferlik)

### 1. Claude Code'u başlat
```bash
claude
```

### 2. UI/UX Pro Max Skill ekle
Claude Code içinde:
```
Claude Code ayarları → Skills/Tools → "UI/UX Pro Max" ara ve ekle
```

### 3. 21st.dev MCP bağla
21st.dev hesabından MCP server URL'ini al, Claude Code'a ekle:
```
/mcp add 21st-dev <MCP_SERVER_URL>
```

## Site Oluşturma Komutu

```
/21st build a professional [niş] website
```

**Niş örnekleri:**
- `SaaS landing page`
- `creative agency`
- `personal portfolio`
- `e-commerce store`
- `AI startup`
- `consulting firm`

## Birkan'ın Projeleri İçin Örnekler

```
/21st build a professional AI automation agency website for Anvilon
with dark theme, Framer Motion animations, and a hero section
showing autonomous AI workflows

/21st build a SaaS landing page for a YouTube automation tool
called VisionWatch with pricing, features, and demo sections

/21st build a personal portfolio for an AI systems architect
showcasing automation projects and blog posts
```

## Çıktı Sonrası Refinement

Site oluşturulduktan sonra natural language ile düzenle:

```
"add a pricing section with 3 tiers"
"make the hero darker and more futuristic"
"add a testimonials section"
"change the accent color to purple"
"add smooth scroll animations to all sections"
```

## Ne Üretilir?

- Temiz, düzenlenebilir React/Next.js kodu
- Responsive tasarım (mobile-first)
- Framer Motion animasyonları (fade, slide, scroll-triggered)
- Profesyonel bileşen yapısı
- Deploy-ready (Vercel, Netlify, vb.)

## Deploy

```bash
# Vercel
npx vercel --prod

# Netlify
npx netlify deploy --prod

# Kendi sunucuya (bu VPS)
npm run build && cp -r dist/ /var/www/site/
```

## Maliyet Analizi

| Yöntem | Süre | Maliyet |
|--------|------|---------|
| Freelancer'a yaptır | 2–4 hafta | $3,000–$10,000 |
| Template al | 2–5 gün | $50–$200 |
| **Bu yöntem** | **~1 saat** | **$0 (API maliyeti hariç)** |
