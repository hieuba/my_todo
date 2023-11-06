// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo/global.dart';
import 'package:my_todo/routes/names.dart';
import 'package:my_todo/screens/application/application.dart';
import 'package:my_todo/screens/application/bloc/application_bloc.dart';
import 'package:my_todo/screens/home/home_screen.dart';
import 'package:my_todo/screens/home/task/bloc/task_bloc.dart';
import 'package:my_todo/screens/intro/bloc/intro_bloc.dart';
import 'package:my_todo/screens/intro/intro_screen.dart';
import 'package:my_todo/screens/intro/welcome_screen.dart';
import 'package:my_todo/screens/login/bloc/login_bloc.dart';
import 'package:my_todo/screens/login/login_screen.dart';
import 'package:my_todo/screens/profile/setting/bloc/setting_bloc.dart';
import 'package:my_todo/screens/profile/setting/setting_screen.dart';
import 'package:my_todo/screens/register/bloc/register_bloc.dart';
import 'package:my_todo/screens/register/register_screen.dart';
import 'package:my_todo/utils/theme/bloc/theme_bloc.dart';

class PageEntity {
  String? route;
  Widget? page;
  dynamic bloc;

  PageEntity({
    this.route,
    this.page,
    this.bloc,
  });
}

class AppPages {
  static List<PageEntity> routes() {
    return [
      PageEntity(
        route: AppRoutes.INITIAL,
        page: const IntroScreen(),
        bloc: BlocProvider(
          lazy: false,
          create: (context) => IntroBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.LOG_IN,
        page: const LoginScreen(),
        bloc: BlocProvider(
          create: (context) => LoginBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.REGISTER,
        page: const RegisterScreen(),
        bloc: BlocProvider(
          create: (context) => RegisterBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.APPLICATION,
        page: const ApplicationScreen(),
        bloc: BlocProvider(
          create: (context) => ApplicationBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.SETTINGS,
        page: const SettingScreen(),
        bloc: BlocProvider(
          create: (context) => SettingBloc(),
        ),
      ),
      PageEntity(
        bloc: BlocProvider(
          create: (context) => ThemeBloc(),
        ),
      ),
      PageEntity(
        // route: AppRoutes.HOMEPAGE,
        // page: const HomeScreen(),
        bloc: BlocProvider(
          create: (context) => TaskBloc(),
        ),
      ),
    ];
  }

  /// lấy danh sách phần từ blocprovider
  static List<dynamic> allBlocProviders(BuildContext context) {
    List<dynamic> blocProvider = [];

    for (var blocItem in routes()) {
      blocProvider.add(blocItem.bloc);
    }
    return blocProvider;
  }

  static MaterialPageRoute GeneratePageRouteSettings(RouteSettings settings) {
    print('settings.name: ${settings.name}'); // default "/"

    if (settings.name != null) {
      // Kiểm tra sự trùng khớp của route khi navigator được kích hoạt
      var result = routes().where((element) => element.route == settings.name);

      if (result.isNotEmpty) {
        print('first log');

        // đặt tên biến => đây là app đã được mở lần đầu
        bool deviceFirstOpen =
            Global.storageService.getDeviceFirstOpen(); // true => app da dc mo
        print("result.first.route: ${result.first.route}"); // => /

        // nếu app đã được mở lần đầu, thì bắt đầu ở WelcomeScreen
        if (result.first.route == AppRoutes.INITIAL && deviceFirstOpen) {
          print("second log");

          /// b1: kiểm tra nếu app đã đăng nhập thì vào applicationScreen
          // kiểm tra app đã được đang nhập chưa
          bool isLoggedIn = Global.storageService.isLoggedIn();
          print('app da nhap chua: $isLoggedIn');

          if (isLoggedIn) {
            return MaterialPageRoute(
              builder: (context) => const ApplicationScreen(),
            );
          }

          /// b2: nếu chưa thì kiểm tra deviceFirstOpen : nếu true thì vào màn welcome/login
          return MaterialPageRoute(
            builder: (context) => const WelcomeScreen(),
          );
        }
        print('result.first.page: ${result.first.page}');
        return MaterialPageRoute(
            builder: (context) => result.first.page!, settings: settings);
      }
    }
    // nếu route không tồn tại => điều hướng về trang login
    print('invalid ${settings.name}');
    return MaterialPageRoute(
      builder: (context) => const WelcomeScreen(),
    );
  }
}
