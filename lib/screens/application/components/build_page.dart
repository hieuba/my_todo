import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_todo/screens/home/home_screen.dart';
import 'package:my_todo/screens/profile/profile_screen.dart';

Widget buildPage(int index) {
  List<Widget> _widgets = [
    const HomeScreen(),
    const Center(child: Text('calendar')),
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
