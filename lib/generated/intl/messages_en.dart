// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(score) =>
      "This video is likely a deepfake with a probability of %${score}.";

  static String m1(title) =>
      "Are you sure you want to delete \"${title}\"? This action cannot be undone.";

  static String m2(error) => "Failed to add record: ${error}";

  static String m3(error) => "Failed to create user profile: ${error}";

  static String m4(error) => "Failed to delete record: ${error}";

  static String m5(error) => "Failed to load history: ${error}";

  static String m6(error) => "Failed to load profile: ${error}";

  static String m7(error) => "Failed to save profile: ${error}";

  static String m8(error) => "Failed to update record: ${error}";

  static String m9(email) =>
      "Password reset link has been sent to ${email}.\n\nPlease check your email and click the link to reset your password.";

  static String m10(score) =>
      "This video likely appears real with a probability of %${score}.";

  static String m11(filename) => "Video Analysis - ${filename}";

  static String m12(name) => "Welcome back, ${name}!";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("About"),
        "age": MessageLookupByLibrary.simpleMessage("Age"),
        "ageHint":
            MessageLookupByLibrary.simpleMessage("Enter your age (optional)"),
        "analysisHistory":
            MessageLookupByLibrary.simpleMessage("Analysis History"),
        "analysisResults":
            MessageLookupByLibrary.simpleMessage("Analysis Results"),
        "analyze": MessageLookupByLibrary.simpleMessage("Analyze"),
        "analyzeVideoToSeeResults": MessageLookupByLibrary.simpleMessage(
            "Analyze a video to see your results here"),
        "analyzingVideo":
            MessageLookupByLibrary.simpleMessage("Analyzing Video"),
        "appTitle": MessageLookupByLibrary.simpleMessage("Mask Off"),
        "appearance": MessageLookupByLibrary.simpleMessage("Appearance"),
        "authenticVideo":
            MessageLookupByLibrary.simpleMessage("Authentic Video"),
        "authenticVideoVerificationCompleted":
            MessageLookupByLibrary.simpleMessage(
                "Authentic video verification completed"),
        "backToHomepage":
            MessageLookupByLibrary.simpleMessage("Back to Homepage"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "confidenceScore":
            MessageLookupByLibrary.simpleMessage("Confidence Score"),
        "confirmPassword":
            MessageLookupByLibrary.simpleMessage("Confirm Password"),
        "confirmPasswordEmpty": MessageLookupByLibrary.simpleMessage(
            "Confirm password field cannot be empty"),
        "confirmPasswordHint":
            MessageLookupByLibrary.simpleMessage("Re-enter your password"),
        "createAccount": MessageLookupByLibrary.simpleMessage("Create Account"),
        "darkMode": MessageLookupByLibrary.simpleMessage("Dark Mode"),
        "deepfakeDetected":
            MessageLookupByLibrary.simpleMessage("Deepfake Detected"),
        "deepfakeDetectionCompleted": MessageLookupByLibrary.simpleMessage(
            "Deepfake detection analysis completed"),
        "deepfakeResult": m0,
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "deleteRecord": MessageLookupByLibrary.simpleMessage("Delete Record"),
        "deleteRecordConfirmation": m1,
        "detectDeepfake": MessageLookupByLibrary.simpleMessage(
            "Detect deepfake videos with advanced AI technology"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "emailAlreadyInUse": MessageLookupByLibrary.simpleMessage(
            "This email address is already in use"),
        "emailFieldEmpty":
            MessageLookupByLibrary.simpleMessage("Email field cannot be empty"),
        "emailHint":
            MessageLookupByLibrary.simpleMessage("Enter your email address"),
        "emailVerificationRequired":
            MessageLookupByLibrary.simpleMessage("Email Verification Required"),
        "enterInfo": MessageLookupByLibrary.simpleMessage(
            "Please enter your information"),
        "error": MessageLookupByLibrary.simpleMessage("Error"),
        "failedToAddRecord": m2,
        "failedToCreateProfile": m3,
        "failedToDeleteRecord": m4,
        "failedToLoadHistory": m5,
        "failedToLoadProfile": m6,
        "failedToSaveProfile": m7,
        "failedToUpdateRecord": m8,
        "firstName": MessageLookupByLibrary.simpleMessage("First Name"),
        "firstNameHint":
            MessageLookupByLibrary.simpleMessage("Enter your first name"),
        "firstNameRequired":
            MessageLookupByLibrary.simpleMessage("First name is required"),
        "forgotPassword":
            MessageLookupByLibrary.simpleMessage("Forgot Password"),
        "fullName": MessageLookupByLibrary.simpleMessage("Full Name"),
        "fullNameHint":
            MessageLookupByLibrary.simpleMessage("Enter your full name"),
        "googleLoginError": MessageLookupByLibrary.simpleMessage(
            "An error occurred while signing in with Google"),
        "googleLoginSuccess": MessageLookupByLibrary.simpleMessage(
            "Successfully signed in with Google account"),
        "haveAccount":
            MessageLookupByLibrary.simpleMessage("Already have an account?"),
        "invalidAge": MessageLookupByLibrary.simpleMessage(
            "Please enter a valid age (1-150)"),
        "invalidCredential": MessageLookupByLibrary.simpleMessage(
            "Invalid login credentials. Please check your email and password and try again."),
        "invalidEmail": MessageLookupByLibrary.simpleMessage(
            "Please enter a valid email address"),
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "lastName": MessageLookupByLibrary.simpleMessage("Last Name"),
        "lastNameHint":
            MessageLookupByLibrary.simpleMessage("Enter your last name"),
        "lastNameRequired":
            MessageLookupByLibrary.simpleMessage("Last name is required"),
        "loadingHistory":
            MessageLookupByLibrary.simpleMessage("Loading history..."),
        "login": MessageLookupByLibrary.simpleMessage("Login"),
        "loginError": MessageLookupByLibrary.simpleMessage(
            "An error occurred during login"),
        "loginSuccessful":
            MessageLookupByLibrary.simpleMessage("Login successful"),
        "loginWithGoogle":
            MessageLookupByLibrary.simpleMessage("Sign in with Google"),
        "logout": MessageLookupByLibrary.simpleMessage("Logout"),
        "logoutConfirmation": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to logout?"),
        "logoutError": MessageLookupByLibrary.simpleMessage(
            "An error occurred during logout"),
        "nameFieldEmpty": MessageLookupByLibrary.simpleMessage(
            "Full name field cannot be empty"),
        "noAccount":
            MessageLookupByLibrary.simpleMessage("Don\'t have an account?"),
        "noAnalysisHistoryYet":
            MessageLookupByLibrary.simpleMessage("No analysis history yet"),
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "operationNotAllowed": MessageLookupByLibrary.simpleMessage(
            "Email/password registration is not enabled"),
        "or": MessageLookupByLibrary.simpleMessage("OR"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordFieldEmpty": MessageLookupByLibrary.simpleMessage(
            "Password field cannot be empty"),
        "passwordHint":
            MessageLookupByLibrary.simpleMessage("Enter your password"),
        "passwordHintRegister": MessageLookupByLibrary.simpleMessage(
            "Enter password (minimum 6 characters)"),
        "passwordMinLength": MessageLookupByLibrary.simpleMessage(
            "Password must be at least 6 characters"),
        "passwordReset": MessageLookupByLibrary.simpleMessage("Password Reset"),
        "passwordResetEmailSent":
            MessageLookupByLibrary.simpleMessage("Password Reset Email Sent"),
        "passwordResetEmailSentMessage": m9,
        "passwordResetError": MessageLookupByLibrary.simpleMessage(
            "An error occurred during password reset"),
        "passwordResetInfo": MessageLookupByLibrary.simpleMessage(
            "Enter your email for a password reset link"),
        "passwordsDoNotMatch":
            MessageLookupByLibrary.simpleMessage("Passwords do not match"),
        "personalInformation":
            MessageLookupByLibrary.simpleMessage("Personal Information"),
        "pleaseUploadFirst":
            MessageLookupByLibrary.simpleMessage("Please upload a video first"),
        "pleaseVerifyEmail": MessageLookupByLibrary.simpleMessage(
            "Please verify your email to access your account"),
        "pleaseWait": MessageLookupByLibrary.simpleMessage(
            "Please wait while we analyze your video..."),
        "privacyPolicy": MessageLookupByLibrary.simpleMessage("Privacy Policy"),
        "profile": MessageLookupByLibrary.simpleMessage("Profile"),
        "profileUpdateSuccess": MessageLookupByLibrary.simpleMessage(
            "Profile updated successfully"),
        "realVideo": MessageLookupByLibrary.simpleMessage("Real Video"),
        "realVideoResult": m10,
        "recordDeletedSuccessfully":
            MessageLookupByLibrary.simpleMessage("Record deleted successfully"),
        "register": MessageLookupByLibrary.simpleMessage("Register"),
        "registrationError": MessageLookupByLibrary.simpleMessage(
            "An error occurred during registration"),
        "resendVerificationEmail":
            MessageLookupByLibrary.simpleMessage("Resend Verification Email"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "send": MessageLookupByLibrary.simpleMessage("Send"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "signup": MessageLookupByLibrary.simpleMessage("Sign Up"),
        "success": MessageLookupByLibrary.simpleMessage("Success"),
        "tapUploadButton": MessageLookupByLibrary.simpleMessage(
            "Tap the Upload button below to select a video"),
        "termsOfService":
            MessageLookupByLibrary.simpleMessage("Terms of Service"),
        "tooManyRequests": MessageLookupByLibrary.simpleMessage(
            "Too many requests. Please try again later"),
        "uploadRequired":
            MessageLookupByLibrary.simpleMessage("Upload Required"),
        "uploadToBegin":
            MessageLookupByLibrary.simpleMessage("Upload a video to begin"),
        "uploadVideo": MessageLookupByLibrary.simpleMessage("Upload Video"),
        "userDisabled":
            MessageLookupByLibrary.simpleMessage("This user has been disabled"),
        "userNotAuthenticated":
            MessageLookupByLibrary.simpleMessage("User not authenticated"),
        "userNotFound": MessageLookupByLibrary.simpleMessage(
            "No user found with this email"),
        "verificationEmailSent":
            MessageLookupByLibrary.simpleMessage("Email Verification Sent"),
        "verificationEmailSentMessage": MessageLookupByLibrary.simpleMessage(
            "We have sent a verification link to your email. Please check your inbox."),
        "version": MessageLookupByLibrary.simpleMessage("Version"),
        "videoAnalysis": m11,
        "viewFullHistory":
            MessageLookupByLibrary.simpleMessage("View Full History"),
        "weakPassword":
            MessageLookupByLibrary.simpleMessage("Password is too weak"),
        "welcome": MessageLookupByLibrary.simpleMessage("Welcome"),
        "welcomeBack": m12,
        "wrongPassword":
            MessageLookupByLibrary.simpleMessage("Incorrect password"),
        "yourVideo": MessageLookupByLibrary.simpleMessage("Your Video")
      };
}
