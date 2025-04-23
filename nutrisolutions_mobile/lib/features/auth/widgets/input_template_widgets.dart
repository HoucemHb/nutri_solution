import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:nutrisolutions_mobile/core/constants/app_constants.dart';
import 'package:nutrisolutions_mobile/core/theme/app_colors.dart';
import 'package:nutrisolutions_mobile/core/utils/decoration.dart';
import 'package:nutrisolutions_mobile/features/auth/widgets/auth_label_widget.dart';

class EmailTemplate extends ConsumerWidget {
  final void Function(String)? onChanged;
  final String labelText;
  final String? noteText;
  final bool isError;
  final String? value;
  const EmailTemplate(
      {this.onChanged,
      this.noteText,
      this.isError = false,
      super.key,
      required this.labelText,   
      this.value});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextInputTemplate(
      value:value,
      labelText: labelText,
      hintText: 'Enter your email',
      onChanged: onChanged,
      noteText: noteText,
      isError: isError,
      keyboardType: TextInputType.emailAddress,
    );
  }
}

class TextInputTemplate extends ConsumerWidget {
  final void Function(String)? onChanged;
  final String labelText;
  final String hintText;
  final String? noteText;
  final bool isError;
  final TextInputType keyboardType;
  final String? value;
  const TextInputTemplate(
      {this.onChanged,
      required this.hintText,
      this.keyboardType = TextInputType.text,
      super.key,
      required this.labelText,
      this.noteText,
      this.isError = false,
      this.value});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _AuthInput(
      value: value,
      labelText: labelText,
      hintText: hintText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      isError: isError,
      noteText: noteText,
    );
  }
}

class PasswordTemplate extends StatelessWidget {
  final String hintText;
  final String labelText;
  final bool obscureText;
  final VoidCallback onToggleVisibility;
  final void Function(String)? onChanged;
  final String? noteText;
  final bool isError;
  final String? value;

  const PasswordTemplate(
      {required this.hintText,
      required this.obscureText,
      required this.onToggleVisibility,
      this.onChanged,
      super.key,
      required this.labelText,
      this.noteText,
      this.isError = false,
      this.value});

  @override
  Widget build(BuildContext context) {
    return _AuthInput(
        value: value,
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
        isError: isError,
        noteText: noteText);
  }
}

class _AuthInput extends StatelessWidget {
  final String hintText;
  final String labelText;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final void Function(String)? onChanged;
  final String? noteText;
  final bool isError;
  final String? value;

  const _AuthInput({
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    required this.labelText,
    this.noteText,
    this.isError = false,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    final valid = noteText == AppConstants.valid ||
        noteText == AppConstants.normalPassword ||
        noteText == AppConstants.strongPassword;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AuthLabel(labelText: labelText),
            if (noteText != null)
              _InputNote(noteText: noteText!, isError: isError)
          ],
        ),
        const Gap(8),
        TextFormField(
          initialValue: value,
          obscureText: obscureText,
          onChanged: onChanged,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 12,
            ),
            hintText: hintText,
            border: AppDecoration.getInputBorder(isError, valid, noteText),
            focusedBorder:
                AppDecoration.getInputBorder(isError, valid, noteText),
            enabledBorder:
                AppDecoration.getInputBorder(isError, valid, noteText),
            filled: true,
            fillColor: Colors.white,
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}

class _InputNote extends StatelessWidget {
  final String noteText;
  final bool isError;
  const _InputNote({super.key, required this.noteText, this.isError = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
      decoration: BoxDecoration(
        color: isError
            ? AppColors.lightRed
            : noteText == 'Weak..'
                ? const Color.fromARGB(255, 255, 196, 100)
                : AppColors.lightGreen,
        borderRadius: BorderRadius.circular(11),
      ),
      child: Text(
        noteText,
        style: TextStyle(
          color: isError
              ? AppColors.red
              : noteText == 'Weak..'
                  ? AppColors.primaryColor
                  : AppColors.secondaryColor,
          fontSize: 12,
        ),
      ),
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
