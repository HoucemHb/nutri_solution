import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../providers/login_form_notifier.dart';
class RememberMe extends ConsumerWidget {
  const RememberMe({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rememberMe = ref.watch(loginFormProvider).rememberMe;
    return Row(
      children: [
        Checkbox(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
          side: const BorderSide(color: AppColors.hintText, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          value: rememberMe,
          onChanged: (value) {
            ref.read(loginFormProvider.notifier).updateRememberMe(value!);
          },
        ),
        Text(
          "Remember me?",
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
