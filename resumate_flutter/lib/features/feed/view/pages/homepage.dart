import 'package:flutter/material.dart';
import 'package:resumate_flutter/core/spacers/spacers.dart';
import 'package:resumate_flutter/features/feed/view/widgets/readiness_indicator.dart';
import 'package:resumate_flutter/features/feed/view/widgets/top_bar_user.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              TopBarUser(name: 'Ms. Venessa'),
              spaceH10,
              ReadinessIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
