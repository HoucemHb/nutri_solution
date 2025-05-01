// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NutritionistModel {
  final String name;
  final String email;
  final String password;
  final String phoneNumber;
  final String profilePictureUrl;
  final String gender;
  final DateTime birthDate;
  final String role;
  final int experienceYears;
  final String certificateUrl;
  final String status;
  final String? location;
  final String? id;
  final int patientsNumber;
  final int rating;

  NutritionistModel({
    int? rating,
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.profilePictureUrl,
    required this.gender,
    required this.birthDate,
    required this.role,
    required this.experienceYears,
    required this.certificateUrl,
    required this.status,
    this.location,
    this.id,
    this.patientsNumber = 0,
  }) : rating = rating ?? 3;

  NutritionistModel copyWith({
    String? name,
    String? email,
    String? password,
    String? phoneNumber,
    String? profilePictureUrl,
    String? gender,
    DateTime? birthDate,
    String? role,
    int? experienceYears,
    String? certificateUrl,
    String? status,
    String? location,
    String? id,
    int? patientsNumber,
    int? rating,
  }) {
    return NutritionistModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      role: role ?? this.role,
      experienceYears: experienceYears ?? this.experienceYears,
      certificateUrl: certificateUrl ?? this.certificateUrl,
      status: status ?? this.status,
      location: location ?? this.location,
      id: id ?? this.id,
      patientsNumber: patientsNumber ?? this.patientsNumber,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'profilePictureUrl': profilePictureUrl,
      'gender': gender,
      'birthDate': birthDate.millisecondsSinceEpoch,
      'role': role,
      'experienceYears': experienceYears,
      'certificateUrl': certificateUrl,
      'status': status,
      'location': location,
      'id': id,
      'patientsNumber': patientsNumber,
      'rating': rating,
    };
  }

  factory NutritionistModel.fromMap(Map<String, dynamic> map) {
    return NutritionistModel(
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      phoneNumber: map['phoneNumber'] as String,
      profilePictureUrl: map['profilePictureUrl'] as String,
      gender: map['gender'] as String,
      birthDate: DateTime.parse(map['birthDate']),
      role: map['role'] as String,
      experienceYears: map['experienceYears'] as int,
      certificateUrl: map['certificateUrl'] as String,
      status: map['status'] as String,
      location: map['location'] != null ? map['location'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
      patientsNumber: map['patientsNumber'] as int,
      rating: (map['rating'] is double)
          ? (map['rating'] as double).toInt()
          : (map['rating'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory NutritionistModel.fromJson(String source) =>
      NutritionistModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NutritionistModel(name: $name, email: $email, password: $password, phoneNumber: $phoneNumber, profilePictureUrl: $profilePictureUrl, gender: $gender, birthDate: $birthDate, role: $role, experienceYears: $experienceYears, certificateUrl: $certificateUrl, status: $status, location: $location, id: $id, patientsNumber: $patientsNumber, rating: $rating)';
  }

  @override
  bool operator ==(covariant NutritionistModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.password == password &&
        other.phoneNumber == phoneNumber &&
        other.profilePictureUrl == profilePictureUrl &&
        other.gender == gender &&
        other.birthDate == birthDate &&
        other.role == role &&
        other.experienceYears == experienceYears &&
        other.certificateUrl == certificateUrl &&
        other.status == status &&
        other.location == location &&
        other.id == id &&
        other.patientsNumber == patientsNumber &&
        other.rating == rating;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        password.hashCode ^
        phoneNumber.hashCode ^
        profilePictureUrl.hashCode ^
        gender.hashCode ^
        birthDate.hashCode ^
        role.hashCode ^
        experienceYears.hashCode ^
        certificateUrl.hashCode ^
        status.hashCode ^
        location.hashCode ^
        id.hashCode ^
        patientsNumber.hashCode ^
        rating.hashCode;
  }
}
