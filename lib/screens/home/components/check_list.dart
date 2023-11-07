import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

Widget checkList({
  required TextTheme textTheme,
  String? type,
}) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 100.h),
          height: 227.h,
          width: 227.w,
          child: SvgPicture.asset(
            'assets/images/Checklist-rafiki 1.svg',
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          type == 'pending'
              ? 'What do you want to do today?'
              : 'There is no complete mission yet',
          style: textTheme.displayMedium!.copyWith(fontWeight: FontWeight.w400),
        ),
        SizedBox(height: 10.h),
        type == 'pending'
            ? Text(
                'Tap + to add your tasks',
                style: textTheme.displaySmall,
              )
            : const SizedBox(),
      ],
    ),
  );
}
