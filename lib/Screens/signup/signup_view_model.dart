import 'package:firebase_auth/firebase_auth.dart';
import 'package:newtodo/Screens/signup/signup_view_connector.dart';
import 'package:newtodo/Shared/base.dart';
import 'package:newtodo/Shared/network/firebase/firebase_function.dart';

import '../../model/user_model.dart';

class SignUpViewModel extends BaseViewModel<SignUpConnector> {
  Future<void> signUp(
      String email, String password, String name, int age) async {
    connector!.showLoading();
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      //  FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      UserModel userModel = UserModel(
          name: name, id: credential.user!.uid, age: age, email: email);
      var collection = FirebaseFunctions.getUserCollection();
      var docRef = collection.doc(credential.user!.uid);
      docRef.set(userModel);
      connector!.hideDialog();
      connector!.goToHome();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print(e.message);
        connector!.hideDialog();

        connector!.showMessage(e.message ?? "");
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        connector!.hideDialog();

        connector!.showMessage(e.message ?? "");

        print('The account already exists for that email.');
      }
    } catch (e) {
      connector!.hideDialog();

      connector!.showMessage(e.toString());
    }
  }
}
