import 'package:flutter/material.dart';
import 'package:task_app/src/core/constants/app_colors.dart';

class AppThemes {
  static ThemeData defaultTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: AppColors.white,
    primaryColor: AppColors.darkBlue,

    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.darkBlue, // Cursor color
    ),
    // appBarTheme: const AppBarTheme(
    //   backgroundColor: AppColors.white,
    //   surfaceTintColor: Colors.transparent,
    //   scrolledUnderElevation: 0.0,
    // ),
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //   style: ElevatedButton.styleFrom(
    //     // backgroundColor: AppColors.purple,
    //     foregroundColor: AppColors.white,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(8.0),
    //     ),
    //   ),
    // ),
  );
}
