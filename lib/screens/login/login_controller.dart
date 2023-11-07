// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo/components/widgets/flutter_toast.dart';
import 'package:my_todo/global.dart';
import 'package:my_todo/screens/login/bloc/login_bloc.dart';
import 'package:my_todo/services/firebase_auth_sevice.dart';
import 'package:my_todo/utils/constans.dart';

class LoginController {
  final BuildContext context;
  late OverlayEntry _overlayEntry;
  var db = FirebaseFirestore.instance;
  LoginController({
    required this.context,
  });

  void _showLoading() {
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return const Stack(
          children: <Widget>[
            ModalBarrier(
              color: Colors.black54,
              dismissible: false,
            ),
            Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          ],
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry);
  }

  void _hideLoading() {
    _overlayEntry.remove();
  }

  Future<void> handleLogin() async {
    try {
      // Hiển thị vòng quay chờ đợi
      _showLoading();
      final state = context.read<LoginBloc>().state;
      final emailAddress = state.email;
      final password = state.password;

      if (emailAddress.isEmpty) {
        _hideLoading(); // Ẩn vòng quay chờ đợi
        // email is empty
        toastInfo(message: 'snackbar_login.emailempty');
        return;
      }

      if (password.isEmpty) {
        _hideLoading(); // Ẩn vòng quay chờ đợi
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
          final token = await getFirebaseAuthToken();
          // Add a new document with a generated ID

          print('token: $token');
          if (token != null) {
            Global.storageService
                .setString(AppConstants.STORAGE_USER_TOKEN_KEY, token);
          }

          // we got verified user from firebase
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/application', (route) => false);
          print('user exist');
        } else {
          // we have error getting user from firebase
          toastInfo(message: 'snackbar_login.error');
          // return;
        }
        _hideLoading();
      } on FirebaseAuthException catch (e) {
        print('FirebaseAuthException - code: ${e.code}, message: ${e.message}');
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
        _hideLoading();
      }
    } catch (e) {
      //
    }
  }
}
