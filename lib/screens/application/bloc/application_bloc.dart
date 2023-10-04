import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo/screens/application/bloc/application_event.dart';
import 'package:my_todo/screens/application/bloc/application_state.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  ApplicationBloc() : super(InitialApplication()) {
    on<TriggerAppEvent>(triggerAppEvent);
  }

  FutureOr<void> triggerAppEvent(
      TriggerAppEvent event, Emitter<ApplicationState> emit) {
    print('my tapped index: ${event.index}');
    emit(ApplicationState(index: event.index));
  }
}
