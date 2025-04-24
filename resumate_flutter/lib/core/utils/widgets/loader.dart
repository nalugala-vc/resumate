import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final Color loaderColor;
  const Loader({super.key, required this.loaderColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator.adaptive(
        valueColor: AlwaysStoppedAnimation<Color>(loaderColor),
      ),
    );
  }
}
