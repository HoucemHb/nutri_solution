import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrisolutions_mobile/features/home/water%20tracker/water_tracker_notifier.dart';
import 'package:nutrisolutions_mobile/features/home/water%20tracker/water_tracker_state.dart';

final waterTrackingProvider = StateNotifierProvider.autoDispose<
    WaterTrackingNotifier,
    WaterTrackingState>((ref) => WaterTrackingNotifier());
