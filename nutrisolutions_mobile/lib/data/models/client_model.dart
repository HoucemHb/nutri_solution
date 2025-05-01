// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:nutrisolutions_mobile/data/models/slot_model.dart';

class ClientModel {
  final String name;
  final String email;
  final String password;
  final String phoneNumber;
  final String profilePictureUrl;
  final String gender;
  final DateTime birthDate;
  final String role;
  final int height;
  final int weight;
  // final List<RecipeModel> favoriteRecipes;
  final String objectif;
  final String activityLevel;
  final List<SlotModel> reservedSlots;
  final int reservedSlotsCount;
  final String? id;

  ClientModel({
    String? role,
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.profilePictureUrl,
    required this.gender,
    required this.birthDate,
    required this.height,
    required this.weight,
    // this.favoriteRecipes = const [],
    required this.objectif,
    required this.activityLevel,
    this.reservedSlots = const [],
    this.reservedSlotsCount = 0,
    this.id,
  }) : role = 'Client';

  /// Calculates the client's age based on birth date
  int getClientAge() {
    final today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  ClientModel copyWith({
    String? name,
    String? email,
    String? password,
    String? phoneNumber,
    String? profilePictureUrl,
    String? gender,
    DateTime? birthDate,
    String? role,
    int? height,
    int? weight,
    // List<RecipeModel>? favoriteRecipes,
    String? objectif,
    String? activityLevel,
    List<SlotModel>? reservedSlots,
    int? reservedSlotsCount,
    String? id,
  }) {
    return ClientModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      role: role ?? this.role,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      // favoriteRecipes: favoriteRecipes ?? this.favoriteRecipes,
      objectif: objectif ?? this.objectif,
      activityLevel: activityLevel ?? this.activityLevel,
      reservedSlots: reservedSlots ?? this.reservedSlots,
      reservedSlotsCount: reservedSlotsCount ?? this.reservedSlotsCount,
      id: id ?? this.id,
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
      'birthDate': birthDate.toIso8601String(),
      'role': role,
      'height': height,
      'weight': weight,
      // 'favoriteRecipes': favoriteRecipes,
      'objectif': objectif,
      'activityLevel': activityLevel,
      'reservedSlots': reservedSlots.map((x) => x).toList(),
      'reservedSlotsCount': reservedSlotsCount,
      // 'id': id,
    };
  }

  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      phoneNumber: map['phoneNumber'] as String,
      profilePictureUrl: map['profilePictureUrl'] as String,
      gender: map['gender'],
      birthDate: DateTime.parse(map['birthDate']),
      role: map['role'] as String,
      height: map['height'] as int,
      weight: map['weight'] as int,
      // favoriteRecipes: List<RecipeModel>.from(
      //   (map['favoriteRecipes'] as List<int>).map<RecipeModel>(
      //     (x) => RecipeModel.fromMap(x as Map<String, dynamic>),
      //   ),
      // ),
      objectif: map['objectif'],
      activityLevel: map['activityLevel'],
      // reservedSlots: List<SlotModel>.from(
      //   (map['reservedSlots'] as List<int>).map<SlotModel>(
      //     (x) => SlotModel.fromMap(x as Map<String, dynamic>),
      //   ),
      // ),
      reservedSlotsCount: map['reservedSlotsCount'] as int,
      id: map['id'] != null ? map['id'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientModel.fromJson(Map<String, dynamic> source) =>
      ClientModel.fromMap(source);

  @override
  String toString() {
    return 'ClientModel(name: $name, email: $email, password: $password, phoneNumber: $phoneNumber, profilePictureUrl: $profilePictureUrl, gender: $gender, birthDate: $birthDate, role: $role, height: $height, weight: $weight, objectif: $objectif, activityLevel: $activityLevel, reservedSlots: $reservedSlots, reservedSlotsCount: $reservedSlotsCount, id: $id)';
  }

  @override
  bool operator ==(covariant ClientModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.password == password &&
        other.phoneNumber == phoneNumber &&
        other.profilePictureUrl == profilePictureUrl &&
        other.gender == gender &&
        other.birthDate == birthDate &&
        other.role == role &&
        other.height == height &&
        other.weight == weight &&
        // listEquals(other.favoriteRecipes, favoriteRecipes) &&
        other.objectif == objectif &&
        other.activityLevel == activityLevel &&
        listEquals(other.reservedSlots, reservedSlots) &&
        other.reservedSlotsCount == reservedSlotsCount &&
        other.id == id;
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
        height.hashCode ^
        weight.hashCode ^
        // favoriteRecipes.hashCode ^
        objectif.hashCode ^
        activityLevel.hashCode ^
        reservedSlots.hashCode ^
        reservedSlotsCount.hashCode ^
        id.hashCode;
  }
}
