import 'package:cloud_firestore/cloud_firestore.dart';
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
                itemBuilder: (context, index) {
                  final data = weatherEntity.weatherByHours[index];
                 final  dateTime = DateTime.fromMicrosecondsSinceEpoch(int.parse(data.millisecondsFromEpoch) * 1000);

                  return _Item(
                    dateTime: dateTime,
                    temp: data.temp,
                    type: data.type,
                  );
                },
                itemCount: weatherEntity.weatherByHours.length),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}

class _Item extends StatefulWidget {
  final DateTime dateTime;
  final num temp;
  final String type;
  const _Item({
    Key? key,
    required this.dateTime,
    required this.temp,
    required this.type,
  }) : super(key: key);

  @override
  State<_Item> createState() => _ItemState();
}

class _ItemState extends State<_Item> {
  bool isActive = false;

  @override
  void initState() {

    isActive = isSmallestDifference(widget.dateTime);
    super.initState();
  }

  bool isSmallestDifference(DateTime inputDate) {
    DateTime currentDate = DateTime.now();
    Duration difference = inputDate.difference(currentDate);

    return difference.inMilliseconds.abs() <= Duration.millisecondsPerDay;
  }

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
            DateFormat.Hm().format(widget.dateTime.toLocal()).toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.sp,
              fontFamily: "Roboto",
            ),
          ),
          SizedBox(height: 16.h),
          SvgPicture.asset(_getWeatherType(widget.type)),
          SizedBox(height: 16.h),
          Text(
            "${widget.temp.round()}º",
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

  String _getWeatherType(String weather) {
    if (weather == "Thunderstorm") {
      return Assets.tCloudLightning;
    } else if (weather == "Drizzle") {
      return Assets.tCloudMoon;
    } else if (weather == "Rain") {
      return Assets.tCloudRain;
    } else if (weather == "Snow") {
      return Assets.tCloudSnow;
    } else if (weather == "Clouds") {
      return Assets.tCloudSun;
    }

    return Assets.tSun;
  }
}
