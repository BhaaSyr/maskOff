// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a tr locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'tr';

  static String m0(score) => "Bu video %${score} olasılıkla deepfake içeriyor.";

  static String m1(title) =>
      "\"${title}\" kaydını silmek istediğinizden emin misiniz? Bu işlem geri alınamaz.";

  static String m2(error) => "Kayıt eklenirken hata oluştu: ${error}";

  static String m3(error) =>
      "Kullanıcı profili oluşturulurken hata oluştu: ${error}";

  static String m4(error) => "Kayıt silinemedi: ${error}";

  static String m5(error) => "Geçmiş yüklenirken hata oluştu: ${error}";

  static String m6(error) => "Profil yüklenirken hata oluştu: ${error}";

  static String m7(error) => "Profil kaydedilirken hata oluştu: ${error}";

  static String m8(error) => "Kayıt güncellenirken hata oluştu: ${error}";

  static String m9(email) =>
      "Şifre sıfırlama bağlantısı ${email} adresine gönderildi.\n\nLütfen e-posta kutunuzu kontrol edin ve bağlantıya tıklayarak şifrenizi sıfırlayın.";

  static String m10(score) => "Bu video %${score} olasılıkla gerçek görünüyor.";

  static String m11(filename) => "Video Analizi - ${filename}";

  static String m12(name) => "Tekrar hoş geldiniz, ${name}!";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("Hakkında"),
        "age": MessageLookupByLibrary.simpleMessage("Yaş"),
        "ageHint": MessageLookupByLibrary.simpleMessage(
            "Yaşınızı girin (isteğe bağlı)"),
        "analysisHistory":
            MessageLookupByLibrary.simpleMessage("Analiz Geçmişi"),
        "analysisResults":
            MessageLookupByLibrary.simpleMessage("Analiz Sonuçları"),
        "analyze": MessageLookupByLibrary.simpleMessage("Analiz Et"),
        "analyzeVideoToSeeResults": MessageLookupByLibrary.simpleMessage(
            "Sonuçlarınızı görmek için bir video analiz edin"),
        "analyzingVideo":
            MessageLookupByLibrary.simpleMessage("Video Analiz Ediliyor"),
        "appTitle": MessageLookupByLibrary.simpleMessage("Mask Off"),
        "appearance": MessageLookupByLibrary.simpleMessage("Görünüm"),
        "authenticVideo": MessageLookupByLibrary.simpleMessage("Gerçek Video"),
        "authenticVideoVerificationCompleted":
            MessageLookupByLibrary.simpleMessage(
                "Gerçek video doğrulaması tamamlandı"),
        "backToHomepage":
            MessageLookupByLibrary.simpleMessage("Ana Sayfaya Dön"),
        "cancel": MessageLookupByLibrary.simpleMessage("İptal"),
        "confidenceScore": MessageLookupByLibrary.simpleMessage("Güven Puanı"),
        "confirmPassword": MessageLookupByLibrary.simpleMessage("Şifre Tekrar"),
        "confirmPasswordEmpty": MessageLookupByLibrary.simpleMessage(
            "Şifre tekrar alanı boş bırakılamaz"),
        "confirmPasswordHint":
            MessageLookupByLibrary.simpleMessage("Şifrenizi tekrar girin"),
        "createAccount": MessageLookupByLibrary.simpleMessage("Hesap Oluştur"),
        "darkMode": MessageLookupByLibrary.simpleMessage("Karanlık Mod"),
        "deepfakeDetected":
            MessageLookupByLibrary.simpleMessage("Deepfake Tespit Edildi"),
        "deepfakeDetectionCompleted": MessageLookupByLibrary.simpleMessage(
            "Deepfake tespit analizi tamamlandı"),
        "deepfakeResult": m0,
        "delete": MessageLookupByLibrary.simpleMessage("Sil"),
        "deleteRecord": MessageLookupByLibrary.simpleMessage("Kaydı Sil"),
        "deleteRecordConfirmation": m1,
        "detectDeepfake": MessageLookupByLibrary.simpleMessage(
            "Gelişmiş yapay zeka teknolojisiyle deepfake videolarını tespit edin"),
        "email": MessageLookupByLibrary.simpleMessage("E-posta"),
        "emailAlreadyInUse": MessageLookupByLibrary.simpleMessage(
            "Bu e-posta adresi zaten kullanımda"),
        "emailFieldEmpty": MessageLookupByLibrary.simpleMessage(
            "E-posta alanı boş bırakılamaz"),
        "emailHint":
            MessageLookupByLibrary.simpleMessage("E-posta adresinizi girin"),
        "emailVerificationRequired":
            MessageLookupByLibrary.simpleMessage("E-posta Doğrulaması Gerekli"),
        "enterInfo":
            MessageLookupByLibrary.simpleMessage("Lütfen bilgilerinizi girin"),
        "error": MessageLookupByLibrary.simpleMessage("Hata"),
        "failedToAddRecord": m2,
        "failedToCreateProfile": m3,
        "failedToDeleteRecord": m4,
        "failedToLoadHistory": m5,
        "failedToLoadProfile": m6,
        "failedToSaveProfile": m7,
        "failedToUpdateRecord": m8,
        "firstName": MessageLookupByLibrary.simpleMessage("Ad"),
        "firstNameHint": MessageLookupByLibrary.simpleMessage("Adınızı girin"),
        "firstNameRequired":
            MessageLookupByLibrary.simpleMessage("Ad alanı zorunludur"),
        "forgotPassword":
            MessageLookupByLibrary.simpleMessage("Şifremi Unuttum"),
        "fullName": MessageLookupByLibrary.simpleMessage("Adınız Soyadınız"),
        "fullNameHint":
            MessageLookupByLibrary.simpleMessage("Adınızı ve soyadınızı girin"),
        "googleLoginError": MessageLookupByLibrary.simpleMessage(
            "Google ile giriş yapılırken bir hata oluştu"),
        "googleLoginSuccess": MessageLookupByLibrary.simpleMessage(
            "Google hesabınız ile giriş yapıldı"),
        "haveAccount":
            MessageLookupByLibrary.simpleMessage("Zaten bir hesabınız var mı?"),
        "invalidAge": MessageLookupByLibrary.simpleMessage(
            "Geçerli bir yaş girin (1-150)"),
        "invalidEmail": MessageLookupByLibrary.simpleMessage(
            "Geçerli bir e-posta adresi girin"),
        "language": MessageLookupByLibrary.simpleMessage("Dil"),
        "lastName": MessageLookupByLibrary.simpleMessage("Soyad"),
        "lastNameHint":
            MessageLookupByLibrary.simpleMessage("Soyadınızı girin"),
        "lastNameRequired":
            MessageLookupByLibrary.simpleMessage("Soyad alanı zorunludur"),
        "loadingHistory":
            MessageLookupByLibrary.simpleMessage("Geçmiş yükleniyor..."),
        "login": MessageLookupByLibrary.simpleMessage("Giriş Yap"),
        "loginError": MessageLookupByLibrary.simpleMessage(
            "Giriş yapılırken bir hata oluştu"),
        "loginSuccessful": MessageLookupByLibrary.simpleMessage(
            "Giriş başarıyla gerçekleştirildi"),
        "loginWithGoogle":
            MessageLookupByLibrary.simpleMessage("Google ile Giriş Yap"),
        "logout": MessageLookupByLibrary.simpleMessage("Çıkış Yap"),
        "logoutConfirmation": MessageLookupByLibrary.simpleMessage(
            "Çıkış yapmak istediğinizden emin misiniz?"),
        "logoutError": MessageLookupByLibrary.simpleMessage(
            "Çıkış yapılırken bir hata oluştu"),
        "nameFieldEmpty": MessageLookupByLibrary.simpleMessage(
            "Ad Soyad alanı boş bırakılamaz"),
        "noAccount": MessageLookupByLibrary.simpleMessage("Hesabınız yok mu?"),
        "noAnalysisHistoryYet":
            MessageLookupByLibrary.simpleMessage("Henüz analiz geçmişi yok"),
        "ok": MessageLookupByLibrary.simpleMessage("Tamam"),
        "operationNotAllowed": MessageLookupByLibrary.simpleMessage(
            "E-posta/şifre ile kayıt etkinleştirilmemiş"),
        "or": MessageLookupByLibrary.simpleMessage("VEYA"),
        "password": MessageLookupByLibrary.simpleMessage("Şifre"),
        "passwordFieldEmpty":
            MessageLookupByLibrary.simpleMessage("Şifre alanı boş bırakılamaz"),
        "passwordHint": MessageLookupByLibrary.simpleMessage("Şifrenizi girin"),
        "passwordHintRegister": MessageLookupByLibrary.simpleMessage(
            "Şifrenizi girin (en az 6 karakter)"),
        "passwordMinLength": MessageLookupByLibrary.simpleMessage(
            "Şifre en az 6 karakter olmalıdır"),
        "passwordReset":
            MessageLookupByLibrary.simpleMessage("Şifre Sıfırlama"),
        "passwordResetEmailSent": MessageLookupByLibrary.simpleMessage(
            "Şifre Sıfırlama E-postası Gönderildi"),
        "passwordResetEmailSentMessage": m9,
        "passwordResetError": MessageLookupByLibrary.simpleMessage(
            "Şifre sıfırlama işlemi sırasında bir hata oluştu"),
        "passwordResetInfo": MessageLookupByLibrary.simpleMessage(
            "Şifre sıfırlama bağlantısı için e-posta adresinizi girin"),
        "passwordsDoNotMatch":
            MessageLookupByLibrary.simpleMessage("Şifreler eşleşmiyor"),
        "personalInformation":
            MessageLookupByLibrary.simpleMessage("Kişisel Bilgiler"),
        "pleaseUploadFirst": MessageLookupByLibrary.simpleMessage(
            "Lütfen önce bir video yükleyin"),
        "pleaseVerifyEmail": MessageLookupByLibrary.simpleMessage(
            "Hesabınıza erişmek için lütfen e-postanızı doğrulayın"),
        "pleaseWait": MessageLookupByLibrary.simpleMessage(
            "Lütfen videonuz analiz edilirken bekleyin..."),
        "privacyPolicy":
            MessageLookupByLibrary.simpleMessage("Gizlilik Politikası"),
        "profile": MessageLookupByLibrary.simpleMessage("Profil"),
        "profileUpdateSuccess": MessageLookupByLibrary.simpleMessage(
            "Profil başarıyla güncellendi"),
        "realVideo": MessageLookupByLibrary.simpleMessage("Gerçek Video"),
        "realVideoResult": m10,
        "recordDeletedSuccessfully":
            MessageLookupByLibrary.simpleMessage("Kayıt başarıyla silindi"),
        "register": MessageLookupByLibrary.simpleMessage("Kayıt Ol"),
        "registrationError": MessageLookupByLibrary.simpleMessage(
            "Kayıt olurken bir hata oluştu"),
        "resendVerificationEmail": MessageLookupByLibrary.simpleMessage(
            "Doğrulama E-postasını Tekrar Gönder"),
        "save": MessageLookupByLibrary.simpleMessage("Kaydet"),
        "send": MessageLookupByLibrary.simpleMessage("Gönder"),
        "settings": MessageLookupByLibrary.simpleMessage("Ayarlar"),
        "signup": MessageLookupByLibrary.simpleMessage("Kayıt Ol"),
        "success": MessageLookupByLibrary.simpleMessage("Başarılı"),
        "tapUploadButton": MessageLookupByLibrary.simpleMessage(
            "Video seçmek için aşağıdaki Yükle butonuna dokunun"),
        "termsOfService":
            MessageLookupByLibrary.simpleMessage("Kullanım Koşulları"),
        "tooManyRequests": MessageLookupByLibrary.simpleMessage(
            "Çok fazla istek yapıldı. Lütfen daha sonra tekrar deneyin"),
        "uploadRequired": MessageLookupByLibrary.simpleMessage("Video Gerekli"),
        "uploadToBegin": MessageLookupByLibrary.simpleMessage(
            "Başlamak için bir video yükleyin"),
        "uploadVideo": MessageLookupByLibrary.simpleMessage("Video Yükle"),
        "userDisabled": MessageLookupByLibrary.simpleMessage(
            "Bu kullanıcı devre dışı bırakılmış"),
        "userNotAuthenticated":
            MessageLookupByLibrary.simpleMessage("Kullanıcı girişi yapılmamış"),
        "userNotFound": MessageLookupByLibrary.simpleMessage(
            "Bu e-posta ile kayıtlı kullanıcı bulunamadı"),
        "verificationEmailSent": MessageLookupByLibrary.simpleMessage(
            "Doğrulama E-postası Gönderildi"),
        "verificationEmailSentMessage": MessageLookupByLibrary.simpleMessage(
            "E-posta adresinize doğrulama bağlantısı gönderdik. Lütfen gelen kutunuzu kontrol edin."),
        "version": MessageLookupByLibrary.simpleMessage("Sürüm"),
        "videoAnalysis": m11,
        "viewFullHistory": MessageLookupByLibrary.simpleMessage(
            "Tüm Analiz Geçmişini Görüntüle"),
        "weakPassword": MessageLookupByLibrary.simpleMessage("Şifre çok zayıf"),
        "welcome": MessageLookupByLibrary.simpleMessage("Hoş Geldiniz"),
        "welcomeBack": m12,
        "wrongPassword": MessageLookupByLibrary.simpleMessage("Hatalı şifre"),
        "yourVideo": MessageLookupByLibrary.simpleMessage("Videonuz")
      };
}
