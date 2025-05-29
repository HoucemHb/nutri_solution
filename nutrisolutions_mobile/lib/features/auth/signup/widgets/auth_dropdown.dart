import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrisolutions_mobile/features/auth/providers/signup_form_notifier.dart';
import 'package:nutrisolutions_mobile/features/auth/widgets/input_template_widgets.dart';

import '../../../../data/models/enums.dart';

class HeightDropDown extends ConsumerWidget {
  const HeightDropDown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signupFormState = ref.watch(signupFormProvider);
    return DropDownTemplate<int>(
      labelText: 'Height (cm)',
      items: List.generate(150, (index) => index + 100),
      selectedValue: signupFormState.currentHeight,
      onChanged: (value) {
        ref.read(signupFormProvider.notifier).updateCurrentHeight(value!);
      },
    );
  }
}

class WeightDropdown extends ConsumerWidget {
  const WeightDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signupFormState = ref.watch(signupFormProvider);
    return DropDownTemplate<int>(
      labelText: 'Weight (Kg)',
      items: List.generate(200, (index) => index + 30),
      selectedValue: signupFormState.currentWeight,
      onChanged: (value) {
        ref.read(signupFormProvider.notifier).updateCurrentWeight(value!);
      },
    );
  }
}

class GoalDropDown extends ConsumerWidget {
  const GoalDropDown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signupFormState = ref.watch(signupFormProvider);
    return DropDownTemplate<String>(
      labelText: 'Goal',
      items: GoalEnum.values.map((e) => e.label).toList(),
      selectedValue: signupFormState.goal,
      onChanged: (value) {
        ref.read(signupFormProvider.notifier).updateGoal(value!);
      },
    );
  }
}

class GenderDropDown extends ConsumerWidget {
  const GenderDropDown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signupFormState = ref.watch(signupFormProvider);
    return DropDownTemplate<String>(
      labelText: 'Gender',
      items: GenderEnum.values.map((e) => e.label).toList(),
      selectedValue: signupFormState.gender,
      onChanged: (value) {
        ref.read(signupFormProvider.notifier).updateGender(value!);
      },
    );
  }
}

class DailyActivityDropDown extends ConsumerWidget {
  const DailyActivityDropDown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signupFormState = ref.watch(signupFormProvider);
    return DropDownTemplate<String>(
      labelText: 'Daily Activity',
      items: DailyActivityEnum.values.map((e) => e.label).toList(),
      selectedValue: signupFormState.dailyActivity,
      onChanged: (value) {
        ref.read(signupFormProvider.notifier).updateDailyActivity(value!);
      },
    );
  }
}
