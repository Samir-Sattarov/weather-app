import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_weather_app/core/components/text_form_field_widget.dart';
import 'package:flutter_weather_app/core/utils/form_validator.dart';

import '../../../../core/components/button_widget.dart';
import '../../../../core/utils/app_colors.dart';

class SignInScreen extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      );

  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController controllerLogin = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 48.h),
                Text(
                  "enter".tr(),
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontFamily: "Ubuntu",
                    fontWeight: FontWeight.w500,
                    color: AppColors.mainBlackText,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  "enterDataForLogin".tr(),
                  style: TextStyle(
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondBlackText,
                    fontSize: 15.sp,
                  ),
                ),
                SizedBox(height: 50.h),
                TextFormFieldWidget(
                  controller: controllerLogin,
                  validator: FormValidator.validateEmail,
                  label: "Email",
                ),
                SizedBox(height: 34.h),
                TextFormFieldWidget(
                  controller: controllerPassword,
                  validator: FormValidator.password,
                  label: "password".tr(),
                  isPassword: true,
                ),
                SizedBox(height: 48.h),
                ButtonWidget(
                  title: 'login'.tr(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
