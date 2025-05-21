import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testvid/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Observable user state
  final Rx<User?> user = Rx<User?>(null);

  // General auth error
  final authError = ''.obs;

  // Using Rx wrappers for controllers to prevent disposal issues
  final Rx<TextEditingController> _emailController =
      TextEditingController().obs;
  final Rx<TextEditingController> _passwordController =
      TextEditingController().obs;
  final Rx<TextEditingController> _confirmPasswordController =
      TextEditingController().obs;
  final Rx<TextEditingController> _nameController = TextEditingController().obs;

  // Getters for controllers
  TextEditingController get emailController => _emailController.value;
  TextEditingController get passwordController => _passwordController.value;
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController.value;
  TextEditingController get nameController => _nameController.value;

  // Mevcut ekran izleyicisi
  final RxString _currentScreen = "".obs;
  String get currentScreen => _currentScreen.value;

  // Form validation errors
  final emailError = ''.obs;
  final passwordError = ''.obs;
  final confirmPasswordError = ''.obs;
  final nameError = ''.obs;
  final termsError = ''.obs;

  // Password visibility
  final obscurePassword = true.obs;
  final obscureConfirmPassword = true.obs;

  // Terms and conditions
  final acceptedTerms = true.obs;

  // Loading states - different types of loading indicators
  final isEmailLoginLoading = false.obs;
  final isGoogleLoginLoading = false.obs;
  final isRegisterLoading = false.obs;

  // Reset password functionality
  final isResettingPassword = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Listen for field changes to clear errors when user types
    _setupErrorClearingListeners();

    // Set up auth state listener
    _auth.authStateChanges().listen((User? firebaseUser) {
      user.value = firebaseUser;
    });

    // Listen for route changes to track current screen
    ever(_currentScreen, _onScreenChanged);
  }

  @override
  void onClose() {
    // Dispose of controllers safely
    _emailController.value.dispose();
    _passwordController.value.dispose();
    _confirmPasswordController.value.dispose();
    _nameController.value.dispose();
    super.onClose();
  }

  // Password visibility toggle functions
  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }

  // Reset password functionality
  Future<String?> resetPassword(String email) async {
    if (email.isEmpty) {
      return 'E-posta alanı boş bırakılamaz';
    }

    if (!GetUtils.isEmail(email)) {
      return 'Geçerli bir e-posta adresi girin';
    }

    try {
      isResettingPassword.value = true;

      await _auth.sendPasswordResetEmail(email: email.trim());

      // Close the dialog first
      Get.back();

      // Then show a more prominent notification
      Get.dialog(
        AlertDialog(
          backgroundColor:
              Get.isDarkMode ? const Color(0xFF2D2D44) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Şifre Sıfırlama E-postası Gönderildi',
            style: TextStyle(
              color: Color(0xFF6C63FF),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Şifre sıfırlama bağlantısı $email adresine gönderildi.\n\nLütfen e-posta kutunuzu kontrol edin ve bağlantıya tıklayarak şifrenizi sıfırlayın.',
            style: TextStyle(
              fontSize: 16,
              color: Get.isDarkMode ? Colors.white70 : const Color(0xFF666666),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text(
                'Tamam',
                style: TextStyle(
                  color: Color(0xFF6C63FF),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      );
      return null; // No error
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Şifre sıfırlama işlemi sırasında bir hata oluştu';

      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'Geçersiz e-posta adresi';
          break;
        case 'user-not-found':
          errorMessage = 'Bu e-posta ile kayıtlı kullanıcı bulunamadı';
          break;
        case 'too-many-requests':
          errorMessage =
              'Çok fazla istek yapıldı. Lütfen daha sonra tekrar deneyin';
          break;
      }

      return errorMessage;
    } catch (e) {
      return 'Şifre sıfırlama işlemi sırasında bir hata oluştu: ${e.toString()}';
    } finally {
      isResettingPassword.value = false;
    }
  }

  // Toggle terms and conditions acceptance
  void toggleTermsAcceptance() {
    acceptedTerms.value = !acceptedTerms.value;
    if (acceptedTerms.value) {
      termsError.value = '';
    }
  }

  // Setup listeners to clear errors on field change
  void _setupErrorClearingListeners() {
    emailController.addListener(() {
      if (emailError.value.isNotEmpty) {
        emailError.value = '';
      }
    });

    passwordController.addListener(() {
      if (passwordError.value.isNotEmpty) {
        passwordError.value = '';
      }
    });

    confirmPasswordController.addListener(() {
      if (confirmPasswordError.value.isNotEmpty) {
        confirmPasswordError.value = '';
      }
    });

    nameController.addListener(() {
      if (nameError.value.isNotEmpty) {
        nameError.value = '';
      }
    });
  }

  // Clear all form data
  void clearFormData() {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    nameController.clear();

    emailError.value = '';
    passwordError.value = '';
    confirmPasswordError.value = '';
    nameError.value = '';
    termsError.value = '';
    authError.value = '';
  }

  // Clear only login form data
  void clearLoginForm() {
    emailController.clear();
    passwordController.clear();
    emailError.value = '';
    passwordError.value = '';
    authError.value = '';
    resetPasswordVisibility();
  }

  // Clear only register form data
  void clearRegisterForm() {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    nameController.clear();
    emailError.value = '';
    passwordError.value = '';
    confirmPasswordError.value = '';
    nameError.value = '';
    termsError.value = '';
    authError.value = '';
    acceptedTerms.value = true;
    resetPasswordVisibility();
  }

  // Reset password visibility states
  void resetPasswordVisibility() {
    obscurePassword.value = true;
    obscureConfirmPassword.value = true;
  }

  // Form validation
  bool _validateLoginForm() {
    bool isValid = true;

    // Email validation
    if (emailController.text.isEmpty) {
      emailError.value = 'E-posta alanı boş bırakılamaz';
      isValid = false;
    } else if (!GetUtils.isEmail(emailController.text)) {
      emailError.value = 'Geçerli bir e-posta adresi girin';
      isValid = false;
    }

    // Password validation
    if (passwordController.text.isEmpty) {
      passwordError.value = 'Şifre alanı boş bırakılamaz';
      isValid = false;
    } else if (passwordController.text.length < 6) {
      passwordError.value = 'Şifre en az 6 karakter olmalıdır';
      isValid = false;
    }

    return isValid;
  }

  bool _validateRegisterForm() {
    bool isValid = true;

    // Name validation
    if (nameController.text.isEmpty) {
      nameError.value = 'Ad Soyad alanı boş bırakılamaz';
      isValid = false;
    }

    // Email validation
    if (emailController.text.isEmpty) {
      emailError.value = 'E-posta alanı boş bırakılamaz';
      isValid = false;
    } else if (!GetUtils.isEmail(emailController.text)) {
      emailError.value = 'Geçerli bir e-posta adresi girin';
      isValid = false;
    }

    // Password validation
    if (passwordController.text.isEmpty) {
      passwordError.value = 'Şifre alanı boş bırakılamaz';
      isValid = false;
    } else if (passwordController.text.length < 6) {
      passwordError.value = 'Şifre en az 6 karakter olmalıdır';
      isValid = false;
    }

    // Confirm password validation
    if (confirmPasswordController.text.isEmpty) {
      confirmPasswordError.value = 'Şifre tekrar alanı boş bırakılamaz';
      isValid = false;
    } else if (confirmPasswordController.text != passwordController.text) {
      confirmPasswordError.value = 'Şifreler eşleşmiyor';
      isValid = false;
    }

    // Terms validation
    // if (!acceptedTerms.value) {
    //   termsError.value = 'Şartlar ve koşulları kabul etmelisiniz';
    //   isValid = false;
    // }

    return isValid;
  }

  // Login function
  void login() async {
    // Clear any previous auth errors
    authError.value = '';

    if (!_validateLoginForm()) return;

    try {
      isEmailLoginLoading.value = true;

      // Use Firebase Auth to sign in
      await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Clear text fields
      clearFormData();

      // Show success message
      _showSuccessSnackbar('Başarılı', 'Giriş başarıyla gerçekleştirildi');

      // Navigate to home screen
      Get.offAllNamed(Routes.HOME);
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Giriş yapılırken bir hata oluştu';

      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'Bu e-posta ile kayıtlı kullanıcı bulunamadı';
          break;
        case 'wrong-password':
          errorMessage = 'Hatalı şifre';
          break;
        case 'invalid-email':
          errorMessage = 'Geçersiz e-posta adresi';
          break;
        case 'user-disabled':
          errorMessage = 'Bu kullanıcı devre dışı bırakılmış';
          break;
      }

      authError.value = errorMessage;

      _showErrorSnackbar('Hata', errorMessage);
    } catch (e) {
      authError.value = 'Giriş yapılırken bir hata oluştu: ${e.toString()}';

      _showErrorSnackbar(
          'Hata', 'Giriş yapılırken bir hata oluştu: ${e.toString()}');
    } finally {
      isEmailLoginLoading.value = false;
    }
  }

  // Register function
  void register() async {
    // Clear any previous auth errors
    authError.value = '';

    if (!_validateRegisterForm()) return;

    try {
      isRegisterLoading.value = true;

      // Create user with Firebase Auth
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Update display name
      await userCredential.user?.updateDisplayName(nameController.text.trim());

      // Clear form data
      clearFormData();
      acceptedTerms.value = true;

      // Show success message
      _showSuccessSnackbar('Başarılı', 'Kayıt işlemi başarıyla tamamlandı');

      // Navigate to home screen (or login if needed)
      Get.offAllNamed(Routes.HOME);
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Kayıt olurken bir hata oluştu';

      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'Bu e-posta adresi zaten kullanımda';
          break;
        case 'invalid-email':
          errorMessage = 'Geçersiz e-posta adresi';
          break;
        case 'weak-password':
          errorMessage = 'Şifre çok zayıf';
          break;
        case 'operation-not-allowed':
          errorMessage = 'E-posta/şifre ile kayıt etkinleştirilmemiş';
          break;
      }

      authError.value = errorMessage;

      _showErrorSnackbar('Hata', errorMessage);
    } catch (e) {
      authError.value = 'Kayıt olurken bir hata oluştu: ${e.toString()}';

      _showErrorSnackbar(
          'Hata', 'Kayıt olurken bir hata oluştu: ${e.toString()}');
    } finally {
      isRegisterLoading.value = false;
    }
  }

  // Google Sign In
  Future<void> signInWithGoogle() async {
    try {
      isGoogleLoginLoading.value = true;

      // Start the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // If user cancels the sign-in flow
      if (googleUser == null) {
        isGoogleLoginLoading.value = false;
        return;
      }

      // Obtain auth details from the Google Sign-In
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create credential for Firebase
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      await _auth.signInWithCredential(credential);

      // Show success message
      _showSuccessSnackbar('Başarılı', 'Google hesabınız ile giriş yapıldı');

      // Navigate to home screen
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      authError.value =
          'Google ile giriş yapılırken bir hata oluştu: ${e.toString()}';

      _showErrorSnackbar('Hata',
          'Google ile giriş yapılırken bir hata oluştu: ${e.toString()}');
    } finally {
      isGoogleLoginLoading.value = false;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      _showErrorSnackbar(
          'Hata', 'Çıkış yapılırken bir hata oluştu: ${e.toString()}');
    }
  }

  // Check if user is logged in
  bool isLoggedIn() {
    return user.value != null;
  }

  // View terms and conditions
  void viewTermsAndConditions() {
    // TODO: Implement terms and conditions view
    Get.dialog(
      AlertDialog(
        title: const Text('Şartlar ve Koşullar'),
        content: const SingleChildScrollView(
          child: Text(
            'Buraya şartlar ve koşullar metni gelecek. '
            'Bu, uygulamanın kullanım şartlarını, gizlilik politikasını ve diğer önemli bilgileri içerecektir.',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Kapat'),
          ),
        ],
      ),
    );
  }

  // Güncellenmiş hata bildirimi için genel bir metot oluşturalım
  void _showErrorSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.withOpacity(0.3),
      colorText: Colors.white,
      borderRadius: 10,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 4),
      icon: const Icon(Icons.error_outline, color: Colors.white),
    );
  }

  // Başarılı işlem bildirimi için genel bir metot oluşturalım
  void _showSuccessSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withOpacity(0.3),
      colorText: Colors.white,
      borderRadius: 10,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.check_circle, color: Colors.white),
    );
  }

  // Set current screen
  void setCurrentScreen(String screen) {
    if (_currentScreen.value != screen) {
      _currentScreen.value = screen;
    }
  }

  // Screen change handler - clear forms accordingly
  void _onScreenChanged(String screen) {
    if (screen == Routes.LOGIN) {
      // Login sayfasına geldiğimizde
      print("Login sayfasına geçildi, register form temizleniyor");
      clearRegisterForm();
    } else if (screen == Routes.REGISTER) {
      // Register sayfasına geldiğimizde
      print("Register sayfasına geçildi, login form temizleniyor");
      clearLoginForm();
    }
  }
}
