import 'package:flutter/material.dart';

class AppColors {
  static LinearGradient mainScreenBackgroundGradient = LinearGradient(
    colors: [
      const Color(0xff0700FF).withOpacity(0.43),
      Colors.black,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static LinearGradient onBoardingScreenBackgroundGradient = const LinearGradient(
    colors: [
      Color(0xff0700FF),
      Colors.black,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const venomusBlue = Color(0xff0700FF);
  static const red = Color(0xffFF585D);
  static const mainBlackText = Color(0xff2B2D33);
  static const secondBlackText = Color(0xff8799A5);
}
