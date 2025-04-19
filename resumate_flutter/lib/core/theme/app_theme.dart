import 'package:flutter/material.dart';
import 'package:resumate_flutter/core/theme/app_pallette.dart';

class AppTheme {
  static _border([Color color = AppPallete.primary400, double width = 3]) =>
      OutlineInputBorder(
        borderSide: BorderSide(color: color, width: width),
        borderRadius: BorderRadius.circular(7),
      );

  static final lightMode = ThemeData.light().copyWith(
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
    ),
    appBarTheme: const AppBarTheme(backgroundColor: AppPallete.whiteColor),
  );
}
