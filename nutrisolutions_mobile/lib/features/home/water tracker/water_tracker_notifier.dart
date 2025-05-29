import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrisolutions_mobile/data/services/notification_service.dart';
import 'package:nutrisolutions_mobile/features/home/water%20tracker/water_tracker_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WaterTrackingNotifier extends StateNotifier<WaterTrackingState> {
  Timer? cupTimer;
  Timer? timeTimer;

  WaterTrackingNotifier()
      : super(WaterTrackingState(currentTime: _getCurrentTime())) {
    loadState();
    // Update time every 30 seconds
    timeTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      state = state.copyWith(currentTime: _getCurrentTime());
    });

    // Increment recommended cups every 15 seconds and update status
    cupTimer = Timer.periodic(const Duration(seconds: 15), (_) {
      if (state.recommendedDrunCups >= 7) {
        cupTimer?.cancel();
        return;
      }
      final newRecommended = state.recommendedDrunCups + 1;
      // NotificationService.showNotification(
      //   "Hydration Reminder",
      //   "It's time to drink another cup of water!",
      // );
      state = state.copyWith(recommendedDrunCups: newRecommended);
      _updateStatus();
    });
  }

  Future<void> saveState() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('filledCups', state.filledCups);
    prefs.setInt('recommendedCups', state.recommendedDrunCups);
  }

  Future<void> loadState() async {
    final prefs = await SharedPreferences.getInstance();
    final cups = prefs.getInt('filledCups') ?? 0;
    final recommendedCups = prefs.getInt('recommendedCups') ?? 0;

    state = state.copyWith(filledCups: cups);
    state = state.copyWith(recommendedDrunCups: recommendedCups);
  }

  void fillNextCup() {
    if (state.filledCups < 7) {
      state = state.copyWith(filledCups: state.filledCups + 1);
      _updateStatus();
      saveState();
    }
  }

  void _updateStatus() {
    final difference = state.recommendedDrunCups - state.filledCups;
    WaterTrackingStatus newStatus;
    switch (difference) {
      case 0:
        newStatus = WaterTrackingStatus.veryHappy;
        break;
      case 1:
        newStatus = WaterTrackingStatus.happy;
        break;
      case 2:
        newStatus = WaterTrackingStatus.neutral;
        break;
      case 3:
        newStatus = WaterTrackingStatus.sad;
        break;
      case 4:
      case 5:
      case 6:
      case 7:
        newStatus = WaterTrackingStatus.verySad;
        NotificationService.showNotification(
          "Hydration Alert",
          "You are falling behind on your water intake!",
        );
        // You can also trigger notifications here if needed
        break;
      default:
        newStatus = WaterTrackingStatus.veryHappy;
    }
    if (newStatus != state.status) {
      state = state.copyWith(status: newStatus);
    }
  }

  @override
  void dispose() {
    cupTimer?.cancel();
    timeTimer?.cancel();
    super.dispose();
  }

  static String _getCurrentTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }
}
