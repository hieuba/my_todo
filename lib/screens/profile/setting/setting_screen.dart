import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_todo/screens/profile/components/build_item.dart';
import 'package:my_todo/screens/profile/components/reuse_text.dart';
import 'package:my_todo/screens/profile/setting/bloc/setting_bloc.dart';
import 'package:my_todo/screens/profile/setting/bloc/setting_state.dart';
import 'package:my_todo/utils/app_color.dart';
import 'package:my_todo/utils/theme/bloc/theme_bloc.dart';
import 'package:my_todo/utils/theme/bloc/theme_event.dart';
import 'package:my_todo/utils/theme/bloc/theme_state.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  Locale? currentLocale;

  @override
  void didChangeDependencies() {
    currentLocale = EasyLocalization.of(context)!.currentLocale;
    super.didChangeDependencies();
  }

  void setLanguage(Locale newLocale) {
    setState(() {
      currentLocale = newLocale;
    });
    EasyLocalization.of(context)!.setLocale(newLocale);
  }

  bool isLightThemeSelected = true;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var textTheme = Theme.of(context).textTheme;
    return BlocBuilder<SettingBloc, SettingState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBar(size, context, textTheme),
              SizedBox(height: 20.h),
              reusableText(text: 'profile.settings', textTheme: textTheme),
              // change theme
              buildItem(
                context: context,
                size: size,
                textTheme: textTheme,
                text: tr('bottomsheet.theme'),
                iconPath: 'assets/icons/brush.png',
                onTap: () {
                  showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                    context: context,
                    builder: (context) {
                      return _buildChangeTheme(textTheme);
                    },
                  );
                },
              ),
              // change language
              buildItem(
                context: context,
                size: size,
                textTheme: textTheme,
                text: tr('bottomsheet.language'),
                iconPath: 'assets/icons/language-square.png',
                onTap: () {
                  showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                    context: context,
                    builder: (context) {
                      return _buildChangeLanguage(textTheme);
                    },
                  );
                },
              ),
              reusableText(text: 'Import', textTheme: textTheme),
              buildItem(
                context: context,
                size: size,
                textTheme: textTheme,
                text: 'Import from Google calendar',
                iconPath: 'assets/icons/import.png',
                onTap: () {},
              ),
            ],
          )),
        );
      },
    );
  }

  Widget _buildChangeTheme(TextTheme textTheme) {
    return SizedBox(
      height: 200.h,
      child: Column(
        children: [
          SizedBox(
            height: 35.h,
            child: Center(
              child: Container(
                height: 5.h,
                width: 50.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: PRIMARY_COLOR,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Text(tr('bottomsheet.theme'),
                style: textTheme.titleSmall!
                    .copyWith(fontWeight: FontWeight.w700)),
          ),
          const Divider(),
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return Card(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  height: 50.h,
                  child: Row(
                    children: [
                      SizedBox(width: 10.w),
                      Card(
                        color: Colors.transparent,
                        child: Text(
                          tr(
                            'bottomsheet.text_theme',
                          ),
                          style: textTheme.titleSmall,
                        ),
                      ),
                      // light theme
                      GestureDetector(
                        onTap: () {
                          isLightThemeSelected = true;
                          context.read<ThemeBloc>().add(ToggleOffEvent());
                        },
                        child: Card(
                          color: isLightThemeSelected
                              ? PRIMARY_COLOR
                              : Colors.transparent,
                          child: SizedBox(
                            height: 24.h,
                            width: 50.w,
                            child: Center(
                              child: Text(
                                tr('bottomsheet.light'),
                                style: textTheme.titleMedium,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // dark theme
                      GestureDetector(
                        onTap: () {
                          isLightThemeSelected = false;
                          context.read<ThemeBloc>().add(ToggleOnEvent());
                        },
                        child: Card(
                          color: isLightThemeSelected
                              ? Colors.transparent
                              : PRIMARY_COLOR,
                          child: SizedBox(
                            height: 24.h,
                            width: 50.w,
                            child: Center(
                              child: Text(
                                tr('bottomsheet.dark'),
                                style: textTheme.titleMedium,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildChangeLanguage(TextTheme textTheme) {
    return SizedBox(
      height: 250.h,
      child: Column(
        children: [
          SizedBox(
            height: 35.h,
            child: Center(
              child: Container(
                height: 5.h,
                width: 50.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: PRIMARY_COLOR,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Text(tr('bottomsheet.language'),
                style: textTheme.titleSmall!
                    .copyWith(fontWeight: FontWeight.w700)),
          ),
          const Divider(),
          _buildLanguageItem(
            text: 'Việt Nam',
            locale: const Locale('vi', 'VN'),
            iconPath: 'assets/icons/viet.png',
          ),
          _buildLanguageItem(
            text: 'English',
            locale: const Locale('en', 'US'),
            iconPath: 'assets/icons/usa.png',
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageItem(
      {required String text,
      required Locale locale,
      required String iconPath}) {
    return GestureDetector(
      onTap: () {
        setLanguage(locale);
      },
      child: Card(
        child: Container(
          margin: const EdgeInsets.all(5),
          height: 50.h,
          child: Row(
            children: [
              SizedBox(width: 10.w),
              SizedBox(
                height: 24.h,
                width: 24.w,
                child: Image.asset(iconPath),
              ),
              SizedBox(width: 10.h),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: currentLocale == locale
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
              const Spacer(),
              currentLocale == locale
                  ? const Icon(
                      Icons.check,
                      color: PRIMARY_COLOR,
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildAppBar(
  Size size,
  BuildContext context,
  TextTheme textTheme,
) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: H_PADDING),
    child: Container(
      alignment: Alignment.centerLeft,
      height: 45.h,
      width: size.width,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Stack(
          children: [
            Container(
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
            Align(
              alignment: Alignment.center,
              child: Text(
                tr('profile.settings'),
                style: textTheme.displayMedium!
                    .copyWith(fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
