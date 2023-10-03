import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_todo/screens/application/components/build_page.dart';
import 'package:my_todo/utils/app_color.dart';

class ApplicationScreen extends StatefulWidget {
  const ApplicationScreen({super.key});

  @override
  State<ApplicationScreen> createState() => _ApplicationScreenState();
}

class _ApplicationScreenState extends State<ApplicationScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final _iconColor = Theme.of(context).brightness == Brightness.light
        ? Colors.black
        : Colors.white;
    return Scaffold(
      // backgroundColor: Colors.amber.shade100,
      body: buildPage(_index),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent, // Set splash color to transparent
          highlightColor:
              Colors.transparent, // Set highlight color to transparent
        ),
        child: BottomNavigationBar(
          mouseCursor: SystemMouseCursors.basic,
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? GRAY_COLOR
              : Color(0XFF363636),
          type: BottomNavigationBarType.fixed,
          currentIndex: _index,
          onTap: (value) {
            if (value != 2) {
              setState(() {
                _index = value;
              });
              print(value);
            }
          },
          elevation: 0,
          selectedItemColor: Colors.grey,
          unselectedItemColor: Colors.grey, // Color for unselected items
          items: [
            BottomNavigationBarItem(
              icon: SizedBox(
                height: 24.h,
                width: 24.w,
                child: Image.asset(
                  'assets/icons/home_outline.png',
                  color: _iconColor,
                ),
              ),
              activeIcon: SizedBox(
                height: 24.h,
                width: 24.w,
                child: Image.asset(
                  'assets/icons/home.png',
                  color: _iconColor,
                ),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                height: 24.h,
                width: 24.w,
                child: Image.asset(
                  'assets/icons/user_outline.png',
                  color: _iconColor,
                ),
              ),
              activeIcon: SizedBox(
                height: 24.h,
                width: 24.w,
                child: Image.asset(
                  'assets/icons/user.png',
                  color: _iconColor,
                ),
              ),
              label: 'Person',
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
                  'assets/icons/user_outline.png',
                  color: _iconColor,
                ),
              ),
              activeIcon: SizedBox(
                height: 24.h,
                width: 24.w,
                child: Image.asset(
                  'assets/icons/user.png',
                  color: _iconColor,
                ),
              ),
              label: 'Person',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                height: 24.h,
                width: 24.w,
                child: Image.asset(
                  'assets/icons/user_outline.png',
                  color: _iconColor,
                ),
              ),
              activeIcon: SizedBox(
                height: 24.h,
                width: 24.w,
                child: Image.asset(
                  'assets/icons/user.png',
                  color: _iconColor,
                ),
              ),
              label: 'Person',
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
    );
  }
}
