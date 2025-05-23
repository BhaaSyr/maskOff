import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testvid/data/models/user_model.dart';
import 'package:testvid/generated/l10n.dart';

class ProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Text controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final ageController = TextEditingController();

  // Observable variables
  final userModel = Rx<UserModel?>(null);
  final isLoading = false.obs;
  final isSaving = false.obs;

  // Form errors
  final firstNameError = ''.obs;
  final lastNameError = ''.obs;
  final ageError = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
    _setupErrorClearingListeners();
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    ageController.dispose();
    super.onClose();
  }

  void _setupErrorClearingListeners() {
    firstNameController.addListener(() {
      if (firstNameError.value.isNotEmpty) {
        firstNameError.value = '';
      }
    });

    lastNameController.addListener(() {
      if (lastNameError.value.isNotEmpty) {
        lastNameError.value = '';
      }
    });

    ageController.addListener(() {
      if (ageError.value.isNotEmpty) {
        ageError.value = '';
      }
    });
  }

  // Load user profile from Firestore
  Future<void> loadUserProfile() async {
    final user = _auth.currentUser;
    if (user == null) {
      final context = Get.context;
      if (context != null) {
        _showErrorSnackbar(S.of(context).error, 'User not authenticated');
      }
      return;
    }

    try {
      isLoading.value = true;

      final docSnapshot =
          await _firestore.collection('users').doc(user.uid).get();

      if (docSnapshot.exists) {
        // User exists in Firestore
        final data = docSnapshot.data();
        if (data != null) {
          userModel.value = UserModel.fromMap(data);
          _populateControllers();
        }
      } else {
        // Create empty user document for first time use
        await _createEmptyUserDocument(user);
      }
    } catch (e) {
      final context = Get.context;
      if (context != null) {
        _showErrorSnackbar(
            S.of(context).error, 'Failed to load profile: ${e.toString()}');
      }
    } finally {
      isLoading.value = false;
    }
  }

  // Create empty user document for first time users
  Future<void> _createEmptyUserDocument(User user) async {
    try {
      final now = DateTime.now();
      final emptyUser = UserModel(
        uid: user.uid,
        email: user.email ?? '',
        firstName: null,
        lastName: null,
        age: null,
        createdAt: now,
        updatedAt: now,
      );

      userModel.value = emptyUser;
      _populateControllers();
    } catch (e) {
      final context = Get.context;
      if (context != null) {
        _showErrorSnackbar(S.of(context).error,
            'Failed to create user profile: ${e.toString()}');
      }
    }
  }

  // Populate controllers with user data
  void _populateControllers() {
    final currentUser = userModel.value;
    if (currentUser != null) {
      firstNameController.text = currentUser.firstName ?? '';
      lastNameController.text = currentUser.lastName ?? '';
      ageController.text = currentUser.age?.toString() ?? '';
    }
  }

  // Validate form
  bool _validateForm() {
    bool isValid = true;
    final context = Get.context;
    if (context == null) return false;

    // First name validation
    if (firstNameController.text.trim().isEmpty) {
      firstNameError.value = S.of(context).firstNameRequired;
      isValid = false;
    }

    // Last name validation
    if (lastNameController.text.trim().isEmpty) {
      lastNameError.value = S.of(context).lastNameRequired;
      isValid = false;
    }

    // Age validation
    if (ageController.text.trim().isNotEmpty) {
      final age = int.tryParse(ageController.text.trim());
      if (age == null || age < 1 || age > 150) {
        ageError.value = S.of(context).invalidAge;
        isValid = false;
      }
    }

    return isValid;
  }

  // Save profile to Firestore
  Future<void> saveProfile() async {
    if (!_validateForm()) return;

    final user = _auth.currentUser;
    if (user == null) {
      final context = Get.context;
      if (context != null) {
        _showErrorSnackbar(S.of(context).error, 'User not authenticated');
      }
      return;
    }

    final context = Get.context;
    if (context == null) return;

    try {
      isSaving.value = true;

      final now = DateTime.now();
      final age = ageController.text.trim().isNotEmpty
          ? int.tryParse(ageController.text.trim())
          : null;

      final updatedUser = UserModel(
        uid: user.uid,
        email: user.email ?? '',
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        age: age,
        createdAt: userModel.value?.createdAt ?? now,
        updatedAt: now,
      );

      // Update Firestore
      await _firestore
          .collection('users')
          .doc(user.uid)
          .set(updatedUser.toMap(), SetOptions(merge: true));

      // Update Firebase Auth display name
      await user.updateDisplayName(updatedUser.fullName);

      userModel.value = updatedUser;

      _showSuccessSnackbar(
          S.of(context).success, S.of(context).profileUpdateSuccess);

      // Go back to previous screen
      Get.back();
    } catch (e) {
      _showErrorSnackbar(
          S.of(context).error, 'Failed to save profile: ${e.toString()}');
    } finally {
      isSaving.value = false;
    }
  }

  // Helper methods for showing snackbars
  void _showSuccessSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
    );
  }

  void _showErrorSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
    );
  }
}
