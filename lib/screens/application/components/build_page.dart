// ignore_for_file: no_leading_underscores_for_local_identifiers, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_todo/screens/calendar/calendar.dart';
import 'package:my_todo/screens/home/home_screen.dart';
import 'package:my_todo/screens/profile/profile_screen.dart';

Widget buildPage(int index) {
  List<Widget> _widgets = [
    const HomeScreen(),
    const Calendar(),
    const Center(child: Text('abc')),
    const Center(child: Text('focus')),
    const ProfileScreen(),
  ];
  return _widgets[index];
}

List<BottomNavigationBarItem> bottomBar(BuildContext context, Color iconColor) {
  return [
    BottomNavigationBarItem(
      icon: SizedBox(
        height: 24.h,
        width: 24.w,
        child: SvgPicture.asset(
          'assets/svgs/home_outline.svg',
          color: iconColor,
        ),
      ),
      activeIcon: SizedBox(
        height: 24.h,
        width: 24.w,
        child: SvgPicture.asset(
          'assets/svgs/home-2.svg',
          color: iconColor,
        ),
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: SizedBox(
        height: 24.h,
        width: 24.w,
        child: SvgPicture.asset(
          'assets/svgs/calendar_outline.svg',
          color: iconColor,
        ),
      ),
      activeIcon: SizedBox(
        height: 24.h,
        width: 24.w,
        child: SvgPicture.asset(
          'assets/svgs/calendar.svg',
          color: iconColor,
        ),
      ),
      label: 'Calendar',
    ),
    const BottomNavigationBarItem(
      icon: SizedBox(width: 0), // Empty SizedBox as a placeholder
      label: '',
    ),
    BottomNavigationBarItem(
      icon: SizedBox(
        height: 24.h,
        width: 24.w,
        child: SvgPicture.asset(
          'assets/svgs/clock_outline.svg',
          color: iconColor,
        ),
      ),
      activeIcon: SizedBox(
        height: 24.h,
        width: 24.w,
        child: SvgPicture.asset(
          'assets/svgs/clock.svg',
          color: iconColor,
        ),
      ),
      label: 'Focus',
    ),
    BottomNavigationBarItem(
      icon: SizedBox(
        height: 24.h,
        width: 24.w,
        child: SvgPicture.asset(
          'assets/svgs/user_outline.svg',
          color: iconColor,
        ),
      ),
      activeIcon: SizedBox(
        height: 24.h,
        width: 24.w,
        child: SvgPicture.asset(
          'assets/svgs/user_outline.svg',
          color: iconColor,
        ),
      ),
      label: 'Profile',
    ),
  ];
}
