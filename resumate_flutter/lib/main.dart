import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:resumate_flutter/core/theme/app_theme.dart';
import 'package:resumate_flutter/core/widgets/custom_nav_bar.dart';
import 'package:resumate_flutter/features/feed/view/pages/job_details.dart';
import 'package:resumate_flutter/features/feed/view/pages/job_matches.dart';
import 'package:resumate_flutter/features/feed/view/pages/roadmap.dart';
import 'package:resumate_flutter/features/feed/view/pages/video_player.dart';
import 'package:resumate_flutter/features/quiz/view/pages/AI_chat.dart';
import 'package:resumate_flutter/features/quiz/view/pages/quiz_page.dart';

/* UNFORMATTED PAGES

VIDEO PLAYER PAGE
QUIZ PAGE*/

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.lightMode,
      home: AIChatPage(),
    );
  }
}
