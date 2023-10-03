import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo/screens/login/bloc/login_event.dart';
import 'package:my_todo/screens/login/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<EmailEvent>(_emailEvent);

    on<PasswordEvent>(_passwordEvent);
  }

  FutureOr<void> _emailEvent(EmailEvent event, Emitter<LoginState> emit) {
    // print('my email: ${event.email}');
    emit(state.copyWith(email: event.email));
  }

  FutureOr<void> _passwordEvent(PasswordEvent event, Emitter<LoginState> emit) {
    // print('my password: ${event.password}');
    emit(state.copyWith(password: event.password));
  }
}
