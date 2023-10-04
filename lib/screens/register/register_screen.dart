import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_todo/components/widgets/build_divider.dart';
import 'package:my_todo/components/widgets/build_textfield.dart';
import 'package:my_todo/components/buttons/main_btn.dart';
import 'package:my_todo/components/buttons/outline_btn.dart';
import 'package:my_todo/components/widgets/reusable_text.dart';
import 'package:my_todo/screens/login/login_screen.dart';
import 'package:my_todo/screens/register/bloc/register_bloc.dart';
import 'package:my_todo/screens/register/bloc/register_event.dart';
import 'package:my_todo/screens/register/bloc/register_state.dart';
import 'package:my_todo/screens/register/register_controller.dart';
import 'package:my_todo/utils/app_color.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        body: BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            return SafeArea(
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
                    // user name
                    reusableText(
                      text: 'login_text.username',
                      textTheme: textTheme,
                    ),
                    SizedBox(height: 8.h),
                    buildTextField(
                      func: (value) {
                        context.read<RegisterBloc>().add(EmailEvent(value));
                      },
                      hintText: 'Enter your email',
                      size: size,
                      textTheme: textTheme,
                      context: context,
                      type: 'username',
                    ),
                    SizedBox(height: 20.h),
                    // password
                    reusableText(
                      text: 'login_text.password',
                      textTheme: textTheme,
                    ),
                    SizedBox(height: 8.h),
                    buildTextField(
                      func: (value) {
                        context.read<RegisterBloc>().add(PasswordEvent(value));
                      },
                      hintText: '••••••••',
                      size: size,
                      textTheme: textTheme,
                      context: context,
                      type: 'password',
                    ),
                    SizedBox(height: 20.h),
                    // rePassword
                    reusableText(
                      text: 'create_account.repassword',
                      textTheme: textTheme,
                    ),
                    SizedBox(height: 8.h),
                    buildTextField(
                      func: (value) {
                        context
                            .read<RegisterBloc>()
                            .add(RePasswordEvent(value));
                      },
                      hintText: '••••••••',
                      size: size,
                      textTheme: textTheme,
                      context: context,
                      type: 'password',
                    ),
                    SizedBox(height: 40.h),

                    // register btn
                    mainBtn(
                      size: size,
                      text: 'create_account.register',
                      textTheme: textTheme,
                      onTap: () {
                        RegisterController(context: context).handleRegister();
                      },
                    ),
                    SizedBox(height: 20.h),
                    // --------------------- //
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
                      onTap: () {},
                    ),
                    SizedBox(height: 40.h),
                    _buildCreateAccount(
                      context: context,
                      textTheme: textTheme,
                      text1: "create_account.alreadyacc",
                      text2: "login_text.login",
                    ),
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

Widget _buildCreateAccount({
  required BuildContext context,
  required TextTheme textTheme,
  required String text1,
  required String text2,
}) {
  return InkWell(
    onTap: () {
      Navigator.of(context).pushNamed('/login');
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
