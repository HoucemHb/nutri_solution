// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';

class SignupFormState {
  final String email;
  final String password;
  final bool obscurePassword;
  final String confirmPassword;
  final bool obscureConfirmPassword;
  final String name;
  final String gender;
  final int age;
  final String phoneNumber;
  final int currentWeight;
  final int currentHeight;
  final String dailyActivity;
  final String goal;
  // final String profilePictureUrl;
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
    this.emailErrorMessage,
    this.passwordErrorMessage,
    this.passwordStrengthLevel,
    this.confirmPasswordErrorMessage,
    this.obscurePassword = true,
    this.confirmPassword = '',
    this.obscureConfirmPassword = true,
    this.name = '',
    this.gender = 'Male',
    this.age = 18,
    this.phoneNumber = '',
    this.currentWeight = 150,
    this.currentHeight = 150,
    this.dailyActivity = 'Sedentary',
    this.goal = 'Lose Weight',
    this.profilePicture,
    this.currentStep = 0,
  }) : pageController = pageController ?? PageController();

  SignupFormState copyWith({
    String? email,
    String? password,
    String? emailErrorMessage,
    String? passwordErrorMessage,
    String? passwordStrengthLevel,
    String? confirmPasswordErrorMessage,
    bool? obscurePassword,
    String? confirmPassword,
    bool? obscureConfirmPassword,
    String? name,
    String? gender,
    int? age,
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
      emailErrorMessage: emailErrorMessage ?? this.emailErrorMessage,
      passwordErrorMessage: passwordErrorMessage ?? this.passwordErrorMessage,
      passwordStrengthLevel:
          passwordStrengthLevel ?? this.passwordStrengthLevel,
      password: password ?? this.password,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      obscureConfirmPassword:
          obscureConfirmPassword ?? this.obscureConfirmPassword,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      currentWeight: currentWeight ?? this.currentWeight,
      currentHeight: currentHeight ?? this.currentHeight,
      dailyActivity: dailyActivity ?? this.dailyActivity,
      goal: goal ?? this.goal,
      profilePicture: profilePicture ?? this.profilePicture,
      currentStep: currentStep ?? this.currentStep,
      pageController: pageController ?? this.pageController,
      confirmPasswordErrorMessage:
          confirmPasswordErrorMessage ?? this.confirmPasswordErrorMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'obscurePassword': obscurePassword,
      'confirmPassword': confirmPassword,
      'obscureConfirmPassword': obscureConfirmPassword,
      'name': name,
      'gender': gender,
      'age': age,
      'phoneNumber': phoneNumber,
      'currentWeight': currentWeight,
      'currentHeight': currentHeight,
      'dailyActivity': dailyActivity,
      'goal': goal,
      'currentStep': currentStep,
    };
  }

  factory SignupFormState.fromMap(Map<String, dynamic> map) {
    return SignupFormState(
      email: map['email'] as String,
      password: map['password'] as String,
      obscurePassword: map['obscurePassword'] as bool,
      confirmPassword: map['confirmPassword'] as String,
      obscureConfirmPassword: map['obscureConfirmPassword'] as bool,
      name: map['name'] as String,
      gender: map['gender'] as String,
      age: map['age'] as int,
      phoneNumber: map['phoneNumber'] as String,
      currentWeight: map['currentWeight'] as int,
      currentHeight: map['currentHeight'] as int,
      dailyActivity: map['dailyActivity'] as String,
      goal: map['goal'] as String,
      currentStep: map['currentStep'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignupFormState.fromJson(String source) =>
      SignupFormState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SignupFormState(email: $email, password: $password, obscurePassword: $obscurePassword, confirmPassword: $confirmPassword, obscureConfirmPassword: $obscureConfirmPassword, name: $name, gender: $gender, age: $age, phoneNumber: $phoneNumber, currentWeight: $currentWeight, currentHeight: $currentHeight, dailyActivity: $dailyActivity, goal: $goal, profilePicture: $profilePicture, currentStep: $currentStep, pageController: $pageController)';
  }

  @override
  bool operator ==(covariant SignupFormState other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.password == password &&
        other.obscurePassword == obscurePassword &&
        other.confirmPassword == confirmPassword &&
        other.obscureConfirmPassword == obscureConfirmPassword &&
        other.name == name &&
        other.gender == gender &&
        other.age == age &&
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
        obscurePassword.hashCode ^
        confirmPassword.hashCode ^
        obscureConfirmPassword.hashCode ^
        name.hashCode ^
        gender.hashCode ^
        age.hashCode ^
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

