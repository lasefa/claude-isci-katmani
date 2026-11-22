# claude-isci-katmani

Claude Code için, hamallık işini **ucuz ya da ücretsiz bir isçi modele** devreden küçük bir beceri (skill). Claude yönetici kalır: işi tarif eder, sonucu kontrol eder. Okuma, envanter, toplu düzenleme, tekrarlı kod, test iskeleti, uzun özet gibi işleri ücretsiz OpenCode modeline verir. Böylece Claude'un kendi kullanım kotası daha az harcanır.

Şu an yalnızca **Windows** (PowerShell 5.1+) için yazılmıştır.

## Önemli uyarı
Ücretsiz modeller işinizi dış sunuculara gönderir. Bu yüzden:
- Müşteri bilgisi, fiyat listesi, sözleşme, kişisel veri ve gizli kaynak dosyaları **hiçbir zaman** bu modellere verilmemelidir.
- Ücretsiz modellerin veri kullanım koşullarını sağlayıcının sitesinden kendiniz kontrol edin.
- Çıktılar kontrol edilmeden kullanılmamalıdır. Sayısal işler hesapla doğrulanmalıdır.

## Gereksinimler
- Claude Code
- Node.js ve npm
- OpenCode: `npm.cmd install -g opencode-ai`

## Kurulum

Claude Code içinde:

```
/plugin marketplace add <github-kullanici>/claude-isci-katmani
/plugin install claude-isci-katmani@claude-isci-katmani
```

Ardından kurulumu kontrol edin:

```
powershell -ExecutionPolicy Bypass -File scripts\kontrol.ps1
```

## Kullanım

Claude'a "bunu işçiye ver" ya da "ucuz modele yaptırt" demeniz yeterlidir. Claude, becerinin kurallarına göre:

1. Görevi proje klasöründe `.yazisma\gorev.md` dosyasına yazar.
2. `scripts\isci-cagir.ps1 -Not gorev.md -Etiket kisa-ad` komutunu çalıştırır.
3. Cevabı `.yazisma\isci-kisa-ad-cevap.md` dosyasından okuyup doğrular.

Varsayılan model `opencode/deepseek-v4.1-flash-free`'dir. Yedek modeller `mimo-v2.6-flash-free` ve `big-pickle`'dır. Model listesi için `opencode models` komutunu kullanın; ücretsiz modeller zamanla değişebilir.

Dosya yazma izni verilecekse `-Yazabilir` parametresini ekleyin. Varsayılan olarak model salt okunur çalışır.

## Dosya yapısı
```
.claude-plugin/                 eklenti ve pazar yeri tanımı
skills/isci-katmani/SKILL.md    Claude'un ne zaman ve nasıl kullanacağı
scripts/isci-cagir.ps1          işçi modeli çağıran betik
scripts/kontrol.ps1             kurulum kontrolü
```

## Lisans
MIT. Bkz. [LICENSE](LICENSE).

---

# claude-isci-katmani (English)

A small Claude Code skill that hands routine "grunt work" (inventory, bulk renaming, repetitive code, test scaffolds, long summaries) to a cheap or free OpenCode model, so Claude keeps its own usage for the hard parts. Windows only (PowerShell 5.1+) for now.

**Warning:** free models send your files to external servers. Never give them customer data, price lists, contracts, personal data or confidential sources. Always review their output before use.

Install in Claude Code:

```
/plugin marketplace add <github-user>/claude-isci-katmani
/plugin install claude-isci-katmani@claude-isci-katmani
```

Requires OpenCode (`npm.cmd install -g opencode-ai`). Run `scripts\kontrol.ps1` to verify. MIT licensed.

## Sorun giderme

- **`/plugin` komutları çalışmazsa**, terminalden aynı işi yapın:
  ```
  claude plugin marketplace add lasefa/claude-isci-katmani
  claude plugin install claude-isci-katmani@claude-isci-katmani
  ```
- **Betik çalışmıyor / "çalıştırma politikası" hatası:** Betikler `-ExecutionPolicy Bypass` ile çağrılır, bu yüzden normalde ayar gerekmez. Yine de engellenirse PowerShell'de bir kez `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned` çalıştırın.
- **Cevap boş geliyor:** `.yazisma\isci-<etiket>-log.txt` dosyasına bakın. Ücretsiz modeller zaman zaman yanıt vermez; betik yedek modellere otomatik geçer.
- **İşçi çıktısını her zaman kontrol edin.** Ücretsiz modeller küçük hatalar yapabilir (ör. bir dosyanın boyutunu yanlış yazmak). Sayısal sonuçları ayrıca hesaplayıp karşılaştırın.
