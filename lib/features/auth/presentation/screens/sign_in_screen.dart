import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController controllerLogin = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 48.h),
              Text(
                "enter",
                style: TextStyle(
                  fontSize: 48.sp,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Text(
                "enterDataForLogin".tr(),
                style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                  fontSize: 24.sp,
                ),
              ),
              SizedBox(height: 35.h),
              SizedBox(
                height: 37.h,
                child: Placeholder(),
              ),
              SizedBox(height: 34.h),
              SizedBox(
                height: 37.h,
                child: Placeholder(),
              ),
              SizedBox(height: 48.h),
              SizedBox(
                height: 48.h,
                child: Placeholder(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
