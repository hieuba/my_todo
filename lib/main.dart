import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:my_todo/localization_checker.dart';
import 'package:my_todo/screens/intro/intro_screen.dart';
import 'package:my_todo/test-counter/bloc/counter_bloc.dart';
import 'package:my_todo/test-counter/bloc/counter_event.dart';
import 'package:my_todo/test-counter/bloc/counter_state.dart';
import 'package:my_todo/utils/theme/bloc/theme_bloc.dart';
import 'package:my_todo/utils/theme/bloc/theme_event.dart';
import 'package:my_todo/utils/theme/bloc/theme_state.dart';
import 'package:my_todo/utils/app_theme.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('vi', 'VN'),
        Locale('en', 'US'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('vi', 'VN'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider(
          create: (context) => CounterBloc(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp(
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                debugShowCheckedModeBanner: false,
                home: const HomePage(),
                theme: state.switchValue
                    ? AppTheme.darkTheme
                    : AppTheme.lightTheme,
              );
            },
          );
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr('title')), actions: [
        IconButton(
            onPressed: () {
              LocalizationChecker.changeLanguage(context);
            },
            icon: const Icon(Icons.swap_calls)),
        BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return Switch.adaptive(
              value: state.switchValue,
              onChanged: (value) {
                value
                    ? context.read<ThemeBloc>().add(ToggleOnEvent())
                    : context.read<ThemeBloc>().add(ToggleOffEvent());
              },
            );
          },
        ),
      ]),
      body: Center(
        child: Column(
          children: [
            Text('${'name'.tr()} : haha'),
            Text('${tr("gender.male")}'),
            Divider(),
            BlocBuilder<CounterBloc, CounterState>(
              builder: (context, state) {
                return Text(BlocProvider.of<CounterBloc>(context)
                    .state
                    .number
                    .toString());
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      BlocProvider.of<CounterBloc>(context)
                          .add(IncrementEvent());
                    },
                    icon: const Icon(Icons.add)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.remove))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
