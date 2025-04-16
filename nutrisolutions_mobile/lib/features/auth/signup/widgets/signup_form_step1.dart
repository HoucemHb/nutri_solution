import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:nutrisolutions_mobile/features/auth/signup/widgets/signup_inputs.dart';

import '../../providers/signup_form_notifier.dart';
import '../../widgets/auth_label_widget.dart';
import '../../widgets/input_template_widgets.dart';

class SignupFormStep1 extends ConsumerWidget {
  const SignupFormStep1({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signupFormState = ref.watch(signupFormProvider);
    return Column(
      children: [
        const AuthLabel(labelText: 'Email address'),
        const Gap(8),
        const SignupEmailField(),
        const Gap(20),
        const AuthLabel(labelText: 'Password'),
        const Gap(8),
        SignupPasswordField(
          obscureText: signupFormState.obscurePassword,
        ),
        const Gap(12),
        SignupConfirmPasswordField(
          obscureText: signupFormState.obscureConfirmPassword,
        ),
      ],
    );
  }
}
