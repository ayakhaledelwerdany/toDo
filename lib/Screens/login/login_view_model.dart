import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newtodo/Screens/login/connector.dart';
import 'package:newtodo/Shared/base.dart';

class LoginViewModel extends BaseViewModel<LoginConnector> {
  Future<void> login(
    String email,
    String password,
  ) async {
    connector!.showLoading();
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        connector!.hideDialog();
        connector!.goToHome();
        //  onCompelete();
      });
    } on FirebaseAuthException catch (e) {
      connector!.hideDialog();
      connector!.showMessage(e.message ?? "");
      //  onError();
      print('Wrong Email or Password');
//if (e.code == 'user-not-found') {
      //  print('No user found for that email.');
      // } else if (e.code == 'wrong-password') {
      // print('Wrong password provided for that user.');
      // }
    }
  }
}
