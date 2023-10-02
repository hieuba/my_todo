import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_todo/utils/app_color.dart';

Widget mainBtn(Size size, String text, TextTheme textTheme) {
  return Container(
    height: 48.h,
    width: size.width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(APP_BODER_RADIUS),
      color: PRIMARY_COLOR,
    ),
    child: Center(
      child: Text(
        text,
        style: textTheme.titleSmall!.copyWith(color: GRAY_COLOR),
      ),
    ),
  );
}
