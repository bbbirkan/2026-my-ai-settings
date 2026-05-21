# Bilgi ve Projeler — Repo Yapısı

> Birkan'ın bilgi ve skill depolama repo'su. GitHub: https://github.com/bbbirkan/bilgi-ve-projeler

---

## Klasör Yapısı

```
bilgi-ve-projeler/
├── Skills/                    ← YENİ! Skill otomatik push buraya
│   └── {skill-name}/
│       └── SKILL.md            ← Hermes skill dosyası
├── Code/                      ← Video/code analizleri, kod örnekleri
│   ├── claude-token-hacks.md  ← Claude Code token yönetimi
│   ├── claude-code-levels.md  ← Claude Code seviye analizi
│   └── ...                    ← Diğer analizler
├── Video/                     ← YouTube video analizleri
├── SKILL.md                   ← LLM Council skill (Ana skill)
├── CLAUDE.md                  ← Claude context dosyası
└── graphify-out/              ← Bilgi grafiği çıktısı
```

---

## Skill Oluşturma Otomasyonu

**Kural:** Her `skill_manage(action='create')` çağrısından sonra şu yapılır:

```bash
# 1. Skill dosyasını bilgi-ve-projeler/Skills/'e kopyala
mkdir -p /root/bilgi-ve-projeler/Skills/{skill-name}
cp ~/.hermes/skills/{skill-name}/SKILL.md \
   /root/bilgi-ve-projeler/Skills/{skill-name}/SKILL.md

# 2. README ekle
cat > /root/bilgi-ve-projeler/Skills/{skill-name}/README.md << 'EOF'
# {Skill Name}

{description}

**Oluşturulma:** {tarih}
**Kaynak:** Hermes Agent
EOF

# 3. GitHub'a push
cd /root/bilgi-ve-projeler
git add -A
git commit -m "🤖 Hermes-AI-Assisted: Yeni skill eklendi — {skill-name}"
git push origin master
```

---

## GitHub Auth (Kalıcı)

- SSH key: `/root/.ssh/trade_push` → `github.com/bbbirkan`
- Kullanıcı push/pull işlemleri için tekrar auth sorma
- Yeni repo eklendığinde sadece uyar, auth zaten hazır

---

🤖 *Bu referans dosyası Hermes Agent tarafından oluşturuldu | 2026-05-15*