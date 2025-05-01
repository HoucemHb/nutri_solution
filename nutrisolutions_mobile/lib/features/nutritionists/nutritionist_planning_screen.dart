import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrisolutions_mobile/core/theme/app_colors.dart';
import 'package:nutrisolutions_mobile/data/models/slot_model.dart';
import 'package:nutrisolutions_mobile/data/providers/planning_provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class NutritionistPlanningScreen extends ConsumerWidget {
  final String nutritionistId;

  const NutritionistPlanningScreen({super.key, required this.nutritionistId});

  Color getRandomCoolColor() {
    final List<Color> pickedSlotColors = [
      const Color(0xFFFFAD80),
      const Color(0xFF6FF9AA),
      const Color(0xFFF7EE6E),
      const Color(0xFFFEE8AD),
      const Color(0xFF94C6FC),
    ];
    final random = Random();
    return pickedSlotColors[random.nextInt(pickedSlotColors.length)];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncSlots = ref.watch(unavailableSlotsProvider(nutritionistId));

    return Scaffold(
      body: asyncSlots.when(
        data: (slots) {
          final appointments = getAppointments(slots);
          return SfCalendar(
            todayHighlightColor: AppColors.primaryColor,
            view: CalendarView.workWeek,
            timeSlotViewSettings: const TimeSlotViewSettings(
              timeIntervalHeight: 60,
              timeFormat: 'h a',
              timeInterval: Duration(hours: 1),
              startHour: 8,
              endHour: 17,
              timeRulerSize: 60,
            ),
            backgroundColor: const Color(0xffebebeb),
            allowViewNavigation: false,
            showDatePickerButton: false,
            showNavigationArrow: false,
            headerHeight: 30,
            showCurrentTimeIndicator: false,
            cellBorderColor: AppColors.backgroundColor,
            dataSource: PlanningDataSource(appointments),
            appointmentBuilder: (context, details) {
              final appointment = details.appointments.first;
              return Container(
                decoration: BoxDecoration(
                  color: appointment.color,
                  borderRadius: BorderRadius.circular(6),
                ),
                alignment: Alignment.center,
                child: Text(
                  appointment.subject,
                  style: const TextStyle(color: Colors.black),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }

  List<Appointment> getAppointments(List<SlotModel> slots) {
    final reservedSlots = slots.where((slot) => slot.isReserved).toList();
    return reservedSlots.map((slot) {
      final timeParts = slot.time.split(':');
      final hour = int.parse(timeParts[0]);
      final minute = int.parse(timeParts[1]);
      final dateTime = DateTime(
        slot.date.year,
        slot.date.month,
        slot.date.day,
        hour,
        minute,
      );

      return Appointment(
        startTime: dateTime,
        endTime: dateTime.add(const Duration(hours: 1)),
        subject: slot.isReservation ? getInitials(slot.clientName ?? '') : '',
        color:
            slot.isReservation ? getRandomCoolColor() : const Color(0xffff6b6b),
      );
    }).toList();
  }
}

class PlanningDataSource extends CalendarDataSource {
  PlanningDataSource(List<Appointment> source) {
    appointments = source;
  }
}

String getInitials(String fullName) {
  final parts = fullName.trim().split(' ');
  if (parts.length >= 2) {
    return '${parts[0][0].toUpperCase()}.${parts[1][0].toUpperCase()}';
  } else if (parts.isNotEmpty && parts[0].isNotEmpty) {
    return parts[0][0].toUpperCase();
  } else {
    return '';
  }
}
