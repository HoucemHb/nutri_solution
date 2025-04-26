import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gap/gap.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/nutri_box.dart';
import '../../providers/signup_form_notifier.dart';

class SignupFormStep4 extends ConsumerWidget {
  const SignupFormStep4({super.key});

  Future<void> _pickImage(WidgetRef ref) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      ref
          .read(signupFormProvider.notifier)
          .updateProfilePicture(File(pickedFile.path));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signupFormState = ref.watch(signupFormProvider);
    final selectedImage = signupFormState.profilePicture;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Center(
        child: GestureDetector(
          onTap: () => _pickImage(ref),
          child: selectedImage == null
              ? NutriBox(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Image.asset(
                      'assets/images/upload-image.png',
                      fit: BoxFit.contain,
                    )),
                    const Gap(10),
                    Text(
                      'Add Picture',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ))
              : Stack(
                  children: [
                    ClipOval(
                      child: Image.file(
                        width: 230,
                        height: 230,
                        selectedImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: AppColors.lightGray,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color: AppColors.white,
                              width: 3,
                            ),
                          ),
                          width: 70,
                          height: 70,
                          child: Center(
                            child: Image.asset(
                              'assets/images/edit.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        )),
                  ],
                ),
        ),
      ),
    );
  }
}
