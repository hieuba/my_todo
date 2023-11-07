import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_todo/utils/app_color.dart';

Widget textdBtn(
  Size size,
  String text,
  TextTheme textTheme,
  VoidCallback onTap,
) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 48.h,
      width: size.width * .24,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(APP_BODER_RADIUS),
      ),
      child: Center(
        child: Text(
          tr(text),
          style: textTheme.titleSmall,
        ),
      ),
    ),
  );
}
