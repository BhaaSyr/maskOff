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

  static String m1(score) =>
      "This video likely appears real with a probability of %${score}.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("About"),
        "analysisResults":
            MessageLookupByLibrary.simpleMessage("Analysis Results"),
        "analyze": MessageLookupByLibrary.simpleMessage("Analyze"),
        "appTitle": MessageLookupByLibrary.simpleMessage("Mask Off"),
        "appearance": MessageLookupByLibrary.simpleMessage("Appearance"),
        "authenticVideo":
            MessageLookupByLibrary.simpleMessage("Authentic Video"),
        "backToHomepage":
            MessageLookupByLibrary.simpleMessage("Back to Homepage"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "confidenceScore":
            MessageLookupByLibrary.simpleMessage("Confidence Score"),
        "confirmPassword":
            MessageLookupByLibrary.simpleMessage("Confirm Password"),
        "confirmPasswordHint":
            MessageLookupByLibrary.simpleMessage("Re-enter your password"),
        "createAccount": MessageLookupByLibrary.simpleMessage("Create Account"),
        "darkMode": MessageLookupByLibrary.simpleMessage("Dark Mode"),
        "deepfakeDetected":
            MessageLookupByLibrary.simpleMessage("Deepfake Detected"),
        "deepfakeResult": m0,
        "detectDeepfake": MessageLookupByLibrary.simpleMessage(
            "Detect deepfake videos with advanced AI technology"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "emailHint":
            MessageLookupByLibrary.simpleMessage("Enter your email address"),
        "enterInfo": MessageLookupByLibrary.simpleMessage(
            "Please enter your information"),
        "forgotPassword":
            MessageLookupByLibrary.simpleMessage("Forgot Password"),
        "fullName": MessageLookupByLibrary.simpleMessage("Full Name"),
        "fullNameHint":
            MessageLookupByLibrary.simpleMessage("Enter your full name"),
        "haveAccount":
            MessageLookupByLibrary.simpleMessage("Already have an account?"),
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "login": MessageLookupByLibrary.simpleMessage("Login"),
        "loginWithGoogle":
            MessageLookupByLibrary.simpleMessage("Sign in with Google"),
        "logout": MessageLookupByLibrary.simpleMessage("Logout"),
        "logoutConfirmation": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to logout?"),
        "noAccount":
            MessageLookupByLibrary.simpleMessage("Don\'t have an account?"),
        "or": MessageLookupByLibrary.simpleMessage("OR"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordHint":
            MessageLookupByLibrary.simpleMessage("Enter your password"),
        "passwordHintRegister": MessageLookupByLibrary.simpleMessage(
            "Enter password (minimum 6 characters)"),
        "passwordReset": MessageLookupByLibrary.simpleMessage("Password Reset"),
        "passwordResetInfo": MessageLookupByLibrary.simpleMessage(
            "Enter your email for a password reset link"),
        "pleaseUploadFirst":
            MessageLookupByLibrary.simpleMessage("Please upload a video first"),
        "privacyPolicy": MessageLookupByLibrary.simpleMessage("Privacy Policy"),
        "realVideoResult": m1,
        "register": MessageLookupByLibrary.simpleMessage("Register"),
        "send": MessageLookupByLibrary.simpleMessage("Send"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "signup": MessageLookupByLibrary.simpleMessage("Sign Up"),
        "tapUploadButton": MessageLookupByLibrary.simpleMessage(
            "Tap the Upload button below to select a video"),
        "termsOfService":
            MessageLookupByLibrary.simpleMessage("Terms of Service"),
        "uploadRequired":
            MessageLookupByLibrary.simpleMessage("Upload Required"),
        "uploadToBegin":
            MessageLookupByLibrary.simpleMessage("Upload a video to begin"),
        "uploadVideo": MessageLookupByLibrary.simpleMessage("Upload Video"),
        "version": MessageLookupByLibrary.simpleMessage("Version"),
        "welcome": MessageLookupByLibrary.simpleMessage("Welcome"),
        "yourVideo": MessageLookupByLibrary.simpleMessage("Your Video")
      };
}
