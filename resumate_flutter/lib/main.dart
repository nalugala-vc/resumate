import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resumate_flutter/core/di/app_bindings.dart';
import 'package:resumate_flutter/core/utils/theme/app_theme.dart';
import 'package:resumate_flutter/core/utils/widgets/splash_screen.dart';
import 'package:resumate_flutter/features/auth/viewmodel/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() async {
    final controller = SignInController();
    await controller.loadUserFromStorage();
    return controller;
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AppBindings(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.lightMode,
      home: SplashScreen(),
    );
  }
}
