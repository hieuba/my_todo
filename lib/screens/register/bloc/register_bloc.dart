import 'dart:async';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:my_todo/screens/register/bloc/register_event.dart';
import 'package:my_todo/screens/register/bloc/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterState()) {
    on<EmailEvent>(emailEvent);

    on<PasswordEvent>(passWordEvent);

    on<RePasswordEvent>(rePassWordEvent);
  }

  FutureOr<void> emailEvent(EmailEvent event, Emitter<RegisterState> emit) {
    print('email: ${event.email}');
    emit(state.copyWith(email: event.email));
  }

  FutureOr<void> passWordEvent(
      PasswordEvent event, Emitter<RegisterState> emit) {
    print('password: ${event.password}');
    emit(state.copyWith(password: event.password));
  }

  FutureOr<void> rePassWordEvent(
      RePasswordEvent event, Emitter<RegisterState> emit) {
    print('repassword: ${event.rePassword}');
    emit(state.copyWith(rePassword: event.rePassword));
  }
}
