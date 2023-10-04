import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_todo/utils/app_color.dart';

Widget outlineBtn({
  required Size size,
  required String textBtn,
  required TextTheme textTheme,
  required String type,
  required String? iconPath,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 48.h,
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(APP_BODER_RADIUS),
        border: Border.all(color: PRIMARY_COLOR, width: 1.w),
        boxShadow: const [
          BoxShadow(
            color: Colors.transparent,
            spreadRadius: -1,
            blurRadius: 4,
            offset: Offset(-2, 2),
          )
        ],
      ),
      child: type == 'register'
          ? Center(
              child: Text(tr(textBtn)),
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 24.h,
                  width: 24.w,
                  child: Image.asset(
                    iconPath ?? '',
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  tr(textBtn),
                  style: textTheme.titleSmall,
                ),
              ],
            ),
    ),
  );
}
