import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/assets.dart';
import '../../../../core/utils/string_helper.dart';
import '../../domain/entity/weather_entity.dart';

class WeatherInfoMainWidget extends StatelessWidget {
  final WeatherEntity weatherEntity;
  const WeatherInfoMainWidget({
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
      child: Column(
        children: [
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                Text(
                  'today'.tr(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Roboto",
                  ),
                ),
                const Spacer(),
                Text(
                  "${DateTime.now().day} ${StringHelper.getMonthName(DateTime.now().month).toLowerCase()}",
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Roboto",
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            height: 1,
            color: Colors.white,
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 142.h,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => _Item(
                      hour: "15:00",
                      degrees: 23,
                      type: 1,
                      isActive: index == 1,
                    ),
                itemCount: 6),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final String hour;
  final int degrees;
  final int type;
  final bool isActive;
  const _Item(
      {Key? key,
      required this.hour,
      required this.degrees,
      required this.type,
      required this.isActive})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 74.w,
      decoration: BoxDecoration(
        color: isActive ? Colors.white.withOpacity(0.40) : null,
        borderRadius: BorderRadius.circular(12.r),
        border: isActive ? Border.all(color: Colors.white, width: 1) : null,
      ),
      child: Column(
        children: [
          SizedBox(height: 16.h),
          Text(
            hour,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.sp,
              fontFamily: "Roboto",
            ),
          ),
          SizedBox(height: 16.h),
          SvgPicture.asset(Assets.tCloudRain),
          SizedBox(height: 16.h),
          Text(
            "$degreesº",
            style: TextStyle(
              color: Colors.white,
              fontSize: 17.sp,
              fontWeight: FontWeight.w500,
              fontFamily: "Roboto",
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
