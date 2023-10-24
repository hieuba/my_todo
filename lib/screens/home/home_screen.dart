import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_todo/utils/app_color.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(size, textTheme),
            _checkList(textTheme),
          ],
        ),
      ),
    );
  }
}

Widget _buildAppBar(Size size, TextTheme textTheme) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: H_PADDING),
    child: SizedBox(
      height: 42.h,
      width: size.width,
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 24.h,
                width: 24.w,
                child: Image.asset(
                  'assets/icons/sort.png',
                  fit: BoxFit.cover,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Index',
                  style: textTheme.displayMedium!
                      .copyWith(fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                height: 42.h,
                width: 40.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _checkList(TextTheme textTheme) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        margin: EdgeInsets.only(top: 100.h),
        height: 227.h,
        width: 227.w,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/check_list.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      SizedBox(height: 10.h),
      Text(
        'What do you want to do today?',
        style: textTheme.displayMedium!.copyWith(fontWeight: FontWeight.w400),
      ),
      SizedBox(height: 10.h),
      Text(
        'Tap + to add your tasks',
        style: textTheme.displaySmall,
      ),
    ],
  );
}
