import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nutrisolutions_mobile/core/theme/app_colors.dart';
import 'package:nutrisolutions_mobile/core/utils/show_toast.dart';
import 'package:nutrisolutions_mobile/data/models/slot_model.dart';
import 'package:nutrisolutions_mobile/data/providers/auth_provider.dart';
import 'package:nutrisolutions_mobile/data/providers/planning_provider.dart';
import 'package:nutrisolutions_mobile/data/services/planning_service.dart';
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
    List<String> workDaysOfWeek = [
      'Lundi',
      'Mardi',
      'Mercredi',
      'Jeudi',
      'Vendredi',
    ];
    print('buillddd');
    return Scaffold(
      body: asyncSlots.when(
        data: (slots) {
          print('slots: $slots');
          final appointments = getAppointments(slots);
          return SfCalendar(
            onTap: (CalendarTapDetails details) async {
              if (details.targetElement == CalendarElement.calendarCell) {
                final DateTime selectedDate = details.date!;
                final DateTime now = DateTime.now();

                // Check if selected date is in the past
                if (selectedDate
                    .isBefore(DateTime(now.year, now.month, now.day))) {
                  AppToast.showErrorToast(
                      'Veuillez choisir une date postérieure à aujourd\'hui.');
                  return;
                }

                int weekdayIndex = selectedDate.weekday;

                // Only allow weekdays (1 to 5)
                if (weekdayIndex >= 1 && weekdayIndex <= 5) {
                  final bool confirmed = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Confirmer la réservation'),
                          content: Text(
                            'Souhaitez-vous réserver un rendez-vous le ${DateFormat('EEEE dd MMMM à HH:mm', 'fr_FR').format(selectedDate)} ?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text('Annuler'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text('Confirmer'),
                            ),
                          ],
                        ),
                      ) ??
                      false;

                  if (!confirmed) return;

                  String day = workDaysOfWeek[weekdayIndex - 1];
                  String time = DateFormat.Hm().format(selectedDate); // "HH:mm"

                  final CreateSlotModelDto newSlot = CreateSlotModelDto(
                    date: selectedDate,
                    day: day,
                    time: time,
                    isReservation: true,
                    nutritionistId: nutritionistId,
                    clientId: await ref.read(authServiceProvider).getUserId(),
                  );

                  try {
                    final addedSlot =
                        await ref.read(addSlotProvider(newSlot).future);
                    AppToast.showSuccessToast(
                        'Créneau réservé : ${addedSlot.id}');
                    ref.invalidate(unavailableSlotsProvider(nutritionistId));
                  } catch (e) {
                    AppToast.showErrorToast('Échec de la réservation : $e');
                  }
                } else {
                  AppToast.showErrorToast('Veuillez choisir un jour ouvrable.');
                }
              } else if (details.targetElement == CalendarElement.appointment) {
                final Appointment appointment = details.appointments!.first;
                final String clientName = appointment.subject;
                final slotId = appointment.id as String;
                if (appointment.endTime.isBefore(DateTime.now())) {
                  print(appointment.notes);
                  if (appointment.notes == '0.0') {
                    await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Evaluez la consultation'),
                        content: RatingBar.builder(
                          initialRating: 0,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) async {
                            //api rating
                            try {
                              final success = await ref.read(addRatingProvider(
                                  {'slotId': slotId, 'rating': rating}).future);
                              AppToast.showSuccessToast(
                                  'Evaluation ajoutée avec succès.');
                              ref.invalidate(
                                  unavailableSlotsProvider(nutritionistId));
                            } catch (e) {
                              AppToast.showErrorToast(
                                  'Échec de l\'évaluation : $e');
                            }
                            Navigator.of(context).pop(true);
                          },
                        ),
                        // actions: [
                        //   TextButton(
                        //     onPressed: () => Navigator.of(context).pop(false),
                        //     child: const Text('Annuler'),
                        //   ),
                        //   TextButton(
                        //     onPressed: () => Navigator.of(context).pop(true),
                        //     child: const Text('Confirmer'),
                        //   ),
                        // ],
                      ),
                    );
                  } else {
                    AppToast.showErrorToast(
                        'Vous avez déjà évalué ce rendez-vous.');
                  }
                  //api rating
                } else {
// Show a dialog with the client name and slot ID
                  final bool confirmed = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Annuler la réservation'),
                          content: Text(
                            'Souhaitez-vous annuler la réservation de $clientName ?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text('Annuler'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text('Confirmer'),
                            ),
                          ],
                        ),
                      ) ??
                      false;

                  if (!confirmed) return;

                  try {
                    final success = await ref
                        .read(cancelSlotReservationProvider(slotId).future);
                    AppToast.showSuccessToast(
                        'Réservation annulée avec succès.');
                    ref.invalidate(unavailableSlotsProvider(nutritionistId));
                  } catch (e) {
                    AppToast.showErrorToast('Échec de l\'annulation : $e');
                  }
                }
              }
            },
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
            headerHeight: 35,
            headerStyle: const CalendarHeaderStyle(
              textAlign: TextAlign.center,
              backgroundColor: AppColors.backgroundColor,
              textStyle: TextStyle(
                fontSize: 20,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            showCurrentTimeIndicator: false,
            cellBorderColor: AppColors.backgroundColor,
            dataSource: PlanningDataSource(appointments),
            appointmentBuilder: (context, details) {
              final appointment = details.appointments.first;
              return Stack(
                children: [
                  if (appointment.recurrenceId == null)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                    ),
                  Container(
                    decoration: BoxDecoration(
                      color: appointment.color,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      appointment.subject,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  if (((appointment.recurrenceId) ==
                          ref.read(authServiceProvider).userId) &&
                      (appointment.endTime.isAfter(DateTime.now())))
                    Positioned(
                      right: 0,
                      child: Image.asset(
                        'assets/images/cancel.png',
                        height: 20,
                        width: 20,
                      ),
                    ),
                  if (((appointment.recurrenceId) ==
                          ref.read(authServiceProvider).userId) &&
                      (appointment.endTime.isBefore(DateTime.now())))
                    Positioned(
                      right: 0,
                      child: Image.asset(
                        'assets/images/etoile.png',
                        height: 20,
                        width: 20,
                      ),
                    )
                ],
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
    return slots.map((slot) {
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
      print('clientId/ ${slot.clientId}');

      return Appointment(
        id: slot.id,
        notes: slot.rating.toString(),
        recurrenceId: slot.clientId, //USING RECURRENCE ID FOR client id,
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
