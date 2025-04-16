import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:nutrisolutions_mobile/core/theme/app_colors.dart';
import 'package:nutrisolutions_mobile/features/auth/providers/reset_form_notifier.dart';
import 'package:nutrisolutions_mobile/features/auth/widgets/auth_label_widget.dart';

import '../providers/login_form_notifier.dart';

class EmailTemplate extends ConsumerWidget {
  final void Function(String)? onChanged;
  final String labelText;

  const EmailTemplate({this.onChanged, super.key, required this.labelText});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextInputTemplate(
        labelText: labelText,
        hintText: 'Enter your email',
        onChanged: onChanged);
  }
}

class TextInputTemplate extends ConsumerWidget {
  final void Function(String)? onChanged;
  final String labelText;
  final String hintText;

  const TextInputTemplate(
      {this.onChanged,
      required this.hintText,
      super.key,
      required this.labelText});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _AuthInput(
        labelText: labelText,
        hintText: hintText,
        keyboardType: TextInputType.emailAddress,
        onChanged: onChanged);
  }
}

class PasswordTemplate extends StatelessWidget {
  final String hintText;
  final String labelText;
  final bool obscureText;
  final VoidCallback onToggleVisibility;
  final void Function(String)? onChanged;

  const PasswordTemplate({
    required this.hintText,
    required this.obscureText,
    required this.onToggleVisibility,
    this.onChanged,
    super.key,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return _AuthInput(
      labelText: labelText,
      hintText: hintText,
      obscureText: obscureText,
      suffixIcon: IconButton(
        icon: Icon(
          obscureText ? Icons.visibility : Icons.visibility_off,
          color: Colors.grey,
        ),
        onPressed: onToggleVisibility,
      ),
      onChanged: onChanged,
    );
  }
}

class _AuthInput extends StatelessWidget {
  final String hintText;
  final String labelText;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final void Function(String)? onChanged;

  const _AuthInput({
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AuthLabel(labelText: labelText),
        const Gap(8),
        TextField(
          obscureText: obscureText,
          onChanged: onChanged,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 12,
            ),
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(
                color: AppColors.primaryColor,
                width: 0.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(
                color: AppColors.hintText,
                width: 0.5,
              ),
            ),
            filled: true,
            fillColor: Colors.white,
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}

class DropDownTemplate<T> extends ConsumerWidget {
  const DropDownTemplate(
      {super.key,
      required this.items,
      required this.labelText,
      this.onChanged,
      required this.selectedValue});

  final void Function(T? value)? onChanged;
  final T selectedValue;
  final List<T> items;
  final String labelText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        AuthLabel(labelText: labelText),
        const Gap(8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(11),
              border: Border.all(color: AppColors.hintText, width: 0.5)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
                borderRadius: BorderRadius.circular(11),
                style: Theme.of(context).textTheme.bodyMedium,
                value: selectedValue,
                focusColor: AppColors.primaryColor,
                dropdownColor: AppColors.lightGreen,
                icon: const Icon(Icons.arrow_drop_down,
                    color: AppColors.secondaryColor, size: 30),
                padding: EdgeInsets.zero,
                selectedItemBuilder: (BuildContext context) {
                  return items.map((T value) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        value.toString(),
                      ),
                    );
                  }).toList();
                },
                items: items.map<DropdownMenuItem<T>>((T value) {
                  return DropdownMenuItem<T>(
                    value: value,
                    child: Text(
                      value.toString(),
                    ),
                  );
                }).toList(),
                onChanged: onChanged),
          ),
        ),
      ],
    );
  }
}
