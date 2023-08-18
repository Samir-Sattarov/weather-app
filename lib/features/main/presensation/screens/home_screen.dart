import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_weather_app/core/utils/animated_navigation.dart';
import 'package:flutter_weather_app/features/auth/presentation/cubit/login_cubit.dart';
import 'package:flutter_weather_app/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:flutter_weather_app/features/main/domain/entity/weather_entity.dart';
import 'package:flutter_weather_app/features/main/presensation/widget/weather_info_main_widget.dart';
import 'package:flutter_weather_app/features/main/presensation/widget/weather_info_second_widget.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets.dart';

class HomeScreen extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const HomeScreen());

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final temp = 28;
  final type = "Гроза";
  final max = 31;
  final min = 25;

  final weatherEntity = WeatherEntity.empty();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: AppColors.mainScreenBackgroundGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 10.h),
                Row(
                  children: <Widget>[
                    _locationSelection("Архангельск Россия"),
                    const Spacer(),
                    IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          BlocProvider.of<LoginCubit>(context).logout();
                          AnimatedNavigation.pushAndRemoveUntil(
                              context: context, page: const SignInScreen());
                        },
                        icon: Icon(
                          Icons.close,
                          color: AppColors.red.withOpacity(0.6),
                        ))
                  ],
                ),
                SizedBox(height: 25.h),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xffAC7FF5),
                            blurRadius: 50,
                          )
                        ],
                      ),
                      child: const SizedBox(
                        height: 190,
                        width: 190,
                      ),
                    ),
                    SizedBox(
                      height: 180.h,
                      width: 180.h,
                      child: Image.asset(
                        Assets.tBigCloudLight,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Text(
                  "$tempº",
                  style: TextStyle(
                    fontSize: 64.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontFamily: "Ubuntu",
                  ),
                ),
                Text(
                  type,
                  style: TextStyle(
                    fontSize: 17.sp,
                    color: Colors.white,
                    fontFamily: "Roboto",
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  "${'max'.tr()}.: $maxº ${'min'.tr()}: $minº",
                  style: TextStyle(
                    fontSize: 17.sp,
                    color: Colors.white,
                    fontFamily: "Roboto",
                  ),
                ),
                SizedBox(height: 15.h),
                WeatherInfoMainWidget(
                  weatherEntity: weatherEntity,
                ),
                SizedBox(height: 9.h),
                WeatherInfoSecondWidget(weatherEntity: weatherEntity),

                // SizedBox(
                //   height: 96.h,
                //   child: const Placeholder(),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _locationSelection(String location) {
    return Row(
      children: <Widget>[
        SvgPicture.asset(Assets.tLocation),
        SizedBox(width: 8.w),
        Text(
          location,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontFamily: "Roboto",
          ),
        )
      ],
    );
  }
}
