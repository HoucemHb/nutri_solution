import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gap/gap.dart';
import '../../../../core/theme/app_colors.dart';
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

class NutriBox extends StatelessWidget {
  final Widget child;
  const NutriBox({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BoxClipper(),
      child: Container(
        padding: const EdgeInsets.all(1.3),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primaryColor, AppColors.secondaryColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ClipPath(
          clipper: BoxClipper(),
          child: Container(
            padding: const EdgeInsets.all(50.0),
            color: AppColors.backgroundColor,
            width: 224,
            height: 238,
            child: child,
          ),
        ),
      ),
    );
  }
}

class BoxClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double scaleX = size.width / 224;
    double scaleY = size.height / 238;

    Path path = Path();
    path.moveTo(7 * scaleX, 32.7741 * scaleY);
    path.cubicTo(
      7 * scaleX,
      15.5622 * scaleY,
      22.374 * scaleX,
      2.36082 * scaleY,
      39.4572 * scaleX,
      4.4622 * scaleY,
    );
    path.cubicTo(
      61.2254 * scaleX,
      7.13989 * scaleY,
      89.8532 * scaleX,
      10.0305 * scaleY,
      112 * scaleX,
      10.0305 * scaleY,
    );
    path.cubicTo(
      134.147 * scaleX,
      10.0305 * scaleY,
      162.775 * scaleX,
      7.13989 * scaleY,
      184.543 * scaleX,
      4.4622 * scaleY,
    );
    path.cubicTo(
      201.626 * scaleX,
      2.36082 * scaleY,
      217 * scaleX,
      15.5621 * scaleY,
      217 * scaleX,
      32.7741 * scaleY,
    );
    path.lineTo(217 * scaleX, 199.98 * scaleY);
    path.cubicTo(
      217 * scaleX,
      215.455 * scaleY,
      204.455 * scaleX,
      228 * scaleY,
      188.98 * scaleX,
      228 * scaleY,
    );
    path.lineTo(35.0202 * scaleX, 228 * scaleY);
    path.cubicTo(
      19.5451 * scaleX,
      228 * scaleY,
      7 * scaleX,
      215.455 * scaleY,
      7 * scaleX,
      199.98 * scaleY,
    );
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
