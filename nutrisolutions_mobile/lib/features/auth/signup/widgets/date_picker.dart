import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:nutrisolutions_mobile/core/theme/app_colors.dart';
import 'package:nutrisolutions_mobile/features/auth/providers/signup_form_notifier.dart';
import 'package:nutrisolutions_mobile/features/auth/widgets/auth_label_widget.dart';

class DatePickerTemplate extends ConsumerWidget {
  const DatePickerTemplate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signupFormState = ref.watch(signupFormProvider);
    return Column(children: [
      const AuthLabel(labelText: 'Birthdate'),
      const Gap(8),
      Container(
        padding: const EdgeInsets.symmetric(
          vertical: 6,
          horizontal: 0,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.hintText),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              signupFormState.birthDate != null
                  ? '${signupFormState.birthDate!.day}/${signupFormState.birthDate!.month}/${signupFormState.birthDate!.year}'
                  : 'Select your birthDate',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (picked != null && picked != DateTime.now()) {
                  ref.read(signupFormProvider.notifier).updateBirthdate(picked);
                }
              },
            ),
          ],
        ),
      )
    ]);
  }
}
