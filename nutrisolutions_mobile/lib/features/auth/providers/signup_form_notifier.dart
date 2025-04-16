import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../states/signup_form_state.dart';

class SignupFormNotifier extends StateNotifier<SignupFormState> {
  SignupFormNotifier() : super(SignupFormState());

  void updateEmail(String value) {
    state = state.copyWith(email: value);
  }

  void updatePassword(String value) {
    state = state.copyWith(password: value);
  }

  void togglePasswordVisibility() {
    state = state.copyWith(obscurePassword: !state.obscurePassword);
  }

  void toggleConfirmPasswordVisibility() {
    state =
        state.copyWith(obscureConfirmPassword: !state.obscureConfirmPassword);
  }

  void updateConfirmPassword(String value) {
    state = state.copyWith(confirmPassword: value);
  }

  void updateName(String value) {
    state = state.copyWith(name: value);
  }

  void updateGender(GenderEnum gender) {
    state = state.copyWith(gender: gender);
  }

  void updateAge(int value) {
    state = state.copyWith(age: value);
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

  void updateDailyActivity(DailyActivityEnum value) {
    state = state.copyWith(dailyActivity: value);
  }

  void updateGoal(GoalEnum value) {
    state = state.copyWith(goal: value);
  }

  void updateProfilePictureUrl(String value) {
    state = state.copyWith(profilePictureUrl: value);
  }

  void updateCurrentStep(int value) {
    state = state.copyWith(currentStep: value);
  }

  void animateToPage(int index) {
    state.pageController.animateToPage(index,
        duration: const Duration(milliseconds: 400), curve: Curves.linear);
    state = state.copyWith(currentStep: index.toInt());
  }
}

final signupFormProvider =
    StateNotifierProvider<SignupFormNotifier, SignupFormState>((ref) {
  return SignupFormNotifier();
});
