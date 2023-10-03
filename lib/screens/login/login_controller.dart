import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo/components/widgets/flutter_toast.dart';
import 'package:my_todo/screens/login/bloc/login_bloc.dart';

class LoginController {
  final BuildContext context;
  const LoginController({required this.context});

  Future<void> handleLogin(String type) async {
    try {
      if (type == 'email') {
        final state = context.read<LoginBloc>().state;
        final emailAddress = state.email;
        final password = state.password;

        if (emailAddress.isEmpty) {
          // email is empty
          toastInfo(message: 'snackbar_login.emailempty');
          return;
        }

        if (password.isEmpty) {
          // pass is empty
          toastInfo(message: 'snackbar_login.passwordempty');
          return;
        }

        //////
        try {
          final credential =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailAddress,
            password: password,
          );

          if (credential.user == null) {
            // user is null
            toastInfo(message: 'snackbar_login.usernotexits');
            return;
          }

          if (!credential.user!.emailVerified) {
            // user not verified
            toastInfo(message: 'snackbar_login.usernotverified');
            return;
          }

          var user = credential.user;

          if (user != null) {
            // we got verified user from firebase
            // ignore: avoid_print
            print('user exist');
          } else {
            // we have error getting user from firebase
            toastInfo(message: 'snackbar_login.error');
            // return;
          }
        } on FirebaseAuthException catch (e) {
          print(
              'FirebaseAuthException - code: ${e.code}, message: ${e.message}');
          if (e.code == 'user-not-found') {
            print('user not found');
            toastInfo(message: 'firebase_auth_exception.user_not_found');
          } else if (e.code == 'wrong-password') {
            print('sai mat khau');
            toastInfo(message: 'firebase_auth_exception.wrong_password');
          } else if (e.code == 'invalid-email') {
            print('email k hop le');
            toastInfo(message: 'firebase_auth_exception.invalid_email');
          }
        }
      }
    } catch (e) {
      //
    }
  }
}
