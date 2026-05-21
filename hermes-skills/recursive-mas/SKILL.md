---
name: recursive-mas
description: "Çoklu ajan sistemlerini latent-space recursion ile 2.4x hızlandıran ve token maliyetini %75 düşüren framework."
---

# Recursive Multi-Agent Systems (RecursiveMAS)

Bu skill, ajanların birbirleriyle metin yerine **latent-space (gizli vektör alanı)** üzerinden haberleşmesini sağlar. Geleneksel "decode -> text -> encode" döngüsünü kırarak performansı maksimize eder.

## 🚀 Temel Özellikler
- **2.4x Hızlanma:** Ajanlar arası metin üretimi ve okuması ortadan kalktığı için çok daha hızlı döner.
- **%75 Token Tasarrufu:** Sadece en son aşamada metin üretildiği için ara adımlarda token harcanmaz.
- **+8.3% Doğruluk:** Latent-space üzerinden daha zengin bir "düşünce aktarımı" (RecursiveLink) gerçekleşir.

## 🛠 Kullanım Senaryoları
1. **Zor Mantık Soruları:** Ajanların kendi aralarında "fısıldaşarak" (latent) çözüme gitmesi.
2. **Kod İnceleme & Refactor:** Birden fazla uzmanın metin kalabalığı yaratmadan kodu iyileştirmesi.
3. **Maliyet Odaklı İşler:** Yüzlerce ajan adımının tek bir token fiyatına yapılması.

## ⚙️ Kurulum ve Çalıştırma
Projeyi `/root/RecursiveMAS` dizininde kurduktan sonra:

```bash
cd /root/RecursiveMAS
# (Venv ve bağımlılık kurulumu gerekebilir)
python3 run.py --style sequential    # Sıralı iyileştirme
python3 run.py --style deliberation  # Derin tartışma
python3 run.py --style mixture       # Farklı model hibriti
```

## 🧠 Entegrasyon (Ruflo & Hermes)
Bu skill, bir "Processing Engine" (İşleme Motoru) olarak çalışır. Özellikle **Ruflo** ile birlikte çalışırken "Hibrit Swarm" mimarisi oluşturur:
- **Ruflo:** Ajanların kimliğini (Security, Dev vb.) ve hiyerarşiyi (mesh, ring) belirler.
- **RecursiveMAS:** Ruflo'nun seçtiği bu ajanları metinle konuşturmak yerine latent-space protokolüne (gizli alana) sokar.

Hermes veya Claude Code'a görev verirken şu kuralı tetikleyin:
> *"Ruflo ile bir swarm başlat ama ajanlar arası iletişimi RecursiveMAS latent-space protokolü üzerinden yap."*

**Not:** API tabanlı kapalı modellerde (GPT-4 vb.) latent erişimi kısıtlıdır. En iyi verim yerel (Llama 3, Mistral) veya HuggingFace üzerindeki modellerle alınır.
