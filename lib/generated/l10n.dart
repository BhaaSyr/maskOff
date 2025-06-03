// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Mask Off`
  String get appTitle {
    return Intl.message(
      'Mask Off',
      name: 'appTitle',
      desc: 'The title of the application',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: 'Welcome message',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: 'Login button text',
      args: [],
    );
  }

  /// `Sign Up`
  String get signup {
    return Intl.message(
      'Sign Up',
      name: 'signup',
      desc: 'Sign up button text',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: 'Settings menu item',
      args: [],
    );
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message(
      'Dark Mode',
      name: 'darkMode',
      desc: 'Dark mode toggle',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: 'Language selection option',
      args: [],
    );
  }

  /// `Detect deepfake videos with advanced AI technology`
  String get detectDeepfake {
    return Intl.message(
      'Detect deepfake videos with advanced AI technology',
      name: 'detectDeepfake',
      desc: 'Home page subtitle',
      args: [],
    );
  }

  /// `Upload Video`
  String get uploadVideo {
    return Intl.message(
      'Upload Video',
      name: 'uploadVideo',
      desc: 'Upload video button text',
      args: [],
    );
  }

  /// `Analyze`
  String get analyze {
    return Intl.message(
      'Analyze',
      name: 'analyze',
      desc: 'Analyze button text',
      args: [],
    );
  }

  /// `Upload Required`
  String get uploadRequired {
    return Intl.message(
      'Upload Required',
      name: 'uploadRequired',
      desc: 'Error message title when no video is uploaded',
      args: [],
    );
  }

  /// `Please upload a video first`
  String get pleaseUploadFirst {
    return Intl.message(
      'Please upload a video first',
      name: 'pleaseUploadFirst',
      desc: 'Error message content when no video is uploaded',
      args: [],
    );
  }

  /// `Your Video`
  String get yourVideo {
    return Intl.message(
      'Your Video',
      name: 'yourVideo',
      desc: 'Label for uploaded video',
      args: [],
    );
  }

  /// `Upload a video to begin`
  String get uploadToBegin {
    return Intl.message(
      'Upload a video to begin',
      name: 'uploadToBegin',
      desc: 'Empty state title',
      args: [],
    );
  }

  /// `Tap the Upload button below to select a video`
  String get tapUploadButton {
    return Intl.message(
      'Tap the Upload button below to select a video',
      name: 'tapUploadButton',
      desc: 'Empty state subtitle',
      args: [],
    );
  }

  /// `Analysis Results`
  String get analysisResults {
    return Intl.message(
      'Analysis Results',
      name: 'analysisResults',
      desc: 'Title for the results page',
      args: [],
    );
  }

  /// `Back to Homepage`
  String get backToHomepage {
    return Intl.message(
      'Back to Homepage',
      name: 'backToHomepage',
      desc: 'Button to return to homepage',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: 'Logout button text',
      args: [],
    );
  }

  /// `Are you sure you want to logout?`
  String get logoutConfirmation {
    return Intl.message(
      'Are you sure you want to logout?',
      name: 'logoutConfirmation',
      desc: 'Logout confirmation message',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: 'Cancel button text',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: 'Email field label',
      args: [],
    );
  }

  /// `Enter your email address`
  String get emailHint {
    return Intl.message(
      'Enter your email address',
      name: 'emailHint',
      desc: 'Email field hint text',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: 'Password field label',
      args: [],
    );
  }

  /// `Enter your password`
  String get passwordHint {
    return Intl.message(
      'Enter your password',
      name: 'passwordHint',
      desc: 'Password field hint text',
      args: [],
    );
  }

  /// `Forgot Password`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password',
      name: 'forgotPassword',
      desc: 'Forgot password button text',
      args: [],
    );
  }

  /// `OR`
  String get or {
    return Intl.message(
      'OR',
      name: 'or',
      desc: 'Divider text between login options',
      args: [],
    );
  }

  /// `Sign in with Google`
  String get loginWithGoogle {
    return Intl.message(
      'Sign in with Google',
      name: 'loginWithGoogle',
      desc: 'Google login button text',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get noAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'noAccount',
      desc: 'Text for users without an account',
      args: [],
    );
  }

  /// `Password Reset`
  String get passwordReset {
    return Intl.message(
      'Password Reset',
      name: 'passwordReset',
      desc: 'Password reset dialog title',
      args: [],
    );
  }

  /// `Enter your email for a password reset link`
  String get passwordResetInfo {
    return Intl.message(
      'Enter your email for a password reset link',
      name: 'passwordResetInfo',
      desc: 'Password reset dialog info',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: 'Send button text for password reset',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: 'Register page title',
      args: [],
    );
  }

  /// `Create Account`
  String get createAccount {
    return Intl.message(
      'Create Account',
      name: 'createAccount',
      desc: 'Create account heading',
      args: [],
    );
  }

  /// `Please enter your information`
  String get enterInfo {
    return Intl.message(
      'Please enter your information',
      name: 'enterInfo',
      desc: 'Registration form subtitle',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message(
      'Full Name',
      name: 'fullName',
      desc: 'Full name field label',
      args: [],
    );
  }

  /// `Enter your full name`
  String get fullNameHint {
    return Intl.message(
      'Enter your full name',
      name: 'fullNameHint',
      desc: 'Full name field hint',
      args: [],
    );
  }

  /// `Enter password (minimum 6 characters)`
  String get passwordHintRegister {
    return Intl.message(
      'Enter password (minimum 6 characters)',
      name: 'passwordHintRegister',
      desc: 'Password hint for registration',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: 'Confirm password field label',
      args: [],
    );
  }

  /// `Re-enter your password`
  String get confirmPasswordHint {
    return Intl.message(
      'Re-enter your password',
      name: 'confirmPasswordHint',
      desc: 'Confirm password field hint',
      args: [],
    );
  }

  /// `Already have an account?`
  String get haveAccount {
    return Intl.message(
      'Already have an account?',
      name: 'haveAccount',
      desc: 'Text for users with existing account',
      args: [],
    );
  }

  /// `This video is likely a deepfake with a probability of %{score}.`
  String deepfakeResult(String score) {
    return Intl.message(
      'This video is likely a deepfake with a probability of %$score.',
      name: 'deepfakeResult',
      desc: 'Result message for deepfake video',
      args: [score],
    );
  }

  /// `This video likely appears real with a probability of %{score}.`
  String realVideoResult(String score) {
    return Intl.message(
      'This video likely appears real with a probability of %$score.',
      name: 'realVideoResult',
      desc: 'Result message for real video',
      args: [score],
    );
  }

  /// `Deepfake Detected`
  String get deepfakeDetected {
    return Intl.message(
      'Deepfake Detected',
      name: 'deepfakeDetected',
      desc: 'Title for detected deepfake video',
      args: [],
    );
  }

  /// `Deepfake Video`
  String get deepfakeVideo {
    return Intl.message(
      'Deepfake Video',
      name: 'deepfakeVideo',
      desc: 'Title for detected deepfake video',
      args: [],
    );
  }

  /// `Authentic Video`
  String get authenticVideo {
    return Intl.message(
      'Authentic Video',
      name: 'authenticVideo',
      desc: 'Title for authentic video',
      args: [],
    );
  }

  /// `Confidence Score`
  String get confidenceScore {
    return Intl.message(
      'Confidence Score',
      name: 'confidenceScore',
      desc: 'Label for AI\'s confidence score',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: 'About section title in settings',
      args: [],
    );
  }

  /// `Appearance`
  String get appearance {
    return Intl.message(
      'Appearance',
      name: 'appearance',
      desc: 'Appearance section title in settings',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: 'Privacy policy link',
      args: [],
    );
  }

  /// `Terms of Service`
  String get termsOfService {
    return Intl.message(
      'Terms of Service',
      name: 'termsOfService',
      desc: 'Terms of service link',
      args: [],
    );
  }

  /// `Version`
  String get version {
    return Intl.message(
      'Version',
      name: 'version',
      desc: 'App version label',
      args: [],
    );
  }

  /// `Email Verification Required`
  String get emailVerificationRequired {
    return Intl.message(
      'Email Verification Required',
      name: 'emailVerificationRequired',
      desc: 'Email verification required title',
      args: [],
    );
  }

  /// `Please verify your email to access your account`
  String get pleaseVerifyEmail {
    return Intl.message(
      'Please verify your email to access your account',
      name: 'pleaseVerifyEmail',
      desc: 'Email verification message',
      args: [],
    );
  }

  /// `Resend Verification Email`
  String get resendVerificationEmail {
    return Intl.message(
      'Resend Verification Email',
      name: 'resendVerificationEmail',
      desc: 'Button to resend verification email',
      args: [],
    );
  }

  /// `Email Verification Sent`
  String get verificationEmailSent {
    return Intl.message(
      'Email Verification Sent',
      name: 'verificationEmailSent',
      desc: 'Verification email sent title',
      args: [],
    );
  }

  /// `We have sent a verification link to your email. Please check your inbox.`
  String get verificationEmailSentMessage {
    return Intl.message(
      'We have sent a verification link to your email. Please check your inbox.',
      name: 'verificationEmailSentMessage',
      desc: 'Verification email sent message',
      args: [],
    );
  }

  /// `Email field cannot be empty`
  String get emailFieldEmpty {
    return Intl.message(
      'Email field cannot be empty',
      name: 'emailFieldEmpty',
      desc: 'Email field empty validation message',
      args: [],
    );
  }

  /// `Please enter a valid email address`
  String get invalidEmail {
    return Intl.message(
      'Please enter a valid email address',
      name: 'invalidEmail',
      desc: 'Invalid email validation message',
      args: [],
    );
  }

  /// `Password field cannot be empty`
  String get passwordFieldEmpty {
    return Intl.message(
      'Password field cannot be empty',
      name: 'passwordFieldEmpty',
      desc: 'Password field empty validation message',
      args: [],
    );
  }

  /// `Password must be at least 6 characters`
  String get passwordMinLength {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'passwordMinLength',
      desc: 'Password minimum length validation message',
      args: [],
    );
  }

  /// `Full name field cannot be empty`
  String get nameFieldEmpty {
    return Intl.message(
      'Full name field cannot be empty',
      name: 'nameFieldEmpty',
      desc: 'Name field empty validation message',
      args: [],
    );
  }

  /// `Confirm password field cannot be empty`
  String get confirmPasswordEmpty {
    return Intl.message(
      'Confirm password field cannot be empty',
      name: 'confirmPasswordEmpty',
      desc: 'Confirm password field empty validation message',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordsDoNotMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordsDoNotMatch',
      desc: 'Passwords mismatch validation message',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message(
      'Success',
      name: 'success',
      desc: 'Success message title',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: 'Error message title',
      args: [],
    );
  }

  /// `Login successful`
  String get loginSuccessful {
    return Intl.message(
      'Login successful',
      name: 'loginSuccessful',
      desc: 'Login successful message',
      args: [],
    );
  }

  /// `An error occurred during registration`
  String get registrationError {
    return Intl.message(
      'An error occurred during registration',
      name: 'registrationError',
      desc: 'Registration error message',
      args: [],
    );
  }

  /// `An error occurred during login`
  String get loginError {
    return Intl.message(
      'An error occurred during login',
      name: 'loginError',
      desc: 'Login error message',
      args: [],
    );
  }

  /// `This email address is already in use`
  String get emailAlreadyInUse {
    return Intl.message(
      'This email address is already in use',
      name: 'emailAlreadyInUse',
      desc: 'Email already in use error message',
      args: [],
    );
  }

  /// `Password is too weak`
  String get weakPassword {
    return Intl.message(
      'Password is too weak',
      name: 'weakPassword',
      desc: 'Weak password error message',
      args: [],
    );
  }

  /// `Email/password registration is not enabled`
  String get operationNotAllowed {
    return Intl.message(
      'Email/password registration is not enabled',
      name: 'operationNotAllowed',
      desc: 'Operation not allowed error message',
      args: [],
    );
  }

  /// `No user found with this email`
  String get userNotFound {
    return Intl.message(
      'No user found with this email',
      name: 'userNotFound',
      desc: 'User not found error message',
      args: [],
    );
  }

  /// `Incorrect password`
  String get wrongPassword {
    return Intl.message(
      'Incorrect password',
      name: 'wrongPassword',
      desc: 'Wrong password error message',
      args: [],
    );
  }

  /// `This user has been disabled`
  String get userDisabled {
    return Intl.message(
      'This user has been disabled',
      name: 'userDisabled',
      desc: 'User disabled error message',
      args: [],
    );
  }

  /// `Password Reset Email Sent`
  String get passwordResetEmailSent {
    return Intl.message(
      'Password Reset Email Sent',
      name: 'passwordResetEmailSent',
      desc: 'Password reset email sent title',
      args: [],
    );
  }

  /// `Password reset link has been sent to {email}.\n\nPlease check your email and click the link to reset your password.`
  String passwordResetEmailSentMessage(String email) {
    return Intl.message(
      'Password reset link has been sent to $email.\n\nPlease check your email and click the link to reset your password.',
      name: 'passwordResetEmailSentMessage',
      desc: 'Password reset email sent message',
      args: [email],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: 'OK button text',
      args: [],
    );
  }

  /// `An error occurred during password reset`
  String get passwordResetError {
    return Intl.message(
      'An error occurred during password reset',
      name: 'passwordResetError',
      desc: 'Password reset error message',
      args: [],
    );
  }

  /// `Too many requests. Please try again later`
  String get tooManyRequests {
    return Intl.message(
      'Too many requests. Please try again later',
      name: 'tooManyRequests',
      desc: 'Too many requests error message',
      args: [],
    );
  }

  /// `Successfully signed in with Google account`
  String get googleLoginSuccess {
    return Intl.message(
      'Successfully signed in with Google account',
      name: 'googleLoginSuccess',
      desc: 'Google login success message',
      args: [],
    );
  }

  /// `An error occurred while signing in with Google`
  String get googleLoginError {
    return Intl.message(
      'An error occurred while signing in with Google',
      name: 'googleLoginError',
      desc: 'Google login error message',
      args: [],
    );
  }

  /// `An error occurred during logout`
  String get logoutError {
    return Intl.message(
      'An error occurred during logout',
      name: 'logoutError',
      desc: 'Logout error message',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: 'Profile page title',
      args: [],
    );
  }

  /// `First Name`
  String get firstName {
    return Intl.message(
      'First Name',
      name: 'firstName',
      desc: 'First name field label',
      args: [],
    );
  }

  /// `Last Name`
  String get lastName {
    return Intl.message(
      'Last Name',
      name: 'lastName',
      desc: 'Last name field label',
      args: [],
    );
  }

  /// `Age`
  String get age {
    return Intl.message(
      'Age',
      name: 'age',
      desc: 'Age field label',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: 'Save button text',
      args: [],
    );
  }

  /// `First name is required`
  String get firstNameRequired {
    return Intl.message(
      'First name is required',
      name: 'firstNameRequired',
      desc: 'First name required validation message',
      args: [],
    );
  }

  /// `Last name is required`
  String get lastNameRequired {
    return Intl.message(
      'Last name is required',
      name: 'lastNameRequired',
      desc: 'Last name required validation message',
      args: [],
    );
  }

  /// `Please enter a valid age (1-150)`
  String get invalidAge {
    return Intl.message(
      'Please enter a valid age (1-150)',
      name: 'invalidAge',
      desc: 'Invalid age validation message',
      args: [],
    );
  }

  /// `Profile updated successfully`
  String get profileUpdateSuccess {
    return Intl.message(
      'Profile updated successfully',
      name: 'profileUpdateSuccess',
      desc: 'Profile update success message',
      args: [],
    );
  }

  /// `Welcome back, {name}!`
  String welcomeBack(String name) {
    return Intl.message(
      'Welcome back, $name!',
      name: 'welcomeBack',
      desc: 'Welcome message with user\'s name',
      args: [name],
    );
  }

  /// `Personal Information`
  String get personalInformation {
    return Intl.message(
      'Personal Information',
      name: 'personalInformation',
      desc: 'Personal information section title',
      args: [],
    );
  }

  /// `Enter your first name`
  String get firstNameHint {
    return Intl.message(
      'Enter your first name',
      name: 'firstNameHint',
      desc: 'First name field hint',
      args: [],
    );
  }

  /// `Enter your last name`
  String get lastNameHint {
    return Intl.message(
      'Enter your last name',
      name: 'lastNameHint',
      desc: 'Last name field hint',
      args: [],
    );
  }

  /// `Enter your age (optional)`
  String get ageHint {
    return Intl.message(
      'Enter your age (optional)',
      name: 'ageHint',
      desc: 'Age field hint',
      args: [],
    );
  }

  /// `Analysis History`
  String get analysisHistory {
    return Intl.message(
      'Analysis History',
      name: 'analysisHistory',
      desc: 'Analysis history section title',
      args: [],
    );
  }

  /// `Loading history...`
  String get loadingHistory {
    return Intl.message(
      'Loading history...',
      name: 'loadingHistory',
      desc: 'Loading history message',
      args: [],
    );
  }

  /// `No analysis history yet`
  String get noAnalysisHistoryYet {
    return Intl.message(
      'No analysis history yet',
      name: 'noAnalysisHistoryYet',
      desc: 'Empty history state title',
      args: [],
    );
  }

  /// `Analyze a video to see your results here`
  String get analyzeVideoToSeeResults {
    return Intl.message(
      'Analyze a video to see your results here',
      name: 'analyzeVideoToSeeResults',
      desc: 'Empty history state message',
      args: [],
    );
  }

  /// `Delete Record`
  String get deleteRecord {
    return Intl.message(
      'Delete Record',
      name: 'deleteRecord',
      desc: 'Delete record dialog title',
      args: [],
    );
  }

  /// `Are you sure you want to delete "{title}"? This action cannot be undone.`
  String deleteRecordConfirmation(String title) {
    return Intl.message(
      'Are you sure you want to delete "$title"? This action cannot be undone.',
      name: 'deleteRecordConfirmation',
      desc: 'Delete record confirmation message',
      args: [title],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: 'Delete button text',
      args: [],
    );
  }

  /// `Record deleted successfully`
  String get recordDeletedSuccessfully {
    return Intl.message(
      'Record deleted successfully',
      name: 'recordDeletedSuccessfully',
      desc: 'Record deleted success message',
      args: [],
    );
  }

  /// `Failed to delete record: {error}`
  String failedToDeleteRecord(String error) {
    return Intl.message(
      'Failed to delete record: $error',
      name: 'failedToDeleteRecord',
      desc: 'Failed to delete record error message',
      args: [error],
    );
  }

  /// `Video Analysis - {filename}`
  String videoAnalysis(String filename) {
    return Intl.message(
      'Video Analysis - $filename',
      name: 'videoAnalysis',
      desc: 'Video analysis title with filename',
      args: [filename],
    );
  }

  /// `Deepfake detection analysis completed`
  String get deepfakeDetectionCompleted {
    return Intl.message(
      'Deepfake detection analysis completed',
      name: 'deepfakeDetectionCompleted',
      desc: 'Deepfake detection completed message',
      args: [],
    );
  }

  /// `Authentic video verification completed`
  String get authenticVideoVerificationCompleted {
    return Intl.message(
      'Authentic video verification completed',
      name: 'authenticVideoVerificationCompleted',
      desc: 'Authentic video verification completed message',
      args: [],
    );
  }

  /// `Real Video`
  String get realVideo {
    return Intl.message(
      'Real Video',
      name: 'realVideo',
      desc: 'Real video result',
      args: [],
    );
  }

  /// `View Full History`
  String get viewFullHistory {
    return Intl.message(
      'View Full History',
      name: 'viewFullHistory',
      desc: '',
      args: [],
    );
  }

  /// `Analyzing Video`
  String get analyzingVideo {
    return Intl.message(
      'Analyzing Video',
      name: 'analyzingVideo',
      desc: '',
      args: [],
    );
  }

  /// `Please wait while we analyze your video...`
  String get pleaseWait {
    return Intl.message(
      'Please wait while we analyze your video...',
      name: 'pleaseWait',
      desc: '',
      args: [],
    );
  }

  /// `User not authenticated`
  String get userNotAuthenticated {
    return Intl.message(
      'User not authenticated',
      name: 'userNotAuthenticated',
      desc: 'profile_controller.dart',
      args: [],
    );
  }

  /// `Failed to load profile: {error}`
  String failedToLoadProfile(Object error) {
    return Intl.message(
      'Failed to load profile: $error',
      name: 'failedToLoadProfile',
      desc: 'profile_controller.dart',
      args: [error],
    );
  }

  /// `Failed to create user profile: {error}`
  String failedToCreateProfile(Object error) {
    return Intl.message(
      'Failed to create user profile: $error',
      name: 'failedToCreateProfile',
      desc: 'profile_controller.dart',
      args: [error],
    );
  }

  /// `Failed to save profile: {error}`
  String failedToSaveProfile(Object error) {
    return Intl.message(
      'Failed to save profile: $error',
      name: 'failedToSaveProfile',
      desc: 'profile_controller.dart',
      args: [error],
    );
  }

  /// `Failed to load history: {error}`
  String failedToLoadHistory(Object error) {
    return Intl.message(
      'Failed to load history: $error',
      name: 'failedToLoadHistory',
      desc: 'profile_controller.dart',
      args: [error],
    );
  }

  /// `Failed to add record: {error}`
  String failedToAddRecord(Object error) {
    return Intl.message(
      'Failed to add record: $error',
      name: 'failedToAddRecord',
      desc: 'profile_controller.dart',
      args: [error],
    );
  }

  /// `Failed to update record: {error}`
  String failedToUpdateRecord(Object error) {
    return Intl.message(
      'Failed to update record: $error',
      name: 'failedToUpdateRecord',
      desc: 'profile_controller.dart',
      args: [error],
    );
  }

  /// `Invalid login credentials. Please check your email and password and try again.`
  String get invalidCredential {
    return Intl.message(
      'Invalid login credentials. Please check your email and password and try again.',
      name: 'invalidCredential',
      desc: 'Invalid credential error message',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'tr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
