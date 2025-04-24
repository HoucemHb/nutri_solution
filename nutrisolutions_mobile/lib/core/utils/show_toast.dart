import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nutrisolutions_mobile/core/theme/app_colors.dart';

class AppToast {
  static void showSuccessToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: AppColors.secondaryColor,
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }

  static void showErrorToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: AppColors.red,
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }
}
