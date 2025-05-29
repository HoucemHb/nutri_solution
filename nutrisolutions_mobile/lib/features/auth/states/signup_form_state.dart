// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import '../../../data/models/client_model.dart';

class SignupFormState {
  final String email;
  final String password;
  final bool obscurePassword;
  final bool isLoading;
  final String confirmPassword;
  final bool obscureConfirmPassword;
  final String name;
  final String gender;
  final DateTime? birthDate;
  final String phoneNumber;
  final int currentWeight;
  final int currentHeight;
  final String dailyActivity;
  final String goal;
  final File? profilePicture;
  final int currentStep;
  final PageController pageController;
  final String? emailErrorMessage;
  final String? passwordErrorMessage;
  final String? passwordStrengthLevel;
  final String? confirmPasswordErrorMessage;

  SignupFormState({
    PageController? pageController,
    this.email = '',
    this.password = '',
    this.isLoading = false,
    this.emailErrorMessage,
    this.passwordErrorMessage,
    this.passwordStrengthLevel,
    this.confirmPasswordErrorMessage,
    DateTime? birthDate,
    this.obscurePassword = true,
    this.confirmPassword = '',
    this.obscureConfirmPassword = true,
    this.name = '',
    this.gender = 'homme',
    this.phoneNumber = '',
    this.currentWeight = 150,
    this.currentHeight = 150,
    this.dailyActivity = 'Sédentaire',
    this.goal = 'Perdre du poids',
    this.profilePicture,
    this.currentStep = 0,
  })  : pageController = pageController ?? PageController(),
        birthDate = birthDate ?? DateTime.now();

  SignupFormState copyWith({
    String? email,
    String? password,
    bool? isLoading,
    String? emailErrorMessage,
    String? passwordErrorMessage,
    String? passwordStrengthLevel,
    String? confirmPasswordErrorMessage,
    DateTime? birthDate,
    bool? obscurePassword,
    String? confirmPassword,
    bool? obscureConfirmPassword,
    String? name,
    String? gender,
    String? phoneNumber,
    int? currentWeight,
    int? currentHeight,
    String? dailyActivity,
    String? goal,
    File? profilePicture,
    int? currentStep,
    PageController? pageController,
  }) {
    return SignupFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      emailErrorMessage: emailErrorMessage ?? this.emailErrorMessage,
      passwordErrorMessage: passwordErrorMessage ?? this.passwordErrorMessage,
      passwordStrengthLevel:
          passwordStrengthLevel ?? this.passwordStrengthLevel,
      confirmPasswordErrorMessage:
          confirmPasswordErrorMessage ?? this.confirmPasswordErrorMessage,
      birthDate: birthDate ?? this.birthDate,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      obscureConfirmPassword:
          obscureConfirmPassword ?? this.obscureConfirmPassword,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      currentWeight: currentWeight ?? this.currentWeight,
      currentHeight: currentHeight ?? this.currentHeight,
      dailyActivity: dailyActivity ?? this.dailyActivity,
      goal: goal ?? this.goal,
      profilePicture: profilePicture ?? this.profilePicture,
      currentStep: currentStep ?? this.currentStep,
      pageController: pageController ?? this.pageController,
    );
  }

  factory SignupFormState.fromMap(Map<String, dynamic> map) {
    return SignupFormState(
      email: map['email'] as String,
      password: map['password'] as String,
      isLoading: map['isLoading'] as bool? ?? false,
      obscurePassword: map['obscurePassword'] as bool,
      confirmPassword: map['confirmPassword'] as String,
      obscureConfirmPassword: map['obscureConfirmPassword'] as bool,
      name: map['name'] as String,
      gender: map['gender'] as String,
      phoneNumber: map['phoneNumber'] as String,
      currentWeight: map['currentWeight'] as int,
      currentHeight: map['currentHeight'] as int,
      dailyActivity: map['dailyActivity'] as String,
      goal: map['goal'] as String,
      currentStep: map['currentStep'] as int,
      birthDate: DateTime.parse(map['birthDate'] as String),
    );
  }

  ClientModel toClientModel(String imageUrl) {
    return ClientModel(
        name: name,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
        profilePictureUrl: imageUrl,
        gender: gender,
        birthDate: birthDate!,
        height: currentHeight,
        weight: currentWeight,
        objectif: goal,
        activityLevel: dailyActivity);
  }

  // String toJson() => json.encode(toMap());

  factory SignupFormState.fromJson(String source) =>
      SignupFormState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SignupFormState(email: $email, password: $password, isLoading: $isLoading, obscurePassword: $obscurePassword, confirmPassword: $confirmPassword, obscureConfirmPassword: $obscureConfirmPassword, name: $name, gender: $gender, birthDate: $birthDate, phoneNumber: $phoneNumber, currentWeight: $currentWeight, currentHeight: $currentHeight, dailyActivity: $dailyActivity, goal: $goal, profilePicture: $profilePicture, currentStep: $currentStep, pageController: $pageController)';
  }

  @override
  bool operator ==(covariant SignupFormState other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.password == password &&
        other.isLoading == isLoading &&
        other.obscurePassword == obscurePassword &&
        other.confirmPassword == confirmPassword &&
        other.obscureConfirmPassword == obscureConfirmPassword &&
        other.name == name &&
        other.gender == gender &&
        other.birthDate == birthDate &&
        other.phoneNumber == phoneNumber &&
        other.currentWeight == currentWeight &&
        other.currentHeight == currentHeight &&
        other.dailyActivity == dailyActivity &&
        other.goal == goal &&
        other.profilePicture == profilePicture &&
        other.currentStep == currentStep &&
        other.pageController == pageController;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        password.hashCode ^
        isLoading.hashCode ^
        obscurePassword.hashCode ^
        confirmPassword.hashCode ^
        obscureConfirmPassword.hashCode ^
        name.hashCode ^
        gender.hashCode ^
        birthDate.hashCode ^
        phoneNumber.hashCode ^
        currentWeight.hashCode ^
        currentHeight.hashCode ^
        dailyActivity.hashCode ^
        goal.hashCode ^
        profilePicture.hashCode ^
        currentStep.hashCode ^
        pageController.hashCode;
  }
}
