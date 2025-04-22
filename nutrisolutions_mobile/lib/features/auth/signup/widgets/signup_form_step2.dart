import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:nutrisolutions_mobile/features/auth/signup/widgets/auth_dropdown.dart';
import 'package:nutrisolutions_mobile/features/auth/signup/widgets/signup_inputs.dart';

import '../../providers/signup_form_notifier.dart';
import '../../widgets/auth_label_widget.dart';
import '../../widgets/input_template_widgets.dart';

class SignupFormStep2 extends ConsumerWidget {
  const SignupFormStep2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signupFormState = ref.watch(signupFormProvider);
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextInputTemplate(
            labelText: 'Name',
            hintText: 'Enter your name',
          ),
          Row(
            children: [
              Expanded(child: GenderDropDown()),
              Gap(10),
              Expanded(child: AgeDropDown()),
            ],
          ),
          TextInputTemplate(
            labelText: 'Phone Number',
            hintText: 'Enter your phone number (+216 ...)',
            keyboardType: TextInputType.phone,
          ),
        ],
      ),
    );
  }
}
