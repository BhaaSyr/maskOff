import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testvid/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:testvid/generated/l10n.dart';

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
    // Get localization context
    final context = Get.context;
    if (context == null) return 'Context not available';

    if (email.isEmpty) {
      return S.of(context).emailFieldEmpty;
    }

    if (!GetUtils.isEmail(email)) {
      return S.of(context).invalidEmail;
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
          title: Text(
            S.of(context).passwordResetEmailSent,
            style: const TextStyle(
              color: Color(0xFF6C63FF),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            S.of(context).passwordResetEmailSentMessage(email),
            style: TextStyle(
              fontSize: 16,
              color: Get.isDarkMode ? Colors.white70 : const Color(0xFF666666),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text(
                S.of(context).ok,
                style: const TextStyle(
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
      String errorMessage = S.of(context).passwordResetError;

      switch (e.code) {
        case 'invalid-email':
          errorMessage = S.of(context).invalidEmail;
          break;
        case 'user-not-found':
          errorMessage = S.of(context).userNotFound;
          break;
        case 'too-many-requests':
          errorMessage = S.of(context).tooManyRequests;
          break;
      }

      return errorMessage;
    } catch (e) {
      return '${S.of(context).passwordResetError}: ${e.toString()}';
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

    // Get localization context
    final context = Get.context;
    if (context == null) return false;

    // Email validation
    if (emailController.text.isEmpty) {
      emailError.value = S.of(context).emailFieldEmpty;
      isValid = false;
    } else if (!GetUtils.isEmail(emailController.text)) {
      emailError.value = S.of(context).invalidEmail;
      isValid = false;
    }

    // Password validation
    if (passwordController.text.isEmpty) {
      passwordError.value = S.of(context).passwordFieldEmpty;
      isValid = false;
    } else if (passwordController.text.length < 6) {
      passwordError.value = S.of(context).passwordMinLength;
      isValid = false;
    }

    return isValid;
  }

  bool _validateRegisterForm() {
    bool isValid = true;

    // Get localization context
    final context = Get.context;
    if (context == null) return false;

    // Name validation
    if (nameController.text.isEmpty) {
      nameError.value = S.of(context).nameFieldEmpty;
      isValid = false;
    }

    // Email validation
    if (emailController.text.isEmpty) {
      emailError.value = S.of(context).emailFieldEmpty;
      isValid = false;
    } else if (!GetUtils.isEmail(emailController.text)) {
      emailError.value = S.of(context).invalidEmail;
      isValid = false;
    }

    // Password validation
    if (passwordController.text.isEmpty) {
      passwordError.value = S.of(context).passwordFieldEmpty;
      isValid = false;
    } else if (passwordController.text.length < 6) {
      passwordError.value = S.of(context).passwordMinLength;
      isValid = false;
    }

    // Confirm password validation
    if (confirmPasswordController.text.isEmpty) {
      confirmPasswordError.value = S.of(context).confirmPasswordEmpty;
      isValid = false;
    } else if (confirmPasswordController.text != passwordController.text) {
      confirmPasswordError.value = S.of(context).passwordsDoNotMatch;
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

    // Get localization context
    final context = Get.context;
    if (context == null) return;

    try {
      isEmailLoginLoading.value = true;

      // Use Firebase Auth to sign in
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Check if email is verified
      if (userCredential.user != null && !userCredential.user!.emailVerified) {
        // Sign out the user since email isn't verified
        await _auth.signOut();

        // Show error message
        _showErrorSnackbar(S.of(context).emailVerificationRequired,
            S.of(context).pleaseVerifyEmail);

        // Show dialog to resend verification email
        Get.dialog(
          AlertDialog(
            backgroundColor:
                Get.isDarkMode ? const Color(0xFF2D2D44) : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(
              S.of(context).emailVerificationRequired,
              style: const TextStyle(
                color: Color(0xFF6C63FF),
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              S.of(context).pleaseVerifyEmail,
            ),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: Text(
                  S.of(context).cancel,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  Get.back();
                  try {
                    // Re-authenticate to get fresh user
                    UserCredential userCred =
                        await _auth.signInWithEmailAndPassword(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );
                    await userCred.user?.sendEmailVerification();
                    _showSuccessSnackbar(S.of(context).verificationEmailSent,
                        S.of(context).verificationEmailSentMessage);
                    await _auth.signOut();
                  } catch (e) {
                    _showErrorSnackbar(S.of(context).error,
                        '${S.of(context).emailVerificationRequired}: ${e.toString()}');
                  }
                },
                child: Text(
                  S.of(context).resendVerificationEmail,
                  style: const TextStyle(
                    color: Color(0xFF6C63FF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
        return;
      }

      // Clear text fields
      clearFormData();

      // Show success message
      _showSuccessSnackbar(
          S.of(context).success, S.of(context).loginSuccessful);

      // Navigate to home screen
      Get.offAllNamed(Routes.HOME);
    } on FirebaseAuthException catch (e) {
      String errorMessage = S.of(context).loginError;

      switch (e.code) {
        case 'user-not-found':
          errorMessage = S.of(context).userNotFound;
          break;
        case 'wrong-password':
          errorMessage = S.of(context).wrongPassword;
          break;
        case 'invalid-email':
          errorMessage = S.of(context).invalidEmail;
          break;
        case 'user-disabled':
          errorMessage = S.of(context).userDisabled;
          break;
      }

      authError.value = errorMessage;

      _showErrorSnackbar(S.of(context).error, errorMessage);
    } catch (e) {
      authError.value = '${S.of(context).loginError}: ${e.toString()}';

      _showErrorSnackbar(
          S.of(context).error, '${S.of(context).loginError}: ${e.toString()}');
    } finally {
      isEmailLoginLoading.value = false;
    }
  }

  // Register function
  void register() async {
    // Clear any previous auth errors
    authError.value = '';

    if (!_validateRegisterForm()) return;

    // Get localization context
    final context = Get.context;
    if (context == null) return;

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

      // Send email verification
      await userCredential.user?.sendEmailVerification();

      // Clear form data
      clearFormData();
      acceptedTerms.value = true;

      // Show success message with email verification info
      _showSuccessSnackbar(S.of(context).verificationEmailSent,
          S.of(context).verificationEmailSentMessage);

      // Navigate to login screen instead of home
      Get.offAllNamed(Routes.LOGIN);
    } on FirebaseAuthException catch (e) {
      String errorMessage = S.of(context).registrationError;

      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = S.of(context).emailAlreadyInUse;
          break;
        case 'invalid-email':
          errorMessage = S.of(context).invalidEmail;
          break;
        case 'weak-password':
          errorMessage = S.of(context).weakPassword;
          break;
        case 'operation-not-allowed':
          errorMessage = S.of(context).operationNotAllowed;
          break;
      }

      authError.value = errorMessage;

      _showErrorSnackbar(S.of(context).error, errorMessage);
    } catch (e) {
      authError.value = '${S.of(context).registrationError}: ${e.toString()}';

      _showErrorSnackbar(S.of(context).error,
          '${S.of(context).registrationError}: ${e.toString()}');
    } finally {
      isRegisterLoading.value = false;
    }
  }

  // Google Sign In
  Future<void> signInWithGoogle() async {
    // Get localization context
    final context = Get.context;
    if (context == null) return;

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
      _showSuccessSnackbar(
          S.of(context).success, S.of(context).googleLoginSuccess);

      // Navigate to home screen
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      authError.value = '${S.of(context).googleLoginError}: ${e.toString()}';

      _showErrorSnackbar(S.of(context).error,
          '${S.of(context).googleLoginError}: ${e.toString()}');
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
      // Get localization context
      final context = Get.context;
      if (context != null) {
        _showErrorSnackbar(S.of(context).error,
            '${S.of(context).logoutError}: ${e.toString()}');
      }
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
