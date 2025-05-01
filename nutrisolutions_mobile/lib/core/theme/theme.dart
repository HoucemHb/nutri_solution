import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

final poppins = GoogleFonts.poppins(letterSpacing: 0.8);
final dancingScript = GoogleFonts.dancingScript(letterSpacing: 0.8);

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.backgroundColor,
  textTheme: TextTheme(
    headlineLarge: poppins.copyWith(
        color: AppColors.primaryColor,
        fontSize: 30,
        fontWeight: FontWeight.w600),
    headlineMedium: poppins.copyWith(
        color: AppColors.secondaryColor,
        fontSize: 22,
        fontWeight: FontWeight.w500),
    titleLarge: dancingScript.copyWith(
        color: AppColors.primaryColor,
        fontSize: 25,
        fontWeight: FontWeight.w600),
    titleMedium: poppins.copyWith(
        color: AppColors.textColor, fontSize: 20, fontWeight: FontWeight.w600),
    titleSmall: poppins.copyWith(
        color: AppColors.textColor, fontSize: 18, fontWeight: FontWeight.w600),
    bodySmall: poppins.copyWith(
        color: AppColors.hintText, fontSize: 16, fontWeight: FontWeight.w400),
    bodyMedium: poppins.copyWith(
        color: AppColors.textColor, fontSize: 17, fontWeight: FontWeight.w500),
    labelLarge: poppins.copyWith(
        color: AppColors.textColor, fontSize: 20, fontWeight: FontWeight.w600),
    labelMedium: poppins.copyWith(
        color: AppColors.primaryColor,
        fontSize: 16,
        fontWeight: FontWeight.w600),
    labelSmall: poppins.copyWith(
        color: AppColors.primaryColor,
        fontSize: 14,
        fontWeight: FontWeight.w600),
  ),
  appBarTheme: const AppBarTheme(
    color: AppColors.primaryColor,
    elevation: 0,
    iconTheme: IconThemeData(
      color: AppColors.white,
    ),
  ),
  colorScheme: const ColorScheme.light(
      surface: AppColors.white, primary: AppColors.primaryColor),
  primaryColor: AppColors.primaryColor,
  bottomNavigationBarTheme:
      const BottomNavigationBarThemeData(backgroundColor: Colors.transparent),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.lightOrange),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      textStyle: WidgetStateProperty.all<TextStyle>(
        poppins.copyWith(
            color: AppColors.primaryColor,
            fontSize: 12,
            fontWeight: FontWeight.w600),
      ),
      backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
      foregroundColor: WidgetStateProperty.all<Color>(AppColors.hintText),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(horizontal: 0, vertical: 15)),
      shape: WidgetStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all<Color>(AppColors.white),
      backgroundColor: WidgetStateProperty.all<Color>(AppColors.secondaryColor),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(horizontal: 20, vertical: 15)),
      shape: WidgetStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
      ),
      minimumSize: WidgetStateProperty.all<Size>(
        const Size(double.infinity, 20), // Set the minimum width to infinity
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: EdgeInsets.zero,
    border: InputBorder.none,
    hintStyle: poppins.copyWith(
        color: AppColors.hintText, fontSize: 16, fontWeight: FontWeight.w400),
  ),
  drawerTheme: DrawerThemeData(
    backgroundColor: AppColors.brown,
    elevation: 8,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.horizontal(right: Radius.circular(24)),
    ),
    scrimColor: AppColors.lightOrange.withOpacity(0.1), // when drawer slides in
  ),
  dialogTheme: const DialogTheme(backgroundColor: AppColors.white),
);
