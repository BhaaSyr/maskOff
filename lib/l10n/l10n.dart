import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'l10n_en.dart';
import 'l10n_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of S
/// returned by `S.of(context)`.
///
/// Applications need to include `S.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/l10n.dart';
///
/// return MaterialApp(
///   localizationsDelegates: S.localizationsDelegates,
///   supportedLocales: S.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the S.supportedLocales
/// property.
abstract class S {
  S(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static S? of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  static const LocalizationsDelegate<S> delegate = _SDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr')
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Mask Off'**
  String get appTitle;

  /// Welcome message
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// Login button text
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// Sign up button text
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signup;

  /// Settings menu item
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Dark mode toggle
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// Language selection option
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Home page subtitle
  ///
  /// In en, this message translates to:
  /// **'Detect deepfake videos with advanced AI technology'**
  String get detectDeepfake;

  /// Upload video button text
  ///
  /// In en, this message translates to:
  /// **'Upload Video'**
  String get uploadVideo;

  /// Analyze button text
  ///
  /// In en, this message translates to:
  /// **'Analyze'**
  String get analyze;

  /// Error message title when no video is uploaded
  ///
  /// In en, this message translates to:
  /// **'Upload Required'**
  String get uploadRequired;

  /// Error message content when no video is uploaded
  ///
  /// In en, this message translates to:
  /// **'Please upload a video first'**
  String get pleaseUploadFirst;

  /// Label for uploaded video
  ///
  /// In en, this message translates to:
  /// **'Your Video'**
  String get yourVideo;

  /// Empty state title
  ///
  /// In en, this message translates to:
  /// **'Upload a video to begin'**
  String get uploadToBegin;

  /// Empty state subtitle
  ///
  /// In en, this message translates to:
  /// **'Tap the Upload button below to select a video'**
  String get tapUploadButton;

  /// Title for the results page
  ///
  /// In en, this message translates to:
  /// **'Analysis Results'**
  String get analysisResults;

  /// Button to return to homepage
  ///
  /// In en, this message translates to:
  /// **'Back to Homepage'**
  String get backToHomepage;

  /// Logout button text
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// Logout confirmation message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get logoutConfirmation;

  /// Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Email field label
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Email field hint text
  ///
  /// In en, this message translates to:
  /// **'Enter your email address'**
  String get emailHint;

  /// Password field label
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Password field hint text
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordHint;

  /// Forgot password button text
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPassword;

  /// Divider text between login options
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get or;

  /// Google login button text
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get loginWithGoogle;

  /// Text for users without an account
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get noAccount;

  /// Password reset dialog title
  ///
  /// In en, this message translates to:
  /// **'Password Reset'**
  String get passwordReset;

  /// Password reset dialog info
  ///
  /// In en, this message translates to:
  /// **'Enter your email for a password reset link'**
  String get passwordResetInfo;

  /// Send button text for password reset
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// Register page title
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// Create account heading
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// Registration form subtitle
  ///
  /// In en, this message translates to:
  /// **'Please enter your information'**
  String get enterInfo;

  /// Full name field label
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// Full name field hint
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get fullNameHint;

  /// Password hint for registration
  ///
  /// In en, this message translates to:
  /// **'Enter password (minimum 6 characters)'**
  String get passwordHintRegister;

  /// Confirm password field label
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// Confirm password field hint
  ///
  /// In en, this message translates to:
  /// **'Re-enter your password'**
  String get confirmPasswordHint;

  /// Text for users with existing account
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get haveAccount;

  /// Result message for deepfake video
  ///
  /// In en, this message translates to:
  /// **'This video is likely a deepfake with a probability of %{score}.'**
  String deepfakeResult(String score);

  /// Result message for real video
  ///
  /// In en, this message translates to:
  /// **'This video likely appears real with a probability of %{score}.'**
  String realVideoResult(String score);

  /// Title for detected deepfake video
  ///
  /// In en, this message translates to:
  /// **'Deepfake Detected'**
  String get deepfakeDetected;

  /// Title for detected deepfake video
  ///
  /// In en, this message translates to:
  /// **'Deepfake Video'**
  String get deepfakeVideo;

  /// Title for authentic video
  ///
  /// In en, this message translates to:
  /// **'Authentic Video'**
  String get authenticVideo;

  /// Label for AI's confidence score
  ///
  /// In en, this message translates to:
  /// **'Confidence Score'**
  String get confidenceScore;

  /// About section title in settings
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// Appearance section title in settings
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// Privacy policy link
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// Terms of service link
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// App version label
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// Email verification required title
  ///
  /// In en, this message translates to:
  /// **'Email Verification Required'**
  String get emailVerificationRequired;

  /// Email verification message
  ///
  /// In en, this message translates to:
  /// **'Please verify your email to access your account'**
  String get pleaseVerifyEmail;

  /// Button to resend verification email
  ///
  /// In en, this message translates to:
  /// **'Resend Verification Email'**
  String get resendVerificationEmail;

  /// Verification email sent title
  ///
  /// In en, this message translates to:
  /// **'Email Verification Sent'**
  String get verificationEmailSent;

  /// Verification email sent message
  ///
  /// In en, this message translates to:
  /// **'We have sent a verification link to your email. Please check your inbox.'**
  String get verificationEmailSentMessage;

  /// Email field empty validation message
  ///
  /// In en, this message translates to:
  /// **'Email field cannot be empty'**
  String get emailFieldEmpty;

  /// Invalid email validation message
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get invalidEmail;

  /// Password field empty validation message
  ///
  /// In en, this message translates to:
  /// **'Password field cannot be empty'**
  String get passwordFieldEmpty;

  /// Password minimum length validation message
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordMinLength;

  /// Name field empty validation message
  ///
  /// In en, this message translates to:
  /// **'Full name field cannot be empty'**
  String get nameFieldEmpty;

  /// Confirm password field empty validation message
  ///
  /// In en, this message translates to:
  /// **'Confirm password field cannot be empty'**
  String get confirmPasswordEmpty;

  /// Passwords mismatch validation message
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// Success message title
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// Error message title
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// Login successful message
  ///
  /// In en, this message translates to:
  /// **'Login successful'**
  String get loginSuccessful;

  /// Registration error message
  ///
  /// In en, this message translates to:
  /// **'An error occurred during registration'**
  String get registrationError;

  /// Login error message
  ///
  /// In en, this message translates to:
  /// **'An error occurred during login'**
  String get loginError;

  /// Email already in use error message
  ///
  /// In en, this message translates to:
  /// **'This email address is already in use'**
  String get emailAlreadyInUse;

  /// Weak password error message
  ///
  /// In en, this message translates to:
  /// **'Password is too weak'**
  String get weakPassword;

  /// Operation not allowed error message
  ///
  /// In en, this message translates to:
  /// **'Email/password registration is not enabled'**
  String get operationNotAllowed;

  /// User not found error message
  ///
  /// In en, this message translates to:
  /// **'No user found with this email'**
  String get userNotFound;

  /// Wrong password error message
  ///
  /// In en, this message translates to:
  /// **'Incorrect password'**
  String get wrongPassword;

  /// User disabled error message
  ///
  /// In en, this message translates to:
  /// **'This user has been disabled'**
  String get userDisabled;

  /// Password reset email sent title
  ///
  /// In en, this message translates to:
  /// **'Password Reset Email Sent'**
  String get passwordResetEmailSent;

  /// Password reset email sent message
  ///
  /// In en, this message translates to:
  /// **'Password reset link has been sent to {email}.\n\nPlease check your email and click the link to reset your password.'**
  String passwordResetEmailSentMessage(String email);

  /// OK button text
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// Password reset error message
  ///
  /// In en, this message translates to:
  /// **'An error occurred during password reset'**
  String get passwordResetError;

  /// Too many requests error message
  ///
  /// In en, this message translates to:
  /// **'Too many requests. Please try again later'**
  String get tooManyRequests;

  /// Google login success message
  ///
  /// In en, this message translates to:
  /// **'Successfully signed in with Google account'**
  String get googleLoginSuccess;

  /// Google login error message
  ///
  /// In en, this message translates to:
  /// **'An error occurred while signing in with Google'**
  String get googleLoginError;

  /// Logout error message
  ///
  /// In en, this message translates to:
  /// **'An error occurred during logout'**
  String get logoutError;

  /// Profile page title
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// First name field label
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// Last name field label
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// Age field label
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// Save button text
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// First name required validation message
  ///
  /// In en, this message translates to:
  /// **'First name is required'**
  String get firstNameRequired;

  /// Last name required validation message
  ///
  /// In en, this message translates to:
  /// **'Last name is required'**
  String get lastNameRequired;

  /// Invalid age validation message
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid age (1-150)'**
  String get invalidAge;

  /// Profile update success message
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get profileUpdateSuccess;

  /// Welcome message with user's name
  ///
  /// In en, this message translates to:
  /// **'Welcome back, {name}!'**
  String welcomeBack(String name);

  /// Personal information section title
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInformation;

  /// First name field hint
  ///
  /// In en, this message translates to:
  /// **'Enter your first name'**
  String get firstNameHint;

  /// Last name field hint
  ///
  /// In en, this message translates to:
  /// **'Enter your last name'**
  String get lastNameHint;

  /// Age field hint
  ///
  /// In en, this message translates to:
  /// **'Enter your age (optional)'**
  String get ageHint;

  /// Analysis history section title
  ///
  /// In en, this message translates to:
  /// **'Analysis History'**
  String get analysisHistory;

  /// Loading history message
  ///
  /// In en, this message translates to:
  /// **'Loading history...'**
  String get loadingHistory;

  /// Empty history state title
  ///
  /// In en, this message translates to:
  /// **'No analysis history yet'**
  String get noAnalysisHistoryYet;

  /// Empty history state message
  ///
  /// In en, this message translates to:
  /// **'Analyze a video to see your results here'**
  String get analyzeVideoToSeeResults;

  /// Delete record dialog title
  ///
  /// In en, this message translates to:
  /// **'Delete Record'**
  String get deleteRecord;

  /// Delete record confirmation message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{title}\"? This action cannot be undone.'**
  String deleteRecordConfirmation(String title);

  /// Delete button text
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Record deleted success message
  ///
  /// In en, this message translates to:
  /// **'Record deleted successfully'**
  String get recordDeletedSuccessfully;

  /// Failed to delete record error message
  ///
  /// In en, this message translates to:
  /// **'Failed to delete record: {error}'**
  String failedToDeleteRecord(String error);

  /// Video analysis title with filename
  ///
  /// In en, this message translates to:
  /// **'Video Analysis - {filename}'**
  String videoAnalysis(String filename);

  /// Deepfake detection completed message
  ///
  /// In en, this message translates to:
  /// **'Deepfake detection analysis completed'**
  String get deepfakeDetectionCompleted;

  /// Authentic video verification completed message
  ///
  /// In en, this message translates to:
  /// **'Authentic video verification completed'**
  String get authenticVideoVerificationCompleted;

  /// Real video result
  ///
  /// In en, this message translates to:
  /// **'Real Video'**
  String get realVideo;

  /// No description provided for @viewFullHistory.
  ///
  /// In en, this message translates to:
  /// **'View Full History'**
  String get viewFullHistory;

  /// No description provided for @analyzingVideo.
  ///
  /// In en, this message translates to:
  /// **'Analyzing Video'**
  String get analyzingVideo;

  /// No description provided for @pleaseWait.
  ///
  /// In en, this message translates to:
  /// **'Please wait while we analyze your video...'**
  String get pleaseWait;

  /// profile_controller.dart
  ///
  /// In en, this message translates to:
  /// **'User not authenticated'**
  String get userNotAuthenticated;

  /// profile_controller.dart
  ///
  /// In en, this message translates to:
  /// **'Failed to load profile: {error}'**
  String failedToLoadProfile(Object error);

  /// profile_controller.dart
  ///
  /// In en, this message translates to:
  /// **'Failed to create user profile: {error}'**
  String failedToCreateProfile(Object error);

  /// profile_controller.dart
  ///
  /// In en, this message translates to:
  /// **'Failed to save profile: {error}'**
  String failedToSaveProfile(Object error);

  /// profile_controller.dart
  ///
  /// In en, this message translates to:
  /// **'Failed to load history: {error}'**
  String failedToLoadHistory(Object error);

  /// profile_controller.dart
  ///
  /// In en, this message translates to:
  /// **'Failed to add record: {error}'**
  String failedToAddRecord(Object error);

  /// profile_controller.dart
  ///
  /// In en, this message translates to:
  /// **'Failed to update record: {error}'**
  String failedToUpdateRecord(Object error);

  /// Invalid credential error message
  ///
  /// In en, this message translates to:
  /// **'Invalid login credentials. Please check your email and password and try again.'**
  String get invalidCredential;

  /// Title for video editing page
  ///
  /// In en, this message translates to:
  /// **'Edit Video'**
  String get editVideo;

  /// Play button text
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get play;

  /// Pause button text
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pause;

  /// Saving in progress text
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get saving;

  /// Video trimming section title
  ///
  /// In en, this message translates to:
  /// **'Video Trimming'**
  String get videoTrimming;

  /// Video processing message
  ///
  /// In en, this message translates to:
  /// **'Processing video, please wait...'**
  String get processingVideo;

  /// Error message shown when video saving fails
  ///
  /// In en, this message translates to:
  /// **'Failed to save video. Please try again.'**
  String get failedToSaveVideo;

  /// Title for video name dialog
  ///
  /// In en, this message translates to:
  /// **'Video Name'**
  String get videoName;

  /// Hint text for video name input
  ///
  /// In en, this message translates to:
  /// **'Enter video name'**
  String get enterVideoName;

  /// Confirm button text
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;
}

class _SDelegate extends LocalizationsDelegate<S> {
  const _SDelegate();

  @override
  Future<S> load(Locale locale) {
    return SynchronousFuture<S>(lookupS(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_SDelegate old) => false;
}

S lookupS(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return SEn();
    case 'tr':
      return STr();
  }

  throw FlutterError(
      'S.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
