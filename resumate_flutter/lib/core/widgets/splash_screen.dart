import 'package:flutter/material.dart';
import 'package:resumate_flutter/core/fonts/bumbbled.dart';
import 'package:resumate_flutter/core/theme/app_pallette.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.primary100,
      body: SafeArea(
        child: Center(
          child: Bumbbled(text: 'ResuMate', textColor: AppPallete.primary400),
        ),
      ),
    );
  }
}
