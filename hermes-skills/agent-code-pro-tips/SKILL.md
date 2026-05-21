---
name: agent-code-pro-tips
description: "Claude Code terminal kullanımı için 20 ileri düzey ipucu, OneContext ile kalıcı (Git benzeri) ajan hafızası yönetimi ve 'Ajan değil Skill inşa edin' felsefesi."
---
# Claude Code Pro İpuçları ve Ajan Hafıza Mimarisi

Bu yetenek, Claude Code'u daha hızlı, ucuz ve "akıllı" kullanmanızı sağlayacak terminal kısa yollarını, maliyet yönetimi tekniklerini ve hafıza kaybını önleyen "OneContext" mimarisini içerir.

## ⚡ En Kritik 10 Claude Code Terminal İpucu

1. **Root (Kök) Dizinde Başlatın:** Claude'u her zaman projenin ana klasöründe çalıştırın. Yoksa üst klasördeki konfigürasyonları okuyamaz.
2. **`/init` ve `.claudemd` Yönetimi:** Projeye başlarken `/init` komutu ile `.claudemd` oluşturun. Bu dosyayı **maksimum 300-400 satırda** tutun. En önemli kuralları (build ve validation adımları gibi) EN ÜSTE, önemsizleri EN ALTA yazın (Claude dosyayı yukarıdan aşağıya okur).
3. **Double ESC (Sıfırlama / Geri Alma):** Terminalde yazdığınız uzun bir promptu silmek veya Claude'un o an yaptığı işlemden tamamen çıkıp terminali temizlemek için peş peşe **2 kez ESC tuşuna** basın.
4. **Shift + Tab:** Planlama modu ve Edit (düzenleme) modu arasında hızlı geçiş sağlar.
5. **Görsel Bağlam (Drag & Drop):** Terminal açıkken doğrudan UI veya hata ekran görüntüsünü (screenshot) terminal penceresine sürükleyip bırakarak görsel kontekst verebilirsiniz.
6. **`/clear` (Token Tasarrufu):** Bir işi bitirdiğinizde `/clear` yazıp sohbeti temizleyin. Uzun sohbetler token maliyetini fırlatır.
7. **`/compact` (Manuel Sıkıştırma):** Hafızayı silmek istemiyor ama daraltmak istiyorsanız, bu komutla tüm geçmişi kısacık bir özete çevirebilirsiniz.
8. **`/context` (MCP Maliyet Analizi):** Token limitiniz çabuk bitiyorsa bu komutu girin. Claude'un hangi MCP'lere veya dosyalara ne kadar token harcadığını görün. Gereksiz MCP'leri oradan kapatın.
9. **Kesmekten Çekinmeyin:** Claude cevap yazarken beklemek zorunda değilsiniz. **ESC** tuşuna basıp işlemi anında durdurun ve yönlendirin.
10. **Git Entegrasyonu:** `.claudemd` dosyanıza her başarılı özellikten sonra otomatik olarak "Commit & Push" yapmasını söyleyin. Bu sizin "geri sarma" güvenli alanınızdır.

## 🧠 OneContext (Git Context Control) ile Kalıcı Hafıza
Ajanlar uzun görevlerde veya token limiti dolduğunda aptallaşmaya, denedikleri şeyleri unutmaya başlar. `OneContext` (Git Context Controller), tıpkı Git (versiyon kontrol) gibi bir dosya sistemi kurarak ajanın bilgisinin kalıcı olmasını sağlar.

* **Nasıl Kurulur?** `npm i -g onecontext-ai`
* **Mimarisi:** 
  * `main.md`: Projenin global hedefini tutar.
  * **Branch:** Alternatif çözüm yolları denediğinde açtığı klasörler (Örn: Playwright ile çekme vs. API ile çekme).
  * `commit.md`: Ulaştığı kilometre taşları ve özetler.
  * `log.md`: Geçmişteki tüm raw (ham) diyalogları tutar.
* **Avantajı:** Bu sayede Claude Code, OpenAI Codex veya herhangi bir ajan modeli, aynı hafızayı aynı projedeki farklı oturumlarda da paylaşabilir. Ajan bir dahaki sefere baştan başlamaz.

## 🏛️ Anthropic Felsefesi: "Ajan Değil, Skill (Yetenek) İnşa Edin"
Anthropic'in resmi tavsiyesine göre; yapay zeka ajanları çok zeki "genel uzmanlar"dır. Onlardan verim alabilmek için ajanı baştan yapmak yerine, ona okuyacağı bir "Skill" vermelisiniz.

* **Progressively Disclosed (Aşamalı Açıklama):** Ajan tüm skill'leri aynı anda okumaz. Sadece isimlerine bakar, görevle ilgili olan (örneğin bir SEO Audit göreviyse SEO skill'i) skill dosyasını o an raftan alır ve okur. 
* **Paralel Sub-Agent'lar:** Bir tek skill dosyasının içine, "Bu görevde 5 tane farklı alt ajanı aynı anda çalıştır (Örn: Birisi linkleri tarasın, diğeri içeriği okusun)" şeklinde talimatlar yazarak inanılmaz hız ve verim alabilirsiniz.
