# 2026 LLM Benchmark Siteleri — Tam Kaynak Rehberi

Bu dosya, model seçimi için başvurulacak tüm benchmark sitelerini içerir. Mayıs 2026 itibarıyla aktiftir.

## 1. Genel

| # | Site | URL | Odak |
|---|------|-----|------|
| 1 | LMArena | https://lmarena.ai | İnsan tercihi (Elo) — altın standart. 350+ model. |
| 2 | Artificial Analysis | https://artificialanalysis.ai | Intelligence Index v4.0. Günlük 8 ölçüm. |
| 3 | LiveBench | https://livebench.ai | contamination-limited akademik. |
| 4 | Vellum | https://www.vellum.ai/llm-leaderboard | Frontier tek-sayfa. |
| 5 | LLM-Stats | https://llm-stats.com | 298+ model bileşik skor. |
| 6 | BenchLM | https://benchlm.ai | 230+ model × 190+ benchmark. |
| 7 | Onyx Tier | https://onyx.app/llm-leaderboard | S/A/B/C/D tier. |

## 2. Kodlama

| # | Site | URL | Odak |
|---|------|-----|------|
| 8 | SWE-bench | https://www.swebench.com | GitHub issue çözme. Verified/Pro/Live. |
| 9 | Scale SEAL Pro | https://labs.scale.com/leaderboard | Kontaminasyon-dirençli, 4 dilli. |
| 10 | LiveCodeBench | https://livecodebench.github.io | contamination-free kod. |
| 11 | Aider Polyglot | https://aider.chat/docs/leaderboards | 6 dilde kod düzenleme. |
| 12 | Terminal-Bench | https://www.tbench.ai | CLI/terminal agent. |
| 13 | CodeSOTA | https://www.codesota.com/code-generation | Kod SOTA derleyici. |

## 3. Reasoning & Matematik

| # | Site | URL | Odak |
|---|------|-----|------|
| 14 | GPQA Diamond | https://github.com/idavidrein/gpqa | Lisansüstü Google-dayanıklı QA. |
| 15 | HLE | https://lastexam.ai | Son akademik sınav. |
| 16 | FrontierMath | https://epoch.ai/frontiermath | Araştırma seviyesi matematik. |
| 17 | AIME 2026 | https://artificialanalysis.ai/evaluations/aime | Olimpiyat matematiği. |
| 18 | ARC-AGI-2/3 | https://arcprize.org | Akıcı zekâ. |

## 4. Multimodal

| # | Site | URL | Odak |
|---|------|-----|------|
| 19 | MMMU-Pro | https://mmmu-benchmark.github.io | Görsel QA. |
| 20 | OpenVLM Leaderboard | https://huggingface.co/spaces/opencompass/open_vlm_leaderboard | 100+ VLM. |
| 21 | AA Image Arena | https://artificialanalysis.ai/image | Görsel üretim. |
| 22 | AA Video Arena | https://artificialanalysis.ai/video/leaderboard | Video üretim. |
| 23 | MMAU-Pro | https://sakshi113.github.io/mmau_homepage | Ses akıl yürütme. |
| 24 | HF Open ASR | https://huggingface.co/spaces/hf-audio/open_asr_leaderboard | Konuşma tanıma. |
| 25 | TTS Arena | https://huggingface.co/spaces/TTS-AGI/TTS-Arena-V2 | Metinden-konuşmaya. |

## 5. Agent / Tool-Use

| # | Site | URL | Odak |
|---|------|-----|------|
| 26 | GAIA | https://huggingface.co/spaces/gaia-benchmark/leaderboard | Çok-adımlı araç-kullanan görev. |
| 27 | WebArena | https://webarena.dev | Web sandbox agent. |
| 28 | OSWorld | https://os-world.github.io | Masaüstü computer use. |
| 29 | τ²-bench | https://github.com/sierra-research/tau-bench | Tool + policy + sim user. |
| 30 | BFCL | https://gorilla.cs.berkeley.edu/leaderboard.html | Function calling. |
| 31 | HAL | https://hal.cs.princeton.edu | Holistic agent + maliyet. |
| 32 | MLE-bench | https://github.com/openai/mle-bench | Veri-bilimi agent. |

## 6. Hız / Maliyet

| # | Site | URL | Odak |
|---|------|-----|------|
| 33 | AA Speed | https://artificialanalysis.ai | TPS, TTFT, fiyat. |
| 34 | PricePerToken | https://pricepertoken.com | Anlık fiyat. |
| 35 | OpenRouter Rankings | https://openrouter.ai/rankings | Gerçek popülarite. |

## 7. Güvenlik

| # | Site | URL | Odak |
|---|------|-----|------|
| 36 | AILuminate | https://mlcommons.org/benchmarks/ailuminate | 12 tehlike kategorisi. |
| 37 | HELM Safety | https://crfm.stanford.edu/helm/safety | 6 boyut güvenilirlik. |
| 38 | TrustLLM | https://trustllmbenchmark.github.io | 30+ model, 6 boyut. |
| 39 | HarmBench | https://www.harmbench.org | Jailbreak dayanıklılığı. |
| 40 | WMDP | https://www.wmdp.ai | Biyo/kimya/siber tehlike. |

---

## ⚠️ Uyarılar

- **Saturasyon:** MMLU, HumanEval, MBPP → ayırt edici değil. Yerine: GPQA Diamond, HLE, SWE-bench Pro, LiveCodeBench.
- **Kontaminasyon:** LiveBench, LiveCodeBench, SWE-bench Live daha güvenilir.
- **Scaffold:** Agent benchmarklarında 5-10 puan fark olabilir.
- **Reward hacking:** 8 agent benchmark'ı manipüle edilebilir. Tek benchmark'a güvenme.
- **HF Open LLM:** Haziran 2025'te emekli. Muadilleri: LLM-Stats, BenchLM.

*Derlenmiştir: Birkan'ın 2026 benchmark rehberi. Mayıs 2026.*