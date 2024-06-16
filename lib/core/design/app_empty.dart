import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AppEmpty extends StatelessWidget {
  const AppEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      "assets/lottie/empty.json",
    );
  }
}
