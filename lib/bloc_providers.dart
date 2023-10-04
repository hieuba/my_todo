import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo/screens/intro/bloc/intro_bloc.dart';
import 'package:my_todo/screens/login/bloc/login_bloc.dart';
import 'package:my_todo/screens/register/bloc/register_bloc.dart';
import 'package:my_todo/test-counter/bloc/counter_bloc.dart';
import 'package:my_todo/utils/theme/bloc/theme_bloc.dart';

class AppBlocProviders {
  static get allBlocProviders => [
        BlocProvider(
          create: (context) => IntroBloc(),
        ),
        BlocProvider(
          // lazy: false,
          create: (context) => ThemeBloc(),
        ),
        BlocProvider(
          // lazy: false,
          create: (context) => CounterBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
      ];
}
