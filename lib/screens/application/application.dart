import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_todo/screens/application/bloc/application_bloc.dart';
import 'package:my_todo/screens/application/bloc/application_event.dart';
import 'package:my_todo/screens/application/bloc/application_state.dart';
import 'package:my_todo/screens/application/components/build_page.dart';
import 'package:my_todo/utils/app_color.dart';

class ApplicationScreen extends StatefulWidget {
  const ApplicationScreen({super.key});

  @override
  State<ApplicationScreen> createState() => _ApplicationScreenState();
}

class _ApplicationScreenState extends State<ApplicationScreen> {
  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final iconColor = Theme.of(context).brightness == Brightness.light
        ? BLACK_COLOR
        : WHITE_COLOR;
    return BlocBuilder<ApplicationBloc, ApplicationState>(
      builder: (context, state) {
        return Scaffold(
          body: buildPage(state.index),
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              splashColor:
                  Colors.transparent, // Set splash color to transparent
              highlightColor:
                  Colors.transparent, // Set highlight color to transparent
            ),
            child: BottomNavigationBar(
              elevation: 0,
              selectedItemColor: iconColor,
              unselectedItemColor: iconColor,
              selectedFontSize: 12.sp,
              unselectedFontSize: 12.sp,
              backgroundColor: Theme.of(context).brightness == Brightness.light
                  ? Colors.grey.shade200
                  : const Color(0XFF363636),
              type: BottomNavigationBarType.fixed,
              currentIndex: state.index,
              onTap: (value) {
                if (value != 2) {
                  context.read<ApplicationBloc>().add(TriggerAppEvent(value));
                }
              },
              items: bottomBar(context, iconColor),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(
              Icons.add,
              color: WHITE_COLOR,
            ),
          ),
        );
      },
    );
  }
}
