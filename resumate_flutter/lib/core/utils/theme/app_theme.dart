import 'package:flutter/material.dart';
import 'package:resumate_flutter/core/utils/theme/app_pallette.dart';

class AppTheme {
  static _border([Color color = AppPallete.primary400, double width = 3]) =>
      OutlineInputBorder(
        borderSide: BorderSide(color: color, width: width),
        borderRadius: BorderRadius.circular(7),
      );

  static final lightMode = ThemeData.light().copyWith(
    tabBarTheme: const TabBarThemeData(
      // This removes the default padding
      labelPadding: EdgeInsets.zero,
      // You can also set other properties here
    ),
    scaffoldBackgroundColor: AppPallete.whiteColor,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(16),
      hintStyle: TextStyle(
        color: AppPallete.greyColor,
        fontFamily: 'SFPRO',
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),

      enabledBorder: _border(AppPallete.primary400, 1),
      focusedBorder: _border(),
      errorBorder: _border(AppPallete.errorColor, 1),
      focusedErrorBorder: _border(AppPallete.errorColor, 1),
    ),
    appBarTheme: const AppBarTheme(backgroundColor: AppPallete.whiteColor),
  );
}
