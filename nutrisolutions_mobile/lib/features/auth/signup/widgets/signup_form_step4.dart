import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:nutrisolutions_mobile/features/auth/signup/widgets/signup_inputs.dart';

import '../../providers/signup_form_notifier.dart';
import '../../widgets/auth_label_widget.dart';
import '../../widgets/input_template_widgets.dart';

class SignupFormStep4 extends ConsumerWidget {
  const SignupFormStep4({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signupFormState = ref.watch(signupFormProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SignupEmailField(),
          SignupPasswordField(
            obscureText: signupFormState.obscurePassword,
          ),
          SignupConfirmPasswordField(
            obscureText: signupFormState.obscureConfirmPassword,
          ),
        ],
      ),
    );
  }
}
