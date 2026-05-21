---
name: content-autoresearch
description: "Andrej Karpathy'nin AutoResearch mimarisini içerik üretimine (Instagram/Facebook Reels) uygulayan 24 saatlik otonom gelişim döngüsü."
---
# Content AutoResearch (Otonom İçerik Geliştirme Döngüsü)

Bu skill, yapay zekanın rastgele içerik üretmesi yerine, **gerçek verilere dayanarak kendi promptlarını her gün iyileştirdiği** kapalı bir döngü kurmak için kullanılır.

## 🔄 Sistem Mimarisi (24 Saatlik Döngü)

Otonom içerik makinesinin çalışması için 3 temel bileşene ihtiyaç vardır:
1. **Üretilecek Dosya/Prompt** (`train.py` mantığıyla çalışan içerik promptu)
2. **Optimizasyon Talimatları** (`program.md` - neyin optimize edileceği)
3. **Değerlendirme Kriteri (Eval)** (Gerçek izlenme verileri ve 10 soruluk test)

### Döngünün Adımları:
1. **Veri Çekme:** Meta Graph API (ücretsiz) aracılığıyla her sabah 08:00'de Instagram ve Facebook Reels izlenme verileri (views) Airtable'a çekilir.
2. **İçerik Üretimi (N8N + Airtable):** Sistem günde 5 video fikri oluşturur.
3. **Puanlama (Gemini / Claude):** Yayınlanan scriptler **vibes (hislere) göre değil**, kesin Evet/Hayır (Binary) kurallarına göre değerlendirilir (Bkz. Eval Kriterleri).
4. **Korelasyon:** Yüksek Eval + Yüksek İzlenme = Kazanan. Yüksek Eval + Düşük İzlenme = Yanlış Pozitif (Eval kuralları düzeltilmeli).
5. **Prompt Güncelleme (Claude Code):** Claude Code, dünkü sonuçları analiz eder ve `prompt.json` dosyasını (içerik üreten ana komutu) otomatik olarak yeniden yazar.

## ⚖️ Binary Eval (Değerlendirme) Kriterleri
Yapay zekaya "Bu video ilgi çekici mi?" diye SORAMAZSINIZ. Bu subjektiftir. Bunun yerine şu 10 kesin *Evet/Hayır* sorusunu sormalısınız:

1. Hook (Kanca) kısmı sadece bir özelliği mi anlatıyor, yoksa **bir sonucu/dönüşümü mü** vadediyor? (Evet/Hayır)
2. Hook kısmı bir şirketi değil, **bir kişiyi veya hikayeyi** mi merkezine alıyor? (Evet/Hayır)
3. İçerik "bunun ne olduğu" etrafında değil, "bununla ne yapabileceğin" etrafında mı şekilleniyor? (Evet/Hayır)
4. Script bir basın bülteni veya güncelleme notu gibi sıkıcı tınlamaktan kaçınıyor mu? (Evet/Hayır)
5. Bu videonun ilk karesi (frame) birinin kaydırmayı bırakmasını (stop scrolling) sağlar mı? (Evet/Hayır)

*Bu soruları bir LLM'e verin ve script üzerinden 10 üzerinden net bir skor alın.*

## 📈 Neden İşe Yarıyor?
Normalde insanlar "içgüdülerine" dayanarak prompt değiştirir. Bu sistemde ise her prompt değişikliği (Örn: "Daha fazla merak uyandır", "Olaylardan ziyade evrensel sırlara odaklan") doğrudan **gerçek izlenme verisi** tarafından tetiklenir. Ajan her gece uyurken deney yapar, işe yaramayan promptları çöpe atar ve ertesi gün daha keskin bir içerik makinesiyle uyanırsınız.
