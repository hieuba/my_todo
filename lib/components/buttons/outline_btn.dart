import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_todo/utils/app_color.dart';

Widget outlineBtn(Size size, String text, TextTheme textTheme) {
  return Container(
    height: 48.h,
    width: size.width,
    decoration: BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(APP_BODER_RADIUS),
      border: Border.all(color: PRIMARY_COLOR, width: 2.w),
      boxShadow: const [
        BoxShadow(
          color: Colors.transparent,
          spreadRadius: -1,
          blurRadius: 4,
          offset: Offset(-2, 2),
        )
      ],
    ),
    child: Center(
      child: Text(
        tr(text),
        style: textTheme.titleSmall,
      ),
    ),
  );
}
