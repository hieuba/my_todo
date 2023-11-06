import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:my_todo/components/widgets/build_divider.dart';
import 'package:my_todo/components/widgets/build_textfield.dart';
import 'package:my_todo/components/buttons/main_btn.dart';
import 'package:my_todo/components/buttons/outline_btn.dart';
import 'package:my_todo/components/widgets/reusable_text.dart';
import 'package:my_todo/main.dart';
import 'package:my_todo/screens/application/application.dart';
import 'package:my_todo/screens/login/bloc/login_event.dart';
import 'package:my_todo/screens/login/login_controller.dart';
import 'package:my_todo/utils/app_color.dart';

import 'bloc/login_bloc.dart';
import 'bloc/login_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        body: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return SafeArea(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAppBar(size, context),
                    SizedBox(height: 40.h),
                    Text(
                      tr('login_text.login'),
                      style: textTheme.displayLarge,
                    ),
                    SizedBox(height: 50.h),
                    // email
                    reusableText(
                      text: 'login_text.username',
                      textTheme: textTheme,
                    ),
                    SizedBox(height: 8.h),
                    buildTextField(
                      func: (value) {
                        context.read<LoginBloc>().add(EmailEvent(value));
                      },
                      hintText: 'Enter your email',
                      size: size,
                      textTheme: textTheme,
                      context: context,
                      type: 'username',
                    ),
                    SizedBox(height: 25.h),
                    // password
                    reusableText(
                      text: 'login_text.password',
                      textTheme: textTheme,
                    ),
                    SizedBox(height: 8.h),
                    buildTextField(
                      func: (value) {
                        context.read<LoginBloc>().add(PasswordEvent(value));
                      },
                      hintText: '••••••••',
                      size: size,
                      textTheme: textTheme,
                      context: context,
                      type: 'password',
                    ),
                    SizedBox(height: 70.h),
                    // login btn
                    mainBtn(
                      size: size,
                      text: 'login_text.login',
                      textTheme: textTheme,
                      onTap: () {
                        LoginController(context: context).handleLogin();
                      },
                    ),
                    SizedBox(height: 20.h),
                    divider(textTheme),
                    SizedBox(height: 20.h),
                    outlineBtn(
                      size: size,
                      textBtn: 'login_text.loginwithgg',
                      textTheme: textTheme,
                      type: 'google',
                      iconPath: 'assets/icons/google.png',
                      onTap: () {},
                    ),
                    SizedBox(height: 20.h),
                    outlineBtn(
                      size: size,
                      textBtn: 'login_text.loginwithap',
                      textTheme: textTheme,
                      type: 'apple',
                      iconPath: 'assets/icons/apple.png',
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ApplicationScreen(),
                        ));
                      },
                    ),
                    SizedBox(height: 40.h),
                    _buildCreateAccount(context, textTheme),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ));
          },
        ),
      ),
    );
  }
}

Widget _buildAppBar(Size size, BuildContext context) {
  return Container(
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

Widget _buildCreateAccount(BuildContext context, TextTheme textTheme) {
  return InkWell(
    onTap: () {
      Navigator.of(context).pushNamed('/register');
    },
    child: Center(
      child: RichText(
        text: TextSpan(
          text: tr('create_account.create'),
          style: textTheme.titleSmall!.copyWith(color: BGREY_COLOR),
          children: <TextSpan>[
            TextSpan(
                text: tr('create_account.register'),
                style: textTheme.titleSmall),
          ],
        ),
      ),
    ),
  );
}
