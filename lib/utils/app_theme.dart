import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_todo/utils/app_color.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      fontFamily: 'Lato',
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 32.sp,
          fontWeight: FontWeight.w700,
          color: BLACK_COLOR,
        ),
        displayMedium: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
          height: 1.51,
          color: BLACK_COLOR,
        ),
        displaySmall: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w400,
          height: 1.51,
          color: BLACK_COLOR,
        ),
        titleSmall: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          height: 1.51,
          color: BLACK_COLOR,
        ),
        titleMedium: TextStyle(
          fontSize: 14.sp,
          height: 1.51,
          fontWeight: FontWeight.w400,
          color: BLACK_COLOR,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: PRIMARY_COLOR,
      ));

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      fontFamily: 'Lato',
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 32.sp,
          fontWeight: FontWeight.w700,
          color: GRAY_COLOR,
        ),
        displayMedium: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
          height: 1.51,
          color: GRAY_COLOR,
        ),
        displaySmall: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w400,
          height: 1.51,
          color: GRAY_COLOR,
        ),
        titleSmall: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          height: 1.51,
          color: GRAY_COLOR,
        ),
        titleMedium: TextStyle(
          fontSize: 14.sp,
          height: 1.51,
          fontWeight: FontWeight.w400,
          color: GRAY_COLOR,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: PRIMARY_COLOR,
      ));
}
