import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_weather_app/core/components/success_flash_bar.dart';
import 'package:flutter_weather_app/core/components/text_form_field_widget.dart';
import 'package:flutter_weather_app/core/utils/animated_navigation.dart';
import 'package:flutter_weather_app/core/utils/form_validator.dart';
import 'package:flutter_weather_app/features/auth/presentation/cubit/sign_up/sign_up_cubit.dart';
import 'package:flutter_weather_app/features/auth/presentation/screens/sign_in_screen.dart';

import '../../../../core/components/button_widget.dart';
import '../../../../core/components/error_flash_bar.dart';
import '../../../../core/utils/app_colors.dart';

class SignUpScreen extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      );

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController controllerLogin = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: Scaffold(
        body: SafeArea(
          child: BlocListener<SignUpCubit, SignUpState>(
            listener: (context, state) {
              if (state is SignUpError) {
                ErrorFlushBar("change_error".tr(args: [state.message.tr()]))
                    .show(context);
              } else if (state is SignUpSuccess) {
                SuccessFlushBar("signUpSuccess".tr()).show(context);
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 48.h),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back_rounded),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          "signUp".tr(),
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontFamily: "Ubuntu",
                            fontWeight: FontWeight.w500,
                            color: AppColors.mainBlackText,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "enterDataForSignUp".tr(),
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
                      title: 'signUpButt'.tr(),
                      onTap: () {
                        BlocProvider.of<SignUpCubit>(context).signUp(
                          controllerLogin.text.trim(),
                          controllerPassword.text.trim(),
                        );
                      },
                    ),
                    SizedBox(height: 24.h),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "haveAccount".tr(),
                              style: TextStyle(
                                color: AppColors.venomusBlue,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const TextSpan(text: " "),
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => AnimatedNavigation.push(
                                      context: context,
                                      page: const SignInScreen(),
                                    ),
                              text: "enter".tr(),
                              style: TextStyle(
                                color: AppColors.venomusBlue,
                                fontSize: 14.sp,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
