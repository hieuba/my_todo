import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo/components/widgets/flutter_toast.dart';
import 'package:my_todo/screens/register/bloc/register_bloc.dart';

class RegisterController {
  final BuildContext context;

  const RegisterController({required this.context});

  void handleRegister() async {
    try {
      final state = context.read<RegisterBloc>().state;

      final emailAddress = state.email;
      final password = state.password;
      final rePassword = state.rePassword;

      if (emailAddress.isEmpty) {
        // emailAddress is empty
        toastInfo(message: 'snackbar_login.emailempty');
        return;
      }

      if (password.isEmpty) {
        // password is empty
        toastInfo(message: 'snackbar_login.passwordempty');
        return;
      }
      if (rePassword.isEmpty) {
        // repassword is empty
        toastInfo(message: 'snackbar_login.re_passwordempty');
        return;
      }
      if (password != rePassword) {
        print('mat khau khog khop');
        return;
      }

      // firebase auth with createUserWithEmailAndPassword
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailAddress,
          password: password,
        );
        if (credential.user != null) {
          await credential.user!.sendEmailVerification();
          print('kiem tra email de xac thuc tai khoan');
          Navigator.of(context).popAndPushNamed('login');
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          print('email nay da duoc su dung');
        } else if (e.code == 'invalid-email') {
          print("email khong dung dinh dang");
        } else if (e.code == 'weak-password') {
          print('mat khau yeu');
        }
      }
    } catch (e) {
      //
    }
  }
}
