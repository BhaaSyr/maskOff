// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class SEn extends S {
  SEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Mask Off';

  @override
  String get welcome => 'Welcome';

  @override
  String get login => 'Login';

  @override
  String get signup => 'Sign Up';

  @override
  String get settings => 'Settings';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get language => 'Language';

  @override
  String get detectDeepfake =>
      'Detect deepfake videos with advanced AI technology';

  @override
  String get uploadVideo => 'Upload Video';

  @override
  String get analyze => 'Analyze';

  @override
  String get uploadRequired => 'Upload Required';

  @override
  String get pleaseUploadFirst => 'Please upload a video first';

  @override
  String get yourVideo => 'Your Video';

  @override
  String get uploadToBegin => 'Upload a video to begin';

  @override
  String get tapUploadButton => 'Tap the Upload button below to select a video';

  @override
  String get analysisResults => 'Analysis Results';

  @override
  String get backToHomepage => 'Back to Homepage';

  @override
  String get logout => 'Logout';

  @override
  String get logoutConfirmation => 'Are you sure you want to logout?';

  @override
  String get cancel => 'Cancel';

  @override
  String get email => 'Email';

  @override
  String get emailHint => 'Enter your email address';

  @override
  String get password => 'Password';

  @override
  String get passwordHint => 'Enter your password';

  @override
  String get forgotPassword => 'Forgot Password';

  @override
  String get or => 'OR';

  @override
  String get loginWithGoogle => 'Sign in with Google';

  @override
  String get noAccount => 'Don\'t have an account?';

  @override
  String get passwordReset => 'Password Reset';

  @override
  String get passwordResetInfo => 'Enter your email for a password reset link';

  @override
  String get send => 'Send';

  @override
  String get register => 'Register';

  @override
  String get createAccount => 'Create Account';

  @override
  String get enterInfo => 'Please enter your information';

  @override
  String get fullName => 'Full Name';

  @override
  String get fullNameHint => 'Enter your full name';

  @override
  String get passwordHintRegister => 'Enter password (minimum 6 characters)';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get confirmPasswordHint => 'Re-enter your password';

  @override
  String get haveAccount => 'Already have an account?';

  @override
  String deepfakeResult(String score) {
    return 'This video is likely a deepfake with a probability of %$score.';
  }

  @override
  String realVideoResult(String score) {
    return 'This video likely appears real with a probability of %$score.';
  }

  @override
  String get deepfakeDetected => 'Deepfake Detected';

  @override
  String get deepfakeVideo => 'Deepfake Video';

  @override
  String get authenticVideo => 'Authentic Video';

  @override
  String get confidenceScore => 'Confidence Score';

  @override
  String get about => 'About';

  @override
  String get appearance => 'Appearance';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get version => 'Version';

  @override
  String get emailVerificationRequired => 'Email Verification Required';

  @override
  String get pleaseVerifyEmail =>
      'Please verify your email to access your account';

  @override
  String get resendVerificationEmail => 'Resend Verification Email';

  @override
  String get verificationEmailSent => 'Email Verification Sent';

  @override
  String get verificationEmailSentMessage =>
      'We have sent a verification link to your email. Please check your inbox.';

  @override
  String get emailFieldEmpty => 'Email field cannot be empty';

  @override
  String get invalidEmail => 'Please enter a valid email address';

  @override
  String get passwordFieldEmpty => 'Password field cannot be empty';

  @override
  String get passwordMinLength => 'Password must be at least 6 characters';

  @override
  String get nameFieldEmpty => 'Full name field cannot be empty';

  @override
  String get confirmPasswordEmpty => 'Confirm password field cannot be empty';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get success => 'Success';

  @override
  String get error => 'Error';

  @override
  String get loginSuccessful => 'Login successful';

  @override
  String get registrationError => 'An error occurred during registration';

  @override
  String get loginError => 'An error occurred during login';

  @override
  String get emailAlreadyInUse => 'This email address is already in use';

  @override
  String get weakPassword => 'Password is too weak';

  @override
  String get operationNotAllowed =>
      'Email/password registration is not enabled';

  @override
  String get userNotFound => 'No user found with this email';

  @override
  String get wrongPassword => 'Incorrect password';

  @override
  String get userDisabled => 'This user has been disabled';

  @override
  String get passwordResetEmailSent => 'Password Reset Email Sent';

  @override
  String passwordResetEmailSentMessage(String email) {
    return 'Password reset link has been sent to $email.\n\nPlease check your email and click the link to reset your password.';
  }

  @override
  String get ok => 'OK';

  @override
  String get passwordResetError => 'An error occurred during password reset';

  @override
  String get tooManyRequests => 'Too many requests. Please try again later';

  @override
  String get googleLoginSuccess => 'Successfully signed in with Google account';

  @override
  String get googleLoginError =>
      'An error occurred while signing in with Google';

  @override
  String get logoutError => 'An error occurred during logout';

  @override
  String get profile => 'Profile';

  @override
  String get firstName => 'First Name';

  @override
  String get lastName => 'Last Name';

  @override
  String get age => 'Age';

  @override
  String get save => 'Save';

  @override
  String get firstNameRequired => 'First name is required';

  @override
  String get lastNameRequired => 'Last name is required';

  @override
  String get invalidAge => 'Please enter a valid age (1-150)';

  @override
  String get profileUpdateSuccess => 'Profile updated successfully';

  @override
  String welcomeBack(String name) {
    return 'Welcome back, $name!';
  }

  @override
  String get personalInformation => 'Personal Information';

  @override
  String get firstNameHint => 'Enter your first name';

  @override
  String get lastNameHint => 'Enter your last name';

  @override
  String get ageHint => 'Enter your age (optional)';

  @override
  String get analysisHistory => 'Analysis History';

  @override
  String get loadingHistory => 'Loading history...';

  @override
  String get noAnalysisHistoryYet => 'No analysis history yet';

  @override
  String get analyzeVideoToSeeResults =>
      'Analyze a video to see your results here';

  @override
  String get deleteRecord => 'Delete Record';

  @override
  String deleteRecordConfirmation(String title) {
    return 'Are you sure you want to delete \"$title\"? This action cannot be undone.';
  }

  @override
  String get delete => 'Delete';

  @override
  String get recordDeletedSuccessfully => 'Record deleted successfully';

  @override
  String failedToDeleteRecord(String error) {
    return 'Failed to delete record: $error';
  }

  @override
  String videoAnalysis(String filename) {
    return 'Video Analysis - $filename';
  }

  @override
  String get deepfakeDetectionCompleted =>
      'Deepfake detection analysis completed';

  @override
  String get authenticVideoVerificationCompleted =>
      'Authentic video verification completed';

  @override
  String get realVideo => 'Real Video';

  @override
  String get viewFullHistory => 'View Full History';

  @override
  String get analyzingVideo => 'Analyzing Video';

  @override
  String get pleaseWait => 'Please wait while we analyze your video...';

  @override
  String get userNotAuthenticated => 'User not authenticated';

  @override
  String failedToLoadProfile(Object error) {
    return 'Failed to load profile: $error';
  }

  @override
  String failedToCreateProfile(Object error) {
    return 'Failed to create user profile: $error';
  }

  @override
  String failedToSaveProfile(Object error) {
    return 'Failed to save profile: $error';
  }

  @override
  String failedToLoadHistory(Object error) {
    return 'Failed to load history: $error';
  }

  @override
  String failedToAddRecord(Object error) {
    return 'Failed to add record: $error';
  }

  @override
  String failedToUpdateRecord(Object error) {
    return 'Failed to update record: $error';
  }

  @override
  String get invalidCredential =>
      'Invalid login credentials. Please check your email and password and try again.';

  @override
  String get editVideo => 'Edit Video';

  @override
  String get play => 'Play';

  @override
  String get pause => 'Pause';

  @override
  String get saving => 'Saving...';

  @override
  String get videoTrimming => 'Video Trimming';

  @override
  String get processingVideo => 'Processing video, please wait...';

  @override
  String get failedToSaveVideo => 'Failed to save video. Please try again.';

  @override
  String get videoName => 'Video Name';

  @override
  String get enterVideoName => 'Enter video name';

  @override
  String get confirm => 'Confirm';
}
