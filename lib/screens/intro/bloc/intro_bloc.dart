import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo/screens/intro/bloc/intro_event.dart';
import 'package:my_todo/screens/intro/bloc/intro_state.dart';

class IntroBloc extends Bloc<IntroEvent, IntroState> {
  IntroBloc() : super(IntroInit()) {
    print('intro bloc');
    on<IntroEvent>(introEvent);
  }

  FutureOr<void> introEvent(IntroEvent event, Emitter<IntroState> emit) {
    emit(IntroState(page: state.page));
  }
}
