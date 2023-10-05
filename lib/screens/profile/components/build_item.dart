import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  var iconColor = Theme.of(context).brightness == Brightness.light
      ? BLACK_COLOR
      : GRAY_COLOR;
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
              child: Image.asset(
                iconPath,
                color: type == 'logout' ? Colors.red : iconColor,
              ),
            ),
            SizedBox(width: 10.h),
            Text(
              tr(text),
              style: textTheme.titleMedium!.copyWith(
                  color: type == "logout"
                      ? Colors.red
                      : textTheme.titleMedium!.color),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: 20.sp,
              color: iconColor,
            ),
          ],
        ),
      ),
    ),
  );
}
