import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrisolutions_mobile/core/constants/app_constants.dart';
import 'package:nutrisolutions_mobile/core/utils/validators.dart';
import 'package:nutrisolutions_mobile/data/providers/image_upload_provider.dart';

import '../../../data/models/client_model.dart';
import '../../../data/providers/auth_provider.dart';
import '../states/signup_form_state.dart';

class SignupFormNotifier extends StateNotifier<SignupFormState> {
  final Ref ref;
  SignupFormNotifier(this.ref) : super(SignupFormState());

  void updateEmail(String value) {
    state = state.copyWith(email: value);
    final validationResult = AppValidators.validateEmail(value);
    state = state.copyWith(emailErrorMessage: validationResult);
  }

  void updatePassword(String value) {
    state = state.copyWith(password: value);
    final validationResult = AppValidators.validatePassword(value);
    final passwordStrengthLevel = AppValidators.validatePasswordStrength(value);
    state = state.copyWith(
        passwordErrorMessage: validationResult,
        passwordStrengthLevel: passwordStrengthLevel);
  }

  void updateConfirmPassword(String value) {
    state = state.copyWith(confirmPassword: value);
    final validationResult =
        AppValidators.validateConfirmPassword(state.password, value);
    state = state.copyWith(confirmPasswordErrorMessage: validationResult);
  }

  void togglePasswordVisibility() {
    state = state.copyWith(obscurePassword: !state.obscurePassword);
  }

  void toggleConfirmPasswordVisibility() {
    state =
        state.copyWith(obscureConfirmPassword: !state.obscureConfirmPassword);
  }

  void updateName(String value) {
    state = state.copyWith(name: value);
  }

  void updateGender(String gender) {
    state = state.copyWith(gender: gender);
  }

  void updateBirthdate(DateTime picked) async {
    if (picked != state.birthDate) {
      state = state.copyWith(birthDate: picked);
    }
  }

  void updatePhoneNumber(String value) {
    state = state.copyWith(phoneNumber: value);
  }

  void updateCurrentWeight(int value) {
    state = state.copyWith(currentWeight: value);
  }

  void updateCurrentHeight(int value) {
    state = state.copyWith(currentHeight: value);
  }

  void updateDailyActivity(String value) {
    state = state.copyWith(dailyActivity: value);
  }

  void updateGoal(String value) {
    state = state.copyWith(goal: value);
  }

  // void updateProfilePictureUrl(String value) {
  //   state = state.copyWith(profilePictureUrl: value);
  // }

  void updateProfilePicture(File value) {
    state = state.copyWith(profilePicture: value);
  }

  void updateCurrentStep(int value) {
    state = state.copyWith(currentStep: value);
  }

  void animateToPage(int index) {
    state.pageController.animateToPage(index,
        duration: const Duration(milliseconds: 400), curve: Curves.linear);
    state = state.copyWith(currentStep: index.toInt());
  }

  bool validateAccountInformation() {
    return (state.email.isNotEmpty &&
        state.password.isNotEmpty &&
        (state.emailErrorMessage == AppConstants.valid) &&
        (state.confirmPasswordErrorMessage == AppConstants.valid) &&
        (state.passwordErrorMessage == AppConstants.valid));
  }

  bool validateProfileData() {
    return (state.name.isNotEmpty && state.phoneNumber.isNotEmpty);
  }

  bool validateProfilePicture() {
    return (state.profilePicture != null);
  }

  Future<String> uploadImage() async {
    try {
      final imageUploadService = ref.read(imageUploadServiceProvider);
      final result =
          await imageUploadService.uploadImage(state.profilePicture!);
      return result.path;
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }

  Future<bool> submitSignup() async {
    try {
      final authService = ref.read(authServiceProvider);
      final profilePictureUrl = await uploadImage();
      final client = state.toClientModel(profilePictureUrl);
      await authService.signup(client);
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      print('Error during signup: $e');
      state = state.copyWith(isLoading: false);
      return false;
    }
  }
}

final signupFormProvider =
    StateNotifierProvider<SignupFormNotifier, SignupFormState>((ref) {
  return SignupFormNotifier(ref);
});
