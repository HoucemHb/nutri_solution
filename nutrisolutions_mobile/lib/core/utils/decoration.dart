import 'package:flutter/material.dart';
import 'package:nutrisolutions_mobile/core/constants/app_constants.dart';
import 'package:nutrisolutions_mobile/core/theme/app_colors.dart';

class AppDecoration {
  static InputBorder getInputBorder(
      bool isError, bool valid, String? noteText) {
    return isError
        ? UnderlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(
              color: AppColors.red,
              width: 3,
            ),
          )
        : noteText == AppConstants.weakPassword
            ? UnderlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(
                  color: AppColors.lightOrange,
                  width: 3,
                ),
              )
            : valid
                ? UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(
                      color: AppColors.secondaryColor,
                      width: 3,
                    ),
                  )
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(
                      color: AppColors.hintText,
                      width: 0.5,
                    ),
                  );
  }
}
