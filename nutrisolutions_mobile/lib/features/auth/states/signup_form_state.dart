// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SignupFormState {
  final String email;
  final String password;
  final bool obscurePassword;
  final String confirmPassword;
  final bool obscureConfirmPassword;
  final String name;
  final GenderEnum gender;
  final int age;
  final String phoneNumber;
  final int currentWeight;
  final int currentHeight;
  final DailyActivityEnum dailyActivity;
  final GoalEnum goal;
  final String profilePictureUrl;
  final int currentStep;
  const SignupFormState({
    this.email = '',
    this.password = '',
    this.obscurePassword = true,
    this.confirmPassword = '',
    this.obscureConfirmPassword = true,
    this.name = '',
    this.gender = GenderEnum.male,
    this.age = 18,
    this.phoneNumber = '',
    this.currentWeight = 150,
    this.currentHeight = 150,
    this.dailyActivity = DailyActivityEnum.sedentary,
    this.goal = GoalEnum.looseWeight,
    this.profilePictureUrl = '',
    this.currentStep = 0,
  });

  SignupFormState copyWith({
    String? email,
    String? password,
    bool? obscurePassword,
    bool? obscureConfirmPassword,
    String? confirmPassword,
    String? name,
    GenderEnum? gender,
    int? age,
    String? phoneNumber,
    int? currentWeight,
    int? currentHeight,
    DailyActivityEnum? dailyActivity,
    GoalEnum? goal,
    String? profilePictureUrl,
    int? currentStep,
  }) {
    return SignupFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword:
          obscureConfirmPassword ?? this.obscureConfirmPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      currentWeight: currentWeight ?? this.currentWeight,
      currentHeight: currentHeight ?? this.currentHeight,
      dailyActivity: dailyActivity ?? this.dailyActivity,
      goal: goal ?? this.goal,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      currentStep: currentStep ?? this.currentStep,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'name': name,
      'gender': gender,
      'age': age,
      'phoneNumber': phoneNumber,
      'currentWeight': currentWeight,
      'currentHeight': currentHeight,
      'dailyActivity': dailyActivity,
      'goal': goal,
      'profilePictureUrl': profilePictureUrl,
      'currentStep': currentStep,
    };
  }

  factory SignupFormState.fromMap(Map<String, dynamic> map) {
    return SignupFormState(
      email: map['email'] as String,
      password: map['password'] as String,
      confirmPassword: map['confirmPassword'] as String,
      name: map['name'] as String,
      gender: map['gender'] as GenderEnum,
      age: map['age'] as int,
      phoneNumber: map['phoneNumber'] as String,
      currentWeight: map['currentWeight'] as int,
      currentHeight: map['currentHeight'] as int,
      dailyActivity: map['dailyActivity'] as DailyActivityEnum,
      goal: map['goal'] as GoalEnum,
      profilePictureUrl: map['profilePictureUrl'] as String,
      currentStep: map['currentStep'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignupFormState.fromJson(String source) =>
      SignupFormState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SignupFormState(email: $email, password: $password, confirmPassword: $confirmPassword, name: $name, gender: $gender, age: $age, phoneNumber: $phoneNumber, currentWeight: $currentWeight, currentHeight: $currentHeight, dailyActivity: $dailyActivity, goal: $goal, profilePictureUrl: $profilePictureUrl, currentStep: $currentStep)';
  }

  @override
  bool operator ==(covariant SignupFormState other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.password == password &&
        other.confirmPassword == confirmPassword &&
        other.name == name &&
        other.gender == gender &&
        other.age == age &&
        other.phoneNumber == phoneNumber &&
        other.currentWeight == currentWeight &&
        other.currentHeight == currentHeight &&
        other.dailyActivity == dailyActivity &&
        other.goal == goal &&
        other.profilePictureUrl == profilePictureUrl &&
        other.currentStep == currentStep;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        password.hashCode ^
        confirmPassword.hashCode ^
        name.hashCode ^
        gender.hashCode ^
        age.hashCode ^
        phoneNumber.hashCode ^
        currentWeight.hashCode ^
        currentHeight.hashCode ^
        dailyActivity.hashCode ^
        goal.hashCode ^
        profilePictureUrl.hashCode ^
        currentStep.hashCode;
  }
}

enum GenderEnum { male, female }

enum DailyActivityEnum { veryActive, moderatelyActive, sedentary }

enum GoalEnum { looseWeight, gainMuscle }
