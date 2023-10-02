import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo/test-counter/bloc/counter_event.dart';
import 'package:my_todo/test-counter/bloc/counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInit()) {
    print('counter bloc');
    on<IncrementEvent>(incrementEvent);
    on<DecrementEvent>(decrementEvent);
  }

  FutureOr<void> incrementEvent(
      IncrementEvent event, Emitter<CounterState> emit) {
    emit(CounterState(number: state.number + 1));
  }

  FutureOr<void> decrementEvent(
      DecrementEvent event, Emitter<CounterState> emit) {
    emit(CounterState(number: state.number - 1));
  }
}
