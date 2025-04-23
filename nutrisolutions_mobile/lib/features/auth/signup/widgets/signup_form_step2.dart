import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:nutrisolutions_mobile/features/auth/signup/widgets/auth_dropdown.dart';

import '../../providers/signup_form_notifier.dart';
import '../../widgets/input_template_widgets.dart';
import 'date_picker.dart';

class SignupFormStep2 extends ConsumerWidget {
  const SignupFormStep2({super.key});
  Future<void> _selectDate(BuildContext context, WidgetRef ref) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != DateTime.now()) {
      ref.read(signupFormProvider.notifier).updateBirthdate(picked);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signupFormState = ref.watch(signupFormProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextInputTemplate(
            value: signupFormState.name,
            labelText: 'Name',
            hintText: 'Enter your name',
            onChanged: (value) {
              ref.read(signupFormProvider.notifier).updateName(value);
            },
          ),
          Row(
            children: [
              Expanded(child: GenderDropDown()),
              Gap(10),
              Expanded(child: DatePickerTemplate()),
            ],
          ),
          TextInputTemplate(
            value: signupFormState.phoneNumber,
            labelText: 'Phone Number',
            hintText: 'Enter your phone number (+216 ...)',
            keyboardType: TextInputType.phone,
            onChanged: (value) {
              ref.read(signupFormProvider.notifier).updatePhoneNumber(value);
            },
          ),
        ],
      ),
    );
  }
}
