import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_todo/utils/app_color.dart';

Widget mainBtn(
    {required Size size,
    required String text,
    required TextTheme textTheme,
    required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 48.h,
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(APP_BODER_RADIUS),
        color: PRIMARY_COLOR,
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            spreadRadius: -1,
            blurRadius: 4,
            offset: Offset(-2, 2),
          )
        ],
      ),
      child: Center(
        child: Text(
          tr(text),
          style: textTheme.titleSmall!.copyWith(color: GRAY_COLOR),
        ),
      ),
    ),
  );
}
