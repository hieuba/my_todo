import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildPage(int index) {
  List<Widget> _widgets = [
    Center(child: Text('index')),
    Center(child: Text('calendar')),
    Center(child: Text('abc')),
    Center(child: Text('focus')),
    Center(child: Text('profile')),
  ];
  return _widgets[index];
}

List<BottomNavigationBarItem> bottomBar(BuildContext context, Color iconColor) {
  return [
    BottomNavigationBarItem(
      icon: SizedBox(
        height: 24.h,
        width: 24.w,
        child: Image.asset(
          'assets/icons/home_outline.png',
          color: iconColor,
        ),
      ),
      activeIcon: SizedBox(
        height: 24.h,
        width: 24.w,
        child: Image.asset(
          'assets/icons/home.png',
          color: iconColor,
        ),
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: SizedBox(
        height: 24.h,
        width: 24.w,
        child: Image.asset(
          'assets/icons/calendar_outline.png',
          color: iconColor,
        ),
      ),
      activeIcon: SizedBox(
        height: 24.h,
        width: 24.w,
        child: Image.asset(
          'assets/icons/calendar.png',
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
        child: Image.asset(
          'assets/icons/clock_outline.png',
          color: iconColor,
        ),
      ),
      activeIcon: SizedBox(
        height: 24.h,
        width: 24.w,
        child: Image.asset(
          'assets/icons/clock.png',
          color: iconColor,
        ),
      ),
      label: 'Focus',
    ),
    BottomNavigationBarItem(
      icon: SizedBox(
        height: 24.h,
        width: 24.w,
        child: Image.asset(
          'assets/icons/user_outline.png',
          color: iconColor,
        ),
      ),
      activeIcon: SizedBox(
        height: 24.h,
        width: 24.w,
        child: Image.asset(
          'assets/icons/user.png',
          color: iconColor,
        ),
      ),
      label: 'Profile',
    ),
  ];
}
