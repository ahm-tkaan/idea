# idea

Bu Flutter uygulaması, öğrencilere ders içeriklerini öğrenme ve sınavlara hazırlanma sürecinde yardımcı olmayı amaçlamaktadır. Kullanıcılar, ders içeriklerine ulaşabilir, konu anlatımlarını inceleyebilir, üretilen soruları çözebilir ve doğru cevapları görüntüleyebilir.

## Özellikler

- **Konu Anlatımı**: Seçilen ders ve konu ile ilgili ayrıntılı açıklamalar sağlanır.
- **Soru Üretme**: Konuya özgü 5 seçenekli sorular otomatik olarak üretilir.
- **Doğru Cevap Gösterimi**: Üretilen soruların cevapları detaylı bir açıklama ile gösterilir.
- **Kullanıcı Dostu Arayüz**: Uygulama, kullanıcı deneyimini geliştiren şık ve sade bir arayüze sahiptir.


## Gereksinimler

- Flutter SDK
- Google Generative AI API anahtarı (API entegrasyonu için gereklidir)

## Kurulum

1. Bu projeyi klonlayın:

    ```bash
    git clone https://github.com/ahm-tkaan/egitim-uygulamasi.git
    cd egitim-uygulamasi
    ```

2. Gerekli bağımlılıkları yükleyin:

    ```bash
    flutter pub get
    ```

3. `google_generative_ai` paketine Google Generative AI API anahtarınızı ekleyin:

    `DersIcerikSayfasi` widget'ındaki `apiKey` alanını kendi anahtarınızla güncelleyin.

4. Uygulamayı çalıştırın:

    ```bash
    flutter run
    ```

## Kullanılan Paketler

- `flutter/material.dart`: Flutter'ın temel UI bileşenlerini sağlar.
- `google_generative_ai`: Google Generative AI API ile metin ve soru üretimini destekler.

## Kullanım

1. Uygulamayı açın ve sınıf, ders ve ünite seçimini yaparak konuya göre içeriği görüntüleyin.
2. **Konu Anlatımı** butonuna tıklayarak seçilen konunun açıklamasını görün.
3. **Bu Konu Hakkında Soru Üret** butonu ile konuya dair sorular oluşturun.
4. **Cevabı Göster** butonuna tıklayarak üretilen soruların doğru cevabını öğrenin.

## Katkıda Bulunma

Bu projeye katkıda bulunmak isterseniz, lütfen [Pull Request](https://github.com/ahm-tkaan/idea/pulls) gönderin veya bir konu açın.

