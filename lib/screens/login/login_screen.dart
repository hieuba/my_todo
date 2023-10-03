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
                    reusableText(
                        text: 'login_text.username', textTheme: textTheme),
                    SizedBox(height: 8.h),
                    buildTextField((value) {
                      context.read<LoginBloc>().add(EmailEvent(value));
                    }, 'Enter your username', size, textTheme, context,
                        'username'),
                    SizedBox(height: 25.h),
                    reusableText(
                        text: 'login_text.password', textTheme: textTheme),
                    SizedBox(height: 8.h),
                    buildTextField((value) {
                      print(value);
                      context.read<LoginBloc>().add(PasswordEvent(value));
                    }, '••••••••', size, textTheme, context, 'password'),
                    SizedBox(height: 70.h),
                    mainBtn(
                        size: size,
                        text: 'login_text.login',
                        textTheme: textTheme,
                        onTap: () {
                          LoginController(context: context)
                              .handleLogin('email');
                        }),
                    SizedBox(height: 20.h),
                    divider(textTheme),
                    SizedBox(height: 20.h),
                    outlineBtn(size, 'login_text.loginwithgg', textTheme,
                        'google', 'assets/icons/google.png', () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ));
                    }),
                    SizedBox(height: 20.h),
                    outlineBtn(size, 'login_text.loginwithap', textTheme,
                        'apple', 'assets/icons/apple.png', () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ApplicationScreen(),
                      ));
                    }),
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

Widget _buildCreateAccount(BuildContext context, TextTheme textTheme) {
  return InkWell(
    onTap: () {
      Navigator.of(context).pushNamed('register');
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
