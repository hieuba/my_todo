import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_todo/utils/app_color.dart';

Widget mediumBtn(Size size, String text, TextTheme textTheme) {
  return Container(
    height: 48.h,
    width: size.width * .4,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(APP_BODER_RADIUS),
      color: PRIMARY_COLOR,
      boxShadow: const [
        BoxShadow(
          color: Colors.grey,
          spreadRadius: -1,
          blurRadius: 4,
          offset: Offset(-2, 2),
        )
      ],
    ),
    child: Center(
      child: Text(
        text,
        style: textTheme.titleSmall!.copyWith(color: GRAY_COLOR),
      ),
    ),
  );
}
