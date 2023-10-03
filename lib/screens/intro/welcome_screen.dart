import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_todo/components/buttons/main_btn.dart';
import 'package:my_todo/components/buttons/outline_btn.dart';
import 'package:my_todo/utils/app_color.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            _buildAppBar(size, context),
            SizedBox(height: 58.h),
            Text(
              'Welcome to UpTodo',
              style: textTheme.displayLarge,
            ),
            SizedBox(height: 26.h),
            Text(
              'Please login to your account or create new account to continue',
              style: textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            mainBtn(
              size: size,
              text: 'button_text.login',
              textTheme: textTheme,
              onTap: () {
                Navigator.pushNamed(context, 'login');
              },
            ),
            SizedBox(height: 28.h),
            outlineBtn(size, 'button_text.register', textTheme, 'register', '',
                () {
              Navigator.pushNamed(context, 'register');
            }),
            SizedBox(height: 10.h),
          ],
        ),
      )),
    );
  }

  Widget _buildAppBar(Size size, BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: 45.h,
      width: size.width,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          alignment: Alignment.centerLeft,
          height: 45.h,
          width: 45.w,
          child: Image.asset(
            'assets/icons/arrow-left.png',
            color: Theme.of(context).brightness == Brightness.light
                ? BLACK_COLOR
                : GRAY_COLOR,
          ),
        ),
      ),
    );
  }
}
