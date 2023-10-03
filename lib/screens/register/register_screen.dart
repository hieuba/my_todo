import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_todo/components/widgets/build_divider.dart';
import 'package:my_todo/components/widgets/build_textfield.dart';
import 'package:my_todo/components/buttons/main_btn.dart';
import 'package:my_todo/components/buttons/outline_btn.dart';
import 'package:my_todo/components/widgets/reusable_text.dart';
import 'package:my_todo/screens/login/login_screen.dart';
import 'package:my_todo/utils/app_color.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBar(size, context),
              SizedBox(height: 5.h),
              Text(
                tr('create_account.register'),
                style: textTheme.displayLarge,
              ),
              SizedBox(height: 15.h),
              reusableText(text: 'login_text.username', textTheme: textTheme),
              SizedBox(height: 8.h),
              buildTextField((value) {}, 'Enter your username', size, textTheme,
                  context, 'username'),
              SizedBox(height: 20.h),
              reusableText(text: 'login_text.password', textTheme: textTheme),
              SizedBox(height: 8.h),
              buildTextField(
                  (value) {}, '••••••••', size, textTheme, context, 'password'),
              SizedBox(height: 20.h),
              reusableText(
                  text: 'create_account.repassword', textTheme: textTheme),
              SizedBox(height: 8.h),
              buildTextField(
                  (value) {}, '••••••••', size, textTheme, context, 'password'),
              SizedBox(height: 40.h),
              mainBtn(
                  size: size,
                  text: 'create_account.register',
                  textTheme: textTheme,
                  onTap: () {}),
              SizedBox(height: 20.h),
              divider(textTheme),
              SizedBox(height: 20.h),
              outlineBtn(size, 'login_text.loginwithgg', textTheme, 'google',
                  'assets/icons/google.png', () {}),
              SizedBox(height: 20.h),
              outlineBtn(size, 'login_text.loginwithap', textTheme, 'apple',
                  'assets/icons/apple.png', () {}),
              SizedBox(height: 40.h),
              _buildCreateAccount(context, textTheme,
                  "create_account.alreadyacc", "login_text.login"),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      )),
    );
  }
}

Widget _buildAppBar(Size size, BuildContext context) {
  return Container(
    // color: Colors.amber.shade300,
    alignment: Alignment.centerLeft,
    height: 45.h,
    width: size.width,
    child: InkWell(
      onTap: () {
        Navigator.of(context).pop();
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

Widget _buildCreateAccount(
    BuildContext context, TextTheme textTheme, String text1, String text2) {
  return InkWell(
    onTap: () {
      Navigator.of(context).pushNamed('login');
    },
    child: Center(
      child: RichText(
        text: TextSpan(
          text: tr(text1),
          // text: tr('create_account.create'),
          style: textTheme.titleSmall!.copyWith(color: BGREY_COLOR),
          children: <TextSpan>[
            TextSpan(
                text: tr(text2),
                // text: tr('create_account.register'),
                style: textTheme.titleSmall),
          ],
        ),
      ),
    ),
  );
}
