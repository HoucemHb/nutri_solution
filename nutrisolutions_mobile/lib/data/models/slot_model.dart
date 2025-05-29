// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class SlotModel {
  final DateTime date;
  final String day;
  final String time;
  final String nutritionistName;
  final bool isReservation;
  // final bool isReserved;
  final double? rating;
  final String? clientName;
  final String? clientId;
  final List<String>? notes;
  final String? id;

  SlotModel({
    required this.date,
    required this.day,
    required this.time,
    required this.nutritionistName,
    required this.isReservation,
    this.rating,
    this.clientName,
    this.clientId,
    this.notes,
    this.id,
  });

  factory SlotModel.fromJson(Map<String, dynamic> json) {
    return SlotModel(
      date: DateTime.parse(json['date']),
      day: json['day'],
      time: json['time'],
      nutritionistName: json['nutritionist']['name'], // adjust as needed
      isReservation: json['isReservation'],
      // isReserved: json['isReserved'],
      rating: json['rating']?.toDouble(),
      clientName: json['client']?['name'],
      notes: List<String>.from(json['notes'] ?? []),
      id: json['id'],
      clientId: json['client']?['id'],
    );
  }

  SlotModel copyWith({
    DateTime? date,
    String? day,
    String? time,
    String? nutritionistName,
    bool? isReservation,
    double? rating,
    String? clientName,
    String? clientId,
    List<String>? notes,
    String? id,
  }) {
    return SlotModel(
      date: date ?? this.date,
      day: day ?? this.day,
      time: time ?? this.time,
      nutritionistName: nutritionistName ?? this.nutritionistName,
      isReservation: isReservation ?? this.isReservation,
      rating: rating ?? this.rating,
      clientName: clientName ?? this.clientName,
      clientId: clientId ?? this.clientId,
      notes: notes ?? this.notes,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date.millisecondsSinceEpoch,
      'day': day,
      'time': time,
      'nutritionistName': nutritionistName,
      'isReservation': isReservation,
      'rating': rating,
      'clientName': clientName,
      'clientId': clientId,
      'notes': notes,
      'id': id,
    };
  }

  factory SlotModel.fromMap(Map<String, dynamic> map) {
    return SlotModel(
      date: DateTime.parse(map['date']),
      day: map['day'],
      time: map['time'],
      nutritionistName: map['nutritionist']['name'], // adjust as needed
      isReservation: map['isReservation'],
      // isReserved: map['isReserved'],
      rating: map['rating'].toDouble(),
      clientName: map['client']?['name'],
      notes: List<String>.from(map['notes'] ?? []),
      id: map['id'],
      clientId: map['client']?['id'],
    );
  }

  String toJson() => json.encode(toMap());

  // factory SlotModel.fromJson(String source) =>
  //     SlotModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SlotModel(date: $date, day: $day, time: $time, nutritionistName: $nutritionistName, isReservation: $isReservation, rating: $rating, clientName: $clientName, clientId: $clientId, notes: $notes, id: $id)';
  }

  @override
  bool operator ==(covariant SlotModel other) {
    if (identical(this, other)) return true;

    return other.date == date &&
        other.day == day &&
        other.time == time &&
        other.nutritionistName == nutritionistName &&
        other.isReservation == isReservation &&
        other.rating == rating &&
        other.clientName == clientName &&
        other.clientId == clientId &&
        listEquals(other.notes, notes) &&
        other.id == id;
  }

  @override
  int get hashCode {
    return date.hashCode ^
        day.hashCode ^
        time.hashCode ^
        nutritionistName.hashCode ^
        isReservation.hashCode ^
        rating.hashCode ^
        clientName.hashCode ^
        clientId.hashCode ^
        notes.hashCode ^
        id.hashCode;
  }
}
