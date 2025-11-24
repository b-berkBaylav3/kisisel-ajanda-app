# 📅 Kişisel Ajanda ve Program Takip Uygulaması

Flutter ile geliştirilmiş, modern, kullanıcı dostu ve offline-first (internetsiz çalışan) bir kişisel asistan uygulaması.

## 🚀 Özellikler

* **Offline-First:** Tüm veriler Hive veritabanı ile yerelde güvenle saklanır.
* **Akıllı Hatırlatıcılar:** Görev zamanı geldiğinde bildirim gönderir.
* **Modern Arayüz:** Material 3 tasarım dili, Riverpod ile reaktif UI.
* **Görev Yönetimi:**
    * Görev Ekleme/Silme/Düzenleme
    * Öncelik Seviyeleri (Düşük, Orta, Yüksek)
    * Tamamlandı/Tamamlanmadı işaretleme
* **Kolay Kullanım:** Sade ve anlaşılır kullanıcı deneyimi.

## 🛠 Kullanılan Teknolojiler

* **Frontend:** [Flutter](https://flutter.dev/) (Dart)
* **State Management:** [Riverpod](https://riverpod.dev/)
* **Yerel Veritabanı:** [Hive](https://docs.hivedb.dev/)
* **Navigasyon:** [GoRouter](https://pub.dev/packages/go_router)
* **Bildirimler:** [Flutter Local Notifications](https://pub.dev/packages/flutter_local_notifications)
* **Diğer:** Intl (Tarih formatlama), UUID (Benzersiz ID).

## 📸 Ekran Görüntüleri

| Giriş Ekranı | Ana Sayfa | Görev Ekleme |
|:---:|:---:|:---:|
| ![Splash](https://via.placeholder.com/150x300?text=Giris) | ![Home](https://via.placeholder.com/150x300?text=Ana+Sayfa) | ![Add Task](https://via.placeholder.com/150x300?text=Gorev+Ekle) |

*(Buraya kendi aldığın ekran görüntülerini ekleyebilirsin)*

## 📦 Kurulum ve Çalıştırma

Projenin bir kopyasını bilgisayarınıza indirin ve çalıştırın:

```bash
# 1. Repoyu klonlayın
git clone [https://github.com/KULLANICI_ADIN/kisisel-ajanda-app.git](https://github.com/KULLANICI_ADIN/kisisel-ajanda-app.git)

# 2. Proje dizinine girin
cd kisisel-ajanda-app

# 3. Paketleri yükleyin
flutter pub get

# 4. Modelleri üretin (Hive için gerekli)
dart run build_runner build

# 5. Uygulamayı çalıştırın
flutter run