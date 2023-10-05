// ignore_for_file: avoid_print

import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_todo/components/buttons/small_btn.dart';
import 'package:my_todo/components/buttons/text_btn.dart';
import 'package:my_todo/global.dart';
import 'package:my_todo/screens/intro/bloc/intro_bloc.dart';
import 'package:my_todo/screens/intro/bloc/intro_event.dart';
import 'package:my_todo/screens/intro/bloc/intro_state.dart';
import 'package:my_todo/screens/intro/welcome_screen.dart';
import 'package:my_todo/utils/app_color.dart';
import 'package:my_todo/utils/constans.dart';
import 'package:page_transition/page_transition.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var textTheme = Theme.of(context).textTheme;

    bool onLastPage = false;

    return BlocBuilder<IntroBloc, IntroState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              width: size.width,
              margin: EdgeInsets.symmetric(horizontal: 24.w),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // page view
                  PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      // onlastpage
                      onLastPage = (index == 2);

                      state.page = index;
                      // BlocProvider.of<IntroBloc>(context).add(IntroEvent());
                      context.read<IntroBloc>().add(IntroEvent());
                    },
                    children: [
                      _buildPage(
                        index: 1,
                        textTheme: textTheme,
                        size: size,
                        onLastPage: false,
                        imagePath: 'assets/images/intro/intro1.png',
                        title: 'Manage your tasks',
                        subTitle:
                            'You can easily manage all of your daily tasks in DoMe for free',
                      ),
                      _buildPage(
                        index: 2,
                        textTheme: textTheme,
                        size: size,
                        onLastPage: false,
                        imagePath: 'assets/images/intro/intro2.png',
                        title: 'Create daily routine',
                        subTitle:
                            'In Uptodo you can create your personalized routine to stay productive',
                      ),
                      _buildPage(
                        index: 3,
                        textTheme: textTheme,
                        size: size,
                        onLastPage: true,
                        imagePath: 'assets/images/intro/intro3.png',
                        title: 'Orgonaize your tasks',
                        subTitle:
                            'You can organize your daily tasks by adding your tasks into separate categories',
                      ),
                    ],
                  ),
                  // dot indicator
                  _buildDotIndicator(state: state),
                  // skip btn
                  onLastPage
                      ? const SizedBox()
                      : _skipBtn(textTheme: textTheme),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _skipBtn({required TextTheme textTheme}) {
    return Positioned(
      top: 0,
      left: 0,
      child: TextButton(
        onPressed: () {
          _pageController.animateToPage(3,
              duration: const Duration(milliseconds: 400),
              curve: Curves.decelerate);
        },
        child: Text(
          tr('button_text.skip'),
          style: textTheme.titleSmall,
        ),
      ),
    );
  }

  Widget _buildDotIndicator({required IntroState state}) {
    return Positioned(
      child: DotsIndicator(
        mainAxisAlignment: MainAxisAlignment.center,
        position: state.page,
        dotsCount: 3,
        decorator: DotsDecorator(
          activeColor: PRIMARY_COLOR,
          size: Size(25.w, 4.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          activeSize: Size(25.w, 4.h),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }

  Widget _buildPage({
    required index,
    required TextTheme textTheme,
    required Size size,
    required bool onLastPage,
    required String imagePath,
    required String title,
    required String subTitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 345.h,
          width: 345.w,
          child: Image.asset(
            imagePath,
          ),
        ),
        SizedBox(height: 45.h),
        Text(
          title,
          style: textTheme.displayLarge,
        ),
        SizedBox(height: 42.h),
        Text(
          subTitle,
          style: textTheme.titleSmall,
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            index == 1
                ? const SizedBox()
                : textdBtn(size, 'button_text.back', textTheme, () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.decelerate,
                    );
                  }),
            smalldBtn(onLastPage, size, 'button_text.next', textTheme, () {
              // index 0 - 2,
              if (index < 3) {
                // animation
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.decelerate,
                );
              } else {
                // khi ấn vào đây thì app đã được mở lần đầu
                Global.storageService
                    .setBool(AppConstants.STORAGE_DEVICE_OPEN_FIRST_TIME, true);
                print(
                    'the value is: ${Global.storageService.getDeviceFirstOpen()}');

                Navigator.of(context).push(
                  PageTransition(
                    child: const WelcomeScreen(),
                    type: PageTransitionType.bottomToTop,
                  ),
                );
              }
            }),
          ],
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}
