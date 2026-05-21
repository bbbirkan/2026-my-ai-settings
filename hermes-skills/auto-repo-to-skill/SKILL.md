---
name: auto-repo-to-skill
description: "Kullanıcıdan gelen GitHub linklerini veya araç bilgilerini otomatik analiz edip SKILL dosyasına dönüştüren 4 adımlı standart pipeline."
---

# Auto-Repo-to-Skill Pipeline (Mobil Hızlı Entegrasyon)

Bu skill, kullanıcı sana (Telegram üzerinden vb.) bir link veya araç dokümanı atıp **"Bunu sisteme ekle"**, **"Skill yap"** veya **"Nasıl entegre ederiz?"** dediğinde tetiklenir.

Görevin, Antigravity (Masaüstü AI) modelinin uyguladığı 4 adımlı standart prosedürü otonom olarak işletmektir.

## 🔄 4 Adımlı Standart Prosedür

### Adım 1: Analiz ve Klonlama (Analyze & Clone)
- Verilen linkteki projeyi geçici bir klasöre klonla veya README'sini oku.
- Aracın ne işe yaradığını, değer önerisini ve limitlerini anla.

### Adım 2: Bağımlılık ve Sistem Taraması (Dependency Scan)
- `requirements.txt` veya `package.json` kontrolü yap.
- Sistemde nelerin kurulması gerektiğini listele. 

### Adım 3: SKILL Dosyası Üretimi (Skillify)
- Projeyi Hermes'in (veya Claude'un) kullanabileceği kalıcı bir formata çevir.
- **Standart bir `SKILL.md` dosyası yaz.** (İçinde Trigger, Kullanım Şekli, Mimari Entegrasyon Notları bulunsun).
- Dosyayı sunucuda `/root/.hermes/skills/PROJE_ADI/SKILL.md` yoluna kaydet.

### Adım 4: Masaüstü İçin Hazırlık (Export)
- Sadece senin (Hermes) değil, Masaüstündeki Antigravity'nin de bu skill'i kullanabilmesi için hazırlık yap.
- Kullanıcıya Masaüstüne kopyalaması için Skill dosyasının içeriğini veya indirme yolunu ver.

## 📤 Kullanıcıya Raporlama Şablonu
İşlem bittiğinde kullanıcıya şu formatta net ve kısa bir mesaj dön (Kullanıcı mobilde, destan yazma):

1. 🎯 **Ne İşe Yarıyor?** (Tek cümlelik özet)
2. 🛠 **Ne Yaptım?** (Nereye kuruldu, hangi `SKILL.md` oluşturuldu)
3. 📦 **Gereksinimler:** (Neler indirilmeli, API key lazım mı?)
4. 🤖 **Masaüstü (Antigravity) Adımı:** "Antigravity'e şu komutu vererek masaüstü senkronizasyonunu başlatabilirsin..."

**Kritik Kural:** Kullanıcı dışarıda ve telefonda olduğu için ondan uzun komutlar girmesini isteme. İşi sen yap, ona sadece onaylamak ve incelemek kalsın.
