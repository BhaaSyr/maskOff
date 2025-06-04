// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class STr extends S {
  STr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Mask Off';

  @override
  String get welcome => 'Hoş Geldiniz';

  @override
  String get login => 'Giriş Yap';

  @override
  String get signup => 'Kayıt Ol';

  @override
  String get settings => 'Ayarlar';

  @override
  String get darkMode => 'Karanlık Mod';

  @override
  String get language => 'Dil';

  @override
  String get detectDeepfake =>
      'Gelişmiş yapay zeka teknolojisiyle deepfake videolarını tespit edin';

  @override
  String get uploadVideo => 'Video Yükle';

  @override
  String get analyze => 'Analiz Et';

  @override
  String get uploadRequired => 'Video Gerekli';

  @override
  String get pleaseUploadFirst => 'Lütfen önce bir video yükleyin';

  @override
  String get yourVideo => 'Videonuz';

  @override
  String get uploadToBegin => 'Başlamak için bir video yükleyin';

  @override
  String get tapUploadButton =>
      'Video seçmek için aşağıdaki Yükle butonuna dokunun';

  @override
  String get analysisResults => 'Analiz Sonuçları';

  @override
  String get backToHomepage => 'Ana Sayfaya Dön';

  @override
  String get logout => 'Çıkış Yap';

  @override
  String get logoutConfirmation => 'Çıkış yapmak istediğinizden emin misiniz?';

  @override
  String get cancel => 'İptal';

  @override
  String get email => 'E-posta';

  @override
  String get emailHint => 'E-posta adresinizi girin';

  @override
  String get password => 'Şifre';

  @override
  String get passwordHint => 'Şifrenizi girin';

  @override
  String get forgotPassword => 'Şifremi Unuttum';

  @override
  String get or => 'VEYA';

  @override
  String get loginWithGoogle => 'Google ile Giriş Yap';

  @override
  String get noAccount => 'Hesabınız yok mu?';

  @override
  String get passwordReset => 'Şifre Sıfırlama';

  @override
  String get passwordResetInfo =>
      'Şifre sıfırlama bağlantısı için e-posta adresinizi girin';

  @override
  String get send => 'Gönder';

  @override
  String get register => 'Kayıt Ol';

  @override
  String get createAccount => 'Hesap Oluştur';

  @override
  String get enterInfo => 'Lütfen bilgilerinizi girin';

  @override
  String get fullName => 'Adınız Soyadınız';

  @override
  String get fullNameHint => 'Adınızı ve soyadınızı girin';

  @override
  String get passwordHintRegister => 'Şifrenizi girin (en az 6 karakter)';

  @override
  String get confirmPassword => 'Şifre Tekrar';

  @override
  String get confirmPasswordHint => 'Şifrenizi tekrar girin';

  @override
  String get haveAccount => 'Zaten bir hesabınız var mı?';

  @override
  String deepfakeResult(String score) {
    return 'Bu video %$score olasılıkla deepfake içeriyor.';
  }

  @override
  String realVideoResult(String score) {
    return 'Bu video %$score olasılıkla gerçek görünüyor.';
  }

  @override
  String get deepfakeDetected => 'Deepfake Tespit Edildi';

  @override
  String get deepfakeVideo => 'Deepfake Video';

  @override
  String get authenticVideo => 'Gerçek Video';

  @override
  String get confidenceScore => 'Güven Puanı';

  @override
  String get about => 'Hakkında';

  @override
  String get appearance => 'Görünüm';

  @override
  String get privacyPolicy => 'Gizlilik Politikası';

  @override
  String get termsOfService => 'Kullanım Koşulları';

  @override
  String get version => 'Sürüm';

  @override
  String get emailVerificationRequired => 'E-posta Doğrulaması Gerekli';

  @override
  String get pleaseVerifyEmail =>
      'Hesabınıza erişmek için lütfen e-postanızı doğrulayın';

  @override
  String get resendVerificationEmail => 'Doğrulama E-postasını Tekrar Gönder';

  @override
  String get verificationEmailSent => 'Doğrulama E-postası Gönderildi';

  @override
  String get verificationEmailSentMessage =>
      'E-posta adresinize doğrulama bağlantısı gönderdik. Lütfen gelen kutunuzu kontrol edin.';

  @override
  String get emailFieldEmpty => 'E-posta alanı boş bırakılamaz';

  @override
  String get invalidEmail => 'Geçerli bir e-posta adresi girin';

  @override
  String get passwordFieldEmpty => 'Şifre alanı boş bırakılamaz';

  @override
  String get passwordMinLength => 'Şifre en az 6 karakter olmalıdır';

  @override
  String get nameFieldEmpty => 'Ad Soyad alanı boş bırakılamaz';

  @override
  String get confirmPasswordEmpty => 'Şifre tekrar alanı boş bırakılamaz';

  @override
  String get passwordsDoNotMatch => 'Şifreler eşleşmiyor';

  @override
  String get success => 'Başarılı';

  @override
  String get error => 'Hata';

  @override
  String get loginSuccessful => 'Giriş başarıyla gerçekleştirildi';

  @override
  String get registrationError => 'Kayıt olurken bir hata oluştu';

  @override
  String get loginError => 'Giriş yapılırken bir hata oluştu';

  @override
  String get emailAlreadyInUse => 'Bu e-posta adresi zaten kullanımda';

  @override
  String get weakPassword => 'Şifre çok zayıf';

  @override
  String get operationNotAllowed =>
      'E-posta/şifre ile kayıt etkinleştirilmemiş';

  @override
  String get userNotFound => 'Bu e-posta ile kayıtlı kullanıcı bulunamadı';

  @override
  String get wrongPassword => 'Hatalı şifre';

  @override
  String get userDisabled => 'Bu kullanıcı devre dışı bırakılmış';

  @override
  String get passwordResetEmailSent => 'Şifre Sıfırlama E-postası Gönderildi';

  @override
  String passwordResetEmailSentMessage(String email) {
    return 'Şifre sıfırlama bağlantısı $email adresine gönderildi.\n\nLütfen e-posta kutunuzu kontrol edin ve bağlantıya tıklayarak şifrenizi sıfırlayın.';
  }

  @override
  String get ok => 'Tamam';

  @override
  String get passwordResetError =>
      'Şifre sıfırlama işlemi sırasında bir hata oluştu';

  @override
  String get tooManyRequests =>
      'Çok fazla istek yapıldı. Lütfen daha sonra tekrar deneyin';

  @override
  String get googleLoginSuccess => 'Google hesabınız ile giriş yapıldı';

  @override
  String get googleLoginError => 'Google ile giriş yapılırken bir hata oluştu';

  @override
  String get logoutError => 'Çıkış yapılırken bir hata oluştu';

  @override
  String get profile => 'Profil';

  @override
  String get firstName => 'Ad';

  @override
  String get lastName => 'Soyad';

  @override
  String get age => 'Yaş';

  @override
  String get save => 'Kaydet';

  @override
  String get firstNameRequired => 'Ad alanı zorunludur';

  @override
  String get lastNameRequired => 'Soyad alanı zorunludur';

  @override
  String get invalidAge => 'Geçerli bir yaş girin (1-150)';

  @override
  String get profileUpdateSuccess => 'Profil başarıyla güncellendi';

  @override
  String welcomeBack(String name) {
    return 'Tekrar hoş geldiniz, $name!';
  }

  @override
  String get personalInformation => 'Kişisel Bilgiler';

  @override
  String get firstNameHint => 'Adınızı girin';

  @override
  String get lastNameHint => 'Soyadınızı girin';

  @override
  String get ageHint => 'Yaşınızı girin (isteğe bağlı)';

  @override
  String get analysisHistory => 'Analiz Geçmişi';

  @override
  String get loadingHistory => 'Geçmiş yükleniyor...';

  @override
  String get noAnalysisHistoryYet => 'Henüz analiz geçmişi yok';

  @override
  String get analyzeVideoToSeeResults =>
      'Sonuçlarınızı görmek için bir video analiz edin';

  @override
  String get deleteRecord => 'Kaydı Sil';

  @override
  String deleteRecordConfirmation(String title) {
    return '\"$title\" kaydını silmek istediğinizden emin misiniz? Bu işlem geri alınamaz.';
  }

  @override
  String get delete => 'Sil';

  @override
  String get recordDeletedSuccessfully => 'Kayıt başarıyla silindi';

  @override
  String failedToDeleteRecord(String error) {
    return 'Kayıt silinemedi: $error';
  }

  @override
  String videoAnalysis(String filename) {
    return 'Video Analizi - $filename';
  }

  @override
  String get deepfakeDetectionCompleted => 'Deepfake tespit analizi tamamlandı';

  @override
  String get authenticVideoVerificationCompleted =>
      'Gerçek video doğrulaması tamamlandı';

  @override
  String get realVideo => 'Gerçek Video';

  @override
  String get viewFullHistory => 'Tüm Analiz Geçmişini Görüntüle';

  @override
  String get analyzingVideo => 'Video Analiz Ediliyor';

  @override
  String get pleaseWait => 'Lütfen videonuz analiz edilirken bekleyin...';

  @override
  String get userNotAuthenticated => 'Kullanıcı girişi yapılmamış';

  @override
  String failedToLoadProfile(Object error) {
    return 'Profil yüklenirken hata oluştu: $error';
  }

  @override
  String failedToCreateProfile(Object error) {
    return 'Kullanıcı profili oluşturulurken hata oluştu: $error';
  }

  @override
  String failedToSaveProfile(Object error) {
    return 'Profil kaydedilirken hata oluştu: $error';
  }

  @override
  String failedToLoadHistory(Object error) {
    return 'Geçmiş yüklenirken hata oluştu: $error';
  }

  @override
  String failedToAddRecord(Object error) {
    return 'Kayıt eklenirken hata oluştu: $error';
  }

  @override
  String failedToUpdateRecord(Object error) {
    return 'Kayıt güncellenirken hata oluştu: $error';
  }

  @override
  String get invalidCredential =>
      'Geçersiz giriş bilgileri. Lütfen e-posta ve şifrenizi kontrol edip tekrar deneyin.';

  @override
  String get editVideo => 'Video Düzenle';

  @override
  String get play => 'Oynat';

  @override
  String get pause => 'Duraklat';

  @override
  String get saving => 'Kaydediliyor...';

  @override
  String get videoTrimming => 'Video Kesme';

  @override
  String get processingVideo => 'Video işleniyor, lütfen bekleyin...';
}
