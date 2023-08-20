import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_weather_app/features/main/domain/entity/weather_by_hours_entity.dart';
import 'package:flutter_weather_app/features/main/presensation/cubit/weather/current_weather_temp/current_weather_temp_cubit.dart';

import '../../../../core/utils/assets.dart';
import '../../../../core/utils/string_helper.dart';

class WeatherInfoMainWidget extends StatefulWidget {
  final List<WeatherByHoursEntity> listWeather;
  const WeatherInfoMainWidget({
    Key? key,
    required this.listWeather,
  }) : super(key: key);

  @override
  State<WeatherInfoMainWidget> createState() => _WeatherInfoMainWidgetState();
}

class _WeatherInfoMainWidgetState extends State<WeatherInfoMainWidget> {
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
            child: widget.listWeather.isEmpty
                ? Center(
                    child: Text(
                      "empty".tr(),
                      style: TextStyle(
                        fontSize: 17.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Roboto",
                      ),
                    ),
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final data = widget.listWeather[index];

                      final dateTime = DateTime.fromMillisecondsSinceEpoch(
                        data.millisecondsFromEpoch * 1000,
                        isUtc: true,
                      );

                      if (dateTime.day !=
                          (Duration.hoursPerDay - DateTime.now().day)) {
                        return _Item(
                          dateTime: dateTime,
                          temp: data.temp,
                          type: data.type,
                        );
                      }
                      return null;
                    },
                    itemCount: widget.listWeather.length,
                  ),
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
    initialize();
    super.initState();
  }

  initialize() {
    isActive = isActiveChecker(widget.dateTime);

    if (isActive) {
      BlocProvider.of<CurrentWeatherTempCubit>(context).set(widget.temp);
    }
  }

  bool isActiveChecker(DateTime inputDate) {
    DateTime currentDate = DateTime.now();
    return inputDate.hour == currentDate.hour &&
        currentDate.day == inputDate.day;
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
            DateFormat.Hm().format(widget.dateTime),
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
