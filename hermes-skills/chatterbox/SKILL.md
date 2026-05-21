---
name: chatterbox
description: ElevenLabs'a alternatif, tamamen ücretsiz ve lokal çalışan (resemble-ai/chatterbox) ses klonlama ajanı.
tags: [skill, tts, voice-cloning]
---
# Chatterbox Skill

## Mimarisi ve Çalışma Mantığı
Açık kaynaklı (MIT) bir ses motorudur. 10 saniyelik referans ses ile klonlama yapar. 23 dil (Türkçe dahil) destekler. Metne `[laugh]`, `[cough]` gibi doğal ses efektleri enjekte etme yeteneğine sahiptir. Video üretim (Seedance) ve Hermes agent'in sesli geri bildirim sistemlerinde kullanılır.

## Prompt ve RCI Döngüsü
<thinking>
1. Hedef: Verilen metni ve referans sesi kullanarak doğal bir TTS üretmek.
2. Plan: Chatterbox CLI/API'sine metni gönder, aralara doğal reaksiyon (gülme/nefes) tokenları ekle.
3. Uygulama: Sesi sentezle ve .wav olarak projeye kaydet.
</thinking>
