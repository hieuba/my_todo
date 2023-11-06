// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_todo/utils/app_color.dart';

Widget buildItem({
  required Size size,
  required TextTheme textTheme,
  required String text,
  required String iconPath,
  required VoidCallback onTap,
  required BuildContext context,
  String? type,
}) {
  var color = Theme.of(context).brightness == Brightness.light;
  return InkWell(
    onTap: onTap,
    child: SizedBox(
      height: 48.h,
      width: size.width,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: H_PADDING),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 24.h,
              width: 24.w,
              child: SvgPicture.asset(
                iconPath,
                fit: BoxFit.cover,
                color: type == 'logout'
                    ? ERROR_COLOR
                    : color
                        ? BLACK_COLOR
                        : WHITE_COLOR,
              ),
            ),
            SizedBox(width: 10.h),
            Text(
              tr(text),
              style: textTheme.titleMedium!.copyWith(
                  color: type == "logout"
                      ? ERROR_COLOR
                      : textTheme.titleMedium!.color),
            ),
            const Spacer(),
            SizedBox(
              height: 24.h,
              width: 24.w,
              child: SvgPicture.asset(
                'assets/svgs/arrow-right.svg',
                fit: BoxFit.cover,
                color: color ? BLACK_COLOR : WHITE_COLOR,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
