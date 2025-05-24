import 'dart:ui';
import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

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
            padding: const EdgeInsets.all(25.0),
            color: AppColors.backgroundColor,
            // width: 224,
            // height: 238,
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
