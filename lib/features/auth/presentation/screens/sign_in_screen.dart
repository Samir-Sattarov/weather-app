import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_weather_app/core/components/error_flash_bar.dart';
import 'package:flutter_weather_app/core/components/text_form_field_widget.dart';
import 'package:flutter_weather_app/core/utils/form_validator.dart';
import 'package:flutter_weather_app/features/auth/presentation/cubit/login_cubit.dart';
import 'package:flutter_weather_app/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:flutter_weather_app/features/main/presensation/screens/home_screen.dart';

import '../../../../core/components/button_widget.dart';
import '../../../../core/utils/animated_navigation.dart';
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
  void initState() {
    controllerLogin.text = "test@gmail.com";
    controllerPassword.text = "test123456";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                AnimatedNavigation.push(
                    context: context, page: const HomeScreen());
              } else if (state is LoginError) {
                ErrorFlushBar("change_error".tr(args: [state.message.tr()]))
                    .show(context);
              }
            },
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: SingleChildScrollView(
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
                        onTap: () {
                          BlocProvider.of<LoginCubit>(context).signIn(
                              controllerLogin.text.trim(),
                              controllerPassword.text.trim());
                        },
                      ),
                      SizedBox(height: 24.h),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "dontHaveAccount".tr(),
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
                                        page: const SignUpScreen(),
                                      ),
                                text: "signUp".tr(),
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
              );
            },
          ),
        ),
      ),
    );
  }
}
