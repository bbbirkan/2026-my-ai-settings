---
name: hermes-agent-mastery
description: "Hermes Agent'ı sıradan bir bottan çıkarıp tam otonom 7 seviyeli bir sisteme (VPS, Discord, Kanban, Holographic Hafıza, MCP Backend) dönüştürme rehberi."
---
# Hermes Agent Mastery (7 Seviyeli Kurulum Rehberi)

Hermes Agent'ı sadece bilgisayarınızda çalışan düz bir yapay zekadan, 7/24 uyanık kalan ve sizi Discord'dan asiste eden profesyonel bir ekibe dönüştürmek için aşağıdaki "7 Seviyeyi" tamamlamanız gerekir.

## 🚀 Seviye 1: VPS ve Açık Kaynak API (Temeller)
Kendi bilgisayarınızda çalıştırmak yerine, Hermes'in 7/24 uyanık kalması için bir **VPS (Sanal Sunucu)** (Örn: Hostinger vb.) kurun.
* SSH ile sunucuya bağlanıp kök (root) dizinde tek satırlık hızlı kurulum komutunu çalıştırın.
* API masraflarını düşürmek ve en iyi modellere ulaşmak için **OpenRouter** üzerinden API Key girin (Asla ucuz ve küçük modeller kullanmayın, mimari çok karmaşıktır. Örn: Opus, Claude 3.5 Sonnet vb. kullanın).

## 💬 Seviye 2: Discord Gateway (Uzaktan Kumanda)
Hermes'e terminalden değil, telefonunuzdaki Discord veya Telegram'dan hükmetmek için:
1. Discord Developer Portal'dan yeni bir Bot oluşturun.
2. Token'ı alın ve **"Privileged Gateway Intents"** kısmındaki 3 ayarı (Presence, Server Members, Message Content) açın.
3. Terminalde `hermes gateway setup` yazın ve Discord'u seçip token'ınızı girin.
4. Artık Discord üzerinden @Hermes diyerek ajanınızla mesajlaşabilirsiniz.

## 🧹 Seviye 3: Hermes Curator (Token Tasarrufu)
Zamanla kullanılmayan yetenekler (skills) birikir ve ajan her seferinde bunları okuduğu için (Context Rot) binlerce dolar API faturası ödersiniz.
* `hermes update` ile sistemi güncelleyin.
* Otomatik olarak kurulu gelen **Hermes Curator**, 30 gündür kullanılmayan skill'leri pasife alır, 90 gün kullanılmayanları ise siler.

## 🤖 Seviye 4: Cron Jobs (Zamanlanmış Görevler ve Otomasyon)
Ajanınıza rutin işler atayabilirsiniz. En önemlisi: **Günlük GitHub Yedeklemesi**.
1. Private (Gizli) bir GitHub reposu açın.
2. GitHub Settings > Developer Settings'ten "Read & Write" yetkili bir **Personal Access Token (PAT)** oluşturun.
3. Terminalde token'ı güvenlice kaydedin: `hermes config set github_token SIZIN_TOKEN`
4. Hermes'e Discord'dan şu promptu yazın: *"Her gece 03:00'te tüm klasörümü GitHub repoma yedekleyen bir cron job oluştur."* 

## 📊 Seviye 5: Kanban Board (Multi-Agent Yönetimi)
Hermes'in en vurucu özelliği, tek bir ajanın değil, **paralel çalışan ajanların** (Araştırmacı, Yazar, İnceleyici) görevleri kendi kendine Kanban panosundan (Trello gibi) alıp yapmasıdır.
* Kurulumu sizin yapmanıza gerek yok, Hermes'e sadece "Kanban Board özelliğini kur" deyin; o kendi sanal tarayıcısını açıp kodları okuyup sistemi kuracaktır.
* Siz sadece arayüzden hangi ajanın hangi görevi bitirdiğini izlersiniz.

## 🧠 Seviye 6: Holographic Memory (Sonsuz Hafıza)
Ajanlar uzun konuşmalardan sonra unutmaya başlar. RAG (Vektör tabanlı okuma) hem pahalıdır hem verinizi sızdırır.
* Terminalde `hermes memory setup` yazın.
* Gelen listeden **Holographic** (Lokal SQLite veritabanı) hafızayı seçin.
* Bu özellik, konuşmaların sonundaki gereksiz lafları atıp ("Tamam efendim, yapıyorum"), sadece "Birkan 500 satırlık dosyalar sevmez, VPS IP'si şudur" gibi katı gerçekleri (facts) depolar.

## 🔌 Seviye 7: Hermes'i MCP Sunucusuna Çevirmek (Ultimate Mode)
Bu seviye Hermes'i diğer ajanlara (Claude Code, Cursor) hizmet eden bir "Arka Uç (Backend)" yapar.
* **Kullanım Senaryosu 1 (Walk Away Mode):** Claude Code'a devasa bir refactor işlemi verirsiniz ve bilgisayarı kapatıp gidersiniz. Claude Code, Hermes'in MCP sunucusuna bağlanarak işlemi her bitirdiğinde Discord üzerinden cebinize bildirim yollar.
* **Kullanım Senaryosu 2 (Remote Approval Gate):** Claude bilgisayarınızdaki kritik bir dosyayı silmek istediğinde sizden onay bekler; Hermes MCP sayesinde bu onay bildirimi telefonunuza gelir. Onaylarsanız bilgisayarınızdaki Claude işlemi tamamlar.
