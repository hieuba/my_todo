import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo/screens/profile/setting/bloc/setting_event.dart';
import 'package:my_todo/screens/profile/setting/bloc/setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(const SettingState());
}
