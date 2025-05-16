📁 1️⃣ Ana Klasörler
auth/ → Kullanıcı kimlik doğrulama (giriş, kayıt, şifre sıfırlama vs.)

models/ → Veri modelleri (Örneğin user_model.dart kullanıcı bilgilerini saklar.)

screens/ → Sayfalar (profile_screen.dart, home_screen.dart vs.)

services/ → Firebase gibi servislerle etkileşime giren dosyalar (Örneğin user_service.dart)

styles/ → Renkler, yazı stilleri vs.

utils/ → Küçük yardımcı fonksiyonlar (Örneğin date_utils.dart → Yaş hesaplama gibi şeyler)

widgets/ → Tekrar kullanılabilir UI bileşenleri (butonlar, appbar, profile alanları)

📂 2️⃣ Hangi Değişiklik İçin Hangi Dosyaya Bakmalısın?
🔹 1. Giriş/Kayıt ile ilgili bir şey mi değiştireceksin?
📌 Şuraya bak:
➡ auth/ klasörü içindeki dosyalar

sign_in.dart → Giriş ekranı

sign_up_step1.dart, sign_up_step2.dart → Kayıt ekranları

reset_password.dart → Şifre sıfırlama

🔹 2. Firebase Kullanıcı Bilgileri ile ilgili bir şey mi değiştireceksin?
📌 Şuraya bak:
➡ services/user_service.dart

Kullanıcının Firestore'dan çekilmesi, çıkış yapması, yaşının hesaplanması burada yönetiliyor.

Örnek: Kullanıcı adını çekmek istiyorsan getUserData() fonksiyonunu buradan bulmalısın.

🔹 3. Profil Ekranında bir şey mi değiştireceksin?
📌 Şuraya bak:
➡ screens/profile_screen.dart → Profil sayfası
➡ widgets/profile_flexible_space.dart → Profil üst kısmı (Arkaplan, blur, foto, isim vs.)
➡ widgets/profile_details.dart → Kullanıcı detayları (isim, e-mail, profil fotoğrafı)
➡ widgets/edit_profile_button.dart → Profili düzenleme butonu

🔹 Örnek:

Profil ekranının arka plan fotoğrafını değiştirmek mi istiyorsun?
📌 widgets/profile_flexible_space.dart içinde Image.asset(...) olan yeri değiştir.

Profili düzenle butonuna basınca farklı bir sayfa mı açılacak?
📌 widgets/edit_profile_button.dart içindeki onPressed: kısmını değiştir.

🔹 4. Navigasyon (Alt Menü) ile ilgili bir şey mi değiştireceksin?
📌 Şuraya bak:
➡ widgets/bottom_nav.dart

🔹 Örnek:

Alt menüye yeni bir sekme eklemek mi istiyorsun?
📌 widgets/bottom_nav.dart içinde BottomNavigationBar kısmını düzenle.

🔹 5. Ana Sayfada (Home) bir şey mi değiştireceksin?
📌 Şuraya bak:
➡ screens/home_screen.dart → Ana sayfa
➡ screens/animated_home_screen.dart → Eğer animasyonlu bir açılış varsa
➡ widgets/home_content.dart → Ana sayfanın içeriği

🔹 Örnek:

Ana ekrana yeni bir widget eklemek mi istiyorsun?
📌 widgets/home_content.dart içinde düzenleme yap.

🔹 6. Uygulamanın Renklerini veya Yazı Stillerini Değiştirmek mi İstiyorsun?
📌 Şuraya bak:
➡ styles/app_colors.dart → Uygulamanın tüm renkleri burada
➡ styles/ içinde başka dosyalar varsa yazı stilleri de oradadır.

🔹 Örnek:

Tüm butonları kırmızı yapmak mı istiyorsun?
📌 styles/app_colors.dart içinde buton renklerini değiştir.

🔹 7. Profil Sekmelerini (Paylaşımlar, Bilgiler, Beğeniler) mi değiştireceksin?
📌 Şuraya bak:
➡ widgets/profile_tab_bar.dart → Üstteki sekmeler
➡ widgets/profile_tab_view.dart → Sekmelerin içeriği

🔹 Örnek:

Yeni bir sekme eklemek istiyorsan?
📌 widgets/profile_tab_bar.dart içine yeni bir Tab(...) ekle.

"Beğeniler" sekmesinin içeriğini değiştirmek istiyorsan?
📌 widgets/profile_tab_view.dart içinde ilgili TabBarView kısmını değiştir.

🔹 8. Tarot Kartları ile ilgili bir şey mi değiştireceksin?
📌 Şuraya bak:
➡ screens/tarot_detailScreen.dart

🔹 Örnek:

Kart detay sayfasının UI’ını değiştirmek istiyorsan?
📌 tarot_detailScreen.dart içinde Scaffold yapısını düzenle.

🚀 Özet:
Hangi Değişikliği Yapmak İstiyorsun? Hangi Dosyaya Bakmalısın?
Giriş/Kayıt işlemleri auth/ klasöründeki dosyalar
Firebase işlemleri (kullanıcı çekme, çıkış yapma) services/user_service.dart
Profil ekranı değişiklikleri screens/profile_screen.dart + widgets/profile_flexible_space.dart + widgets/profile_details.dart
Ana sayfa (Home) değişiklikleri screens/home_screen.dart + widgets/home_content.dart
Navigasyon (alt menü) değişiklikleri widgets/bottom_nav.dart
Renk veya yazı stilleri styles/app_colors.dart
Profil sekmeleri (Paylaşımlar, Beğeniler vs.) widgets/profile_tab_bar.dart + widgets/profile_tab_view.dart
Tarot Kartları ile ilgili değişiklik screens/tarot_detailScreen.dart
