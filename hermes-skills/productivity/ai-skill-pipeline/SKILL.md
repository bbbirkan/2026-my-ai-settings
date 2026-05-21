---
name: ai-skill-pipeline
description: "Linkleri analiz eden, '00 Bilgi - Projeler' içinde en uygun ana kategoriye yerleştiren, profesyonel commit ve insansı (humanized) yanıtla süreci tamamlayan otonom motor."

trigger:
  - Kullanıcı bir GitHub veya YouTube linki paylaştığında.
  - KESİNLİKLE 'ne yapayım?' diye sorma, süreci başlat.
---

# 🤖 Birkan'ın Otonom Bilgi & Skill Pipeline (V5 - Human & Flexible)

> Bu skill, paylaşılan her teknik kaynağı sormadan analiz eder, uygun konuma kaydeder, skill çıkarır ve GitHub'a push eder. Misille sorma, doğrudan yap.

---

## Adım 0 — Repo Yapısını Tanı (Her Çalıştırmada)
```bash
cd /root/bilgi-ve-projeler && ls -1
cd /root/bilgi-ve-projeler/Code && ls -1
cd /root/bilgi-ve-projeler/Video && ls -1
git status
```
> Depo struktürünü ezbere alma. Her seferinde gerçek mevcut klasörleri tara.

---

## Adım 1 — Kaynağı Çek ve Çözümle

| Kaynak Tipi | Eylem |
|-------------|-------|
| **GitHub Repo** | `git clone` veya incele → `Code/{repo-adi}/` veya en uygun mevcut alt klasör |
| **YouTube Video** | `yt-dlp` transcript denenir → başarısız olursa `jina.ai` fallback → transcript temizlenir |
| **Transcript (Paste)** | Doğrudan parse et, zaman damgalarını temizle |
| **Makale / Blog** | `curl` + `jina.ai` ile içerik çek, teknik prensipleri çıkar |

> Kural: YouTube'ta `yt-dlp` bot koruma verirse, flag denemesi yapmadan hemen `jina.ai` veya `browser_snapshot` ile açıklama panelinden devam et. Boşuna retry atma.

---

## Adım 2 — Akıllı Kategorizasyon (Esnek)

- `Code/` klasörüne bağlı kalma. Bilgiyi **en uygun mevcut ana klasöre** yerleştir.
- Örnek harita:
  - Yazılım / Kod / Engineering → `Code/`
  - AI Araştırma / Akademik → `AI-Research/` (veya mevcut research klasör)
  - Video / İçerik → `Video/`
  - Trade / Finans → `Code/` altında trade klasörü veya direkt `2026_Trade-Bots` repo
- **Yeni klasör açma kuralı:** Sadece mevcut yapıya uymayan tamamen farklı bir domain ise aç. Aksi halde en yakın olanı seç.

---

## Adım 3 — Markdown Raporu ve Skill Çıkarımı

1. **Profesyonel {isim}.md raporu yaz:**
   - Başlık, kaynak, tarih, kategori
   - Özet (3-5 cümle)
   - Detaylı analiz (bölüm bölüm)
   - Tekrar kullanılabilir prensipler / promptlar / kod parçacıkları
   - "X sistemine Uygulanabilir Çıkarımlar" tablosu (gerekirse)

2. **Skill gerekip gerekmediğine karar ver:**
   - Sadece gerçekten otonom çalışan bir yetenek ise → bütünsel `SKILL.md` dosyası oluştur
   - Değilse → reusable prompt'ları ve notları ana `.md`'ye yerleştir, ayrı skill dosyası açma

3. **Masaüstü yedek (opsiyonel):**
   - Kullanıcı "masaüstüne de at" derse vveya dosya kritik öneme sahipse `/root/Desktop/` 'e kopya at

---

## Adım 4 — Git Sync (Hermes İmzalı)

**Zorunlu format:** Tüm commit mesajları `🤖 Hermes-AI-Assisted:` prefix'i ile başlar.

```bash
cd /root/bilgi-ve-projeler
git add -A
git commit -m "🤖 Hermes-AI-Assisted: {isim} — {ne yapildi} | {aciklama kisa}"
git push origin master
```

> Commit mesajında şunlar OLMALI:
> - `🤖 Hermes-AI-Assisted:` prefix
> - Dosya/kaynak ismi
> - Ne yapıldı (analiz, skill çıkarımı, güncelleme vb.)
> - Kısa açıklama (bir cümle)

**Dokümantasyona Hermes footer ekle:**
Her oluşturulan `.md` dosyasının altına ekle:
```markdown
---
🤖 *Bu doküman Hermes Agent tarafından oluşturuldu | 2026-05-15*
```
(Tarih her push'ta otomatik güncellenir)

> Eğer kaynak trade/otomasyon ile ilgiliyse ve `2026_Trade-Bots` reposuna da uygulanabilir çıkarım varsa:
> ```bash
> cd /root/trade-research-2026
git add -A
> git commit -m "🤖 Otonom Güncelleme: {X} trade sistemine entegre edildi"
> git push origin master
> ```

---

## 📁 Referanslar

- `references/repo-yapisi.md` — Bilgi-ve-projeler repo yapısı, Skills klasörü otomasyonu, GitHub auth bilgileri

---

## Adım 5 — Humanized Yanıt + Hermes Mark

**YASAK:** Robotik raporlama. "Adım 1 tamamlandı, Adım 2 tamamlandı..." tarzı liste yapma.

**ZORUNLU:** humanizer skill felsefesiyle kısa, öz, doğal Türkçe.

**Örnek formatlar:**
- *"Tamamdır, `{X}` aldım. Hermes imzalı olarak `Code/` altına attım, GitHub'a da sync yaptım. Başka ne yapalım?"*
- *"İşlem tamam. `{X}` çözüldü ve Hermes-AI imzasıyla push edildi. Sorun var mı?"*
- *"Halledildi — `{X}` analiz edildi, Hermes damgası vuruldu, repo güncellendi. Devam mı?"*

**Always include Hermes sign-off:**
Her yanıtın sonunda: `🤖 Hermes-AI-Assisted` ibaresi veya emoji.

---

## ⚠️ Pitfalls

1. **Kullanıcıya sorma.** Link gelince direkt pipeline başlar. "Nereye koyalım?" yok.
2. **Mevcut yapıyı görmezden gelme.** Önce `ls` ile gerçek klasör yapısına bak.
3. **Boşuna retry.** `yt-dlp` bot koruma verince flag deneme, hemen fallback'e geç.
4. **Git conflict varsa auto-resolve.** `git pull --rebase` ile önce remote değişiklikleri al, sonra push et.
5. **Trade içeriyorsa trade repo'sunu da güncelle.** Sadece `bilgi-ve-projeler` yetmez.
6. **Kullanıcıya model layering açıklaması yapma.** "Neden iki model kullanıyorsun?" sorusu geldiğinde kısa ve doğrudan cevap ver. Hermes'in internal architecture'ını uzun uzun açıklama — kullanıcı kafası karışmasın diye değil, gereksiz detay verme. Gerekirse "Sen konuşurken bir model, arka plan işleri için başka model çalışıyor" de ve bitir.
7. **Aynı dosyalara çift push yapma.** Birden fazla repo güncellenecekse her birini ayrı commit'le, aynı dosya içeriğini tekrar tekrar yazma.
8. **Skill oluşturulduğunda otomatik GitHub push.** `skill_manage(action='create')` ile yeni skill oluştuğunda, skill dosyasını `bilgi-ve-projeler/Skills/{skill-name}/SKILL.md` olarak kopyala ve push et.
9. **TÜM SKİLL'LER MERKEZİ YEDEĞİ.** `~/.hermes/skills/` içindeki her skill'in bir kopyası `bilgi-ve-projeler/Skills/` klasöründe olmalı. Bu hem yedekleme hem de kullanıcının bilgisayarına indirme imkanı sağlar. Her skill oluşturulduğunda, güncellendiğinde veya见我 (skill_manage action='patch') çalıştırıldığında senkronizasyon yapılır.

---

## 🚀 Skill Oluşturma Otomasyonu (OTOMATIK)

Her `skill_manage(action='create')` veya `skill_manage(action='patch')` çağrısından sonra şu adımları otomatik yap:

```bash
# 1. Skill dosyasını bilgi-ve-projeler'e kopyala
mkdir -p /root/bilgi-ve-projeler/Skills/{skill-name}
cp ~/.hermes/skills/{category}/{skill-name}/SKILL.md /root/bilgi-ve-projeler/Skills/{skill-name}/SKILL.md 2>/dev/null || \
cp ~/.hermes/skills/{skill-name}/SKILL.md /root/bilgi-ve-projeler/Skills/{skill-name}/SKILL.md 2>/dev/null

# 2. Kategori altında ise yetişkin klasör yapısını koru
# Örnek: birkan-ai-model-scout → Skills/birkan-ai-model-scout/SKILL.md
# Örnek: creative/humanizer → Skills/creative-humanizer/SKILL.md

# 3. README ekle (opsiyonel)
cat > /root/bilgi-ve-projeler/Skills/{skill-name}/README.md << 'EOF'
# {Skill Name}

{description}

**Oluşturulma:** {tarih}
**Kaynak:** Hermes Agent
EOF

# 4. GitHub'a push
cd /root/bilgi-ve-projeler
git add -A
git commit -m "🤖 Hermes-AI-Assisted: Yeni/Güncellenmiş skill — {skill-name}"
git push origin master
```

---

## 🔄 TOPLU SKILL SENKRONİZASYONU (Manuel veya Cron)

Kullanıcı "tüm skill'leri senkronize et" veya "skill yedeğini al" derse:

```bash
# 1. Tüm skill'leri tara
for skill_dir in ~/.hermes/skills/*/; do
    skill_name=$(basename "$skill_dir")
    # nested category ise temizle
    skill_name_clean=$(echo "$skill_name" | tr '/' '-' | tr '_' '-')
    
    # Hedef klasör
    mkdir -p /root/bilgi-ve-projeler/Skills/$skill_name_clean
    
    # SKILL.md dosyasını bul ve kopyala
    if [ -f "$skill_dir/SKILL.md" ]; then
        cp "$skill_dir/SKILL.md" "/root/bilgi-ve-projeler/Skills/$skill_name_clean/SKILL.md"
    elif [ -f "~/.hermes/skills/$skill_name/SKILL.md" ]; then
        cp "~/.hermes/skills/$skill_name/SKILL.md" "/root/bilgi-ve-projeler/Skills/$skill_name_clean/SKILL.md"
    fi
done

# 2. GitHub'a push
cd /root/bilgi-ve-projeler
git add -A
git commit -m "🤖 Hermes-AI-Assisted: Tüm skill'ler senkronize edildi — $(date '+%Y-%m-%d')"
git push origin master
```

> **KURAL:** `bilgi-ve-projeler/Skills/` = Merkezi skill yedeği. Burada olmayan skill olmaz. Her yeni skill doğrudan buraya gider. Kullanıcı bilgisayarından `git pull` ile istediği skill'i indirebilir.

---

> Not: `skill_manage` zaten skill'i `~/.hermes/skills/` 'e kaydeder. Biz ek olarak `bilgi-ve-projeler/Skills/` 'e de copy+pushed yaparız ki kullanıcı bilgisayarından indirbilsin.

## 📎 Referanslar

- `references/youtube-transcript-analysis-template.md` — Transcript bazlı video analizinin adım adım şablonu

---

*Not: Bu sürüm profesyonelliği ile iletişimin doğallığını birleştirir. GitHub auth önceden yapılmıştır, tekrar sorma.*