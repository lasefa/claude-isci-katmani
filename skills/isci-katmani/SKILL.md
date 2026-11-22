---
name: isci-katmani
description: Hamallik isini (envanter, toplu duzenleme, tekrarli kod, test iskeleti, uzun ozet, ilk taslak) ucretsiz OpenCode isci modeline devreder. Kullanici "bunu isciye ver", "ucuz modele yaptir" veya benzeri bir sey dediginde ya da bu tur bir is gorundugunde kullan. Gercek is verisi (musteri, fiyat, sozlesme, kisisel veri) disariya gonderilmez.
---

# Isci katmani (ucretsiz OpenCode modeli)

Bu beceri, hamallik isini ucuz ya da ucretsiz bir modele vermek icindir. Claude bu isi yonetir: isi tarif eder, sonucu kontrol eder, birlestirir.

## Ne zaman kullanilir
- Kullanici acikca "isciye ver", "ucuz modele yaptir", "tokenleri harcama" derse.
- Is hamallik sinifindaysa ve kullanici engel koymadiysa: envanter cikarma, dosya ve yol kontrolu, toplu isim/bicim duzenleme, tekrarli kod, test iskeleti, uzun metni ozetleme, ilk taslak.

## Ne zaman kullanilmaz
- Gercek is verisi: musteri bilgisi, fiyat listesi, sozlesme, kisisel veri, kaynak dosyalar. Bu veri hicbir dis modele gitmez.
- Para, risk, stok, maliyet gibi karar gerektiren kodlar: Claude ya da kullanicinin onayi gerekir.
- Kisa, tek satirlik sorular: dogrudan yanitla.

## Nasil calisir
1. Isi bir not dosyasina yaz: proje klasorunde `.yazisma\gorev.md`. Notta ne yapilacagi, hangi dosyalara bakilacagi, cevabin bicimi yazilir. Gerekiyorsa tek bir dosya ya da klasor adi ver.
2. Betigi cagir. Betik, calistirildigi klasoru proje sayar:
   ```
   powershell -ExecutionPolicy Bypass -File <kurulum-yolu>\scripts\isci-cagir.ps1 -Not gorev.md -Etiket kisa-ad
   ```
   Yazma izni gerekiyorsa `-Yazabilir` ekle; varsayilan salt okunurdur.
3. Cevap `.yazisma\isci-kisa-ad-cevap.md` dosyasina duser. Claude bunu oku, dogrula, gerekiyorsa duzelt.
4. Sayisal isleri cevaptan once hesapla ve karsilastir. Isci modeli hata yapabilir.

## Kurallar
- Notta yalnizca gerekli bilgi olsun. Gizli veri koyma.
- Betik bos cevap verirse `.yazisma\isci-kisa-ad-log.txt` dosyasina bak.
- Once `scripts\kontrol.ps1` ile kurulumu dogrula.
- Ucretsiz modellerin kullanim kosullari saglayici tarafindan degisebilir; model listesi icin `opencode models`.
