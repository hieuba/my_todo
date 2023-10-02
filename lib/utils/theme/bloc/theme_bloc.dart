import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:my_todo/utils/theme/bloc/theme_event.dart';
import 'package:my_todo/utils/theme/bloc/theme_state.dart';

class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInit(switchValue: false)) {
    on<ToggleOnEvent>((event, emit) {
      emit(ThemeState(switchValue: true));
    });

    on<ToggleOffEvent>((event, emit) {
      emit(ThemeState(switchValue: false));
    });
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    return ThemeState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    return state.toMap();
  }
}
