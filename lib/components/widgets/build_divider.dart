import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_todo/utils/app_color.dart';

Widget divider(TextTheme textTheme) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      const Expanded(
          child: Divider(
        color: BGREY_COLOR,
      )),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Text(
          'or',
          style: textTheme.titleSmall!.copyWith(color: BGREY_COLOR),
        ),
      ),
      const Expanded(
          child: Divider(
        color: BGREY_COLOR,
      )),
    ],
  );
}
