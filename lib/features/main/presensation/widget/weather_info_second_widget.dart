import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_weather_app/core/utils/string_helper.dart';

import '../../../../core/utils/assets.dart';
import '../../domain/entity/weather_entity.dart';

class WeatherInfoSecondWidget extends StatelessWidget {
  final WeatherEntity weatherEntity;
  const WeatherInfoSecondWidget({
    Key? key,
    required this.weatherEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.20),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            Row(
              children: [
                SizedBox(
                  height: 24.h,
                  width: 24.w,
                  child: Center(
                    child: SvgPicture.asset(Assets.tWindy),
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  "${weatherEntity.windySpeed} ${"meterInSecond".tr()}",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.20),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Roboto",
                  ),
                ),
                const Spacer(),
                FittedBox(
                  child: Text(
                    StringHelper.getWindDirection(weatherEntity.windDirection.toDouble()),
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.white,
                      fontFamily: "Roboto",
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                SizedBox(
                  height: 24.h,
                  width: 24.w,
                  child: Center(child: SvgPicture.asset(Assets.tDrop)),
                ),
                SizedBox(width: 8.w),
                Text(
                  "${weatherEntity.humidity}%",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.20),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Roboto",
                  ),
                ),
                const Spacer(),
                FittedBox(
                  child: Text(
                  StringHelper.getHumidityDescription(  weatherEntity.humidity),
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.white,
                      fontFamily: "Roboto",
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}
