import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final bool enabled;

  const ButtonWidget({
    Key? key,
    this.onTap,
    required this.title,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: 335.w,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(24.r),

        onTap: !enabled
            ? null
            : () async {
                await HapticFeedback.mediumImpact();

                onTap?.call();
              },
        splashColor: Colors.white,
        child: Ink(
          height: 48.h,
          // padding: padding,
          decoration: BoxDecoration(
            // color: Colors.red,
            color: AppColors.venomusBlue,
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Center(
            child: FittedBox(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  fontFamily: "Roboto",
                  fontSize: 17.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
