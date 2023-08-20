import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/animated_navigation.dart';
import '../../../../core/utils/app_colors.dart';
import 'sign_in_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      AnimatedNavigation.pushAndRemoveUntil(
        context: context,
        page: const SignInScreen(),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.onBoardingScreenBackgroundGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 43.w),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Text(
                  "weatherService".tr().toUpperCase(),
                  style: TextStyle(
                    fontSize: 48.sp,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                Text(
                  "dawnIsComing".tr(),
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                    fontSize: 24.sp,
                  ),
                ),
                SizedBox(height: 82.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
