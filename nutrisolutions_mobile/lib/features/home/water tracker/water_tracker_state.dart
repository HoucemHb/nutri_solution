// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

// Enum for status
enum WaterTrackingStatus { veryHappy, happy, neutral, sad, verySad }

// State class to hold all needed info
class WaterTrackingState {
  final int filledCups;
  final int recommendedDrunCups;
  final WaterTrackingStatus status;
  final String currentTime;

  WaterTrackingState({
    this.filledCups = 0,
    this.recommendedDrunCups = 1,
    this.status = WaterTrackingStatus.veryHappy,
    required this.currentTime,
  });

  WaterTrackingState copyWith({
    int? filledCups,
    int? recommendedDrunCups,
    WaterTrackingStatus? status,
    String? currentTime,
  }) {
    return WaterTrackingState(
      filledCups: filledCups ?? this.filledCups,
      recommendedDrunCups: recommendedDrunCups ?? this.recommendedDrunCups,
      status: status ?? this.status,
      currentTime: currentTime ?? this.currentTime,
    );
  }

  @override
  String toString() {
    return 'WaterTrackingState(filledCups: $filledCups, recommendedDrunCups: $recommendedDrunCups, status: $status, currentTime: $currentTime)';
  }
}
