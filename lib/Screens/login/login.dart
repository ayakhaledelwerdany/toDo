import 'package:flutter/material.dart';
import 'package:newtodo/Screens/login/connector.dart';
import 'package:newtodo/Screens/login/login_view_model.dart';
import 'package:newtodo/Shared/base.dart';
import 'package:provider/provider.dart';

import '../../Home_layout/HomeLayout.dart';
import '../../Shared/network/firebase/firebase_function.dart';
import '../../provider/my_provider.dart';
import '../../styles/colors/app_colors.dart';
import '../signup/signup.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'Login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseView<LoginScreen, LoginViewModel>
    implements LoginConnector {
  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);

    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextFormField(
                style: TextStyle(color: provider.changeFontColor()),
                controller: emailController,
                validator: (value) {
                  if (value == null || value == "") {
                    return "Please Enter User Name";
                  }
                  final bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[gmail]+\.[com]+")
                      .hasMatch(value);
                  if (!emailValid) {
                    return "Please Enter Valid Email";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: Text('Email'),
                  labelStyle: TextStyle(color: provider.changeFontColor()),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: primaryColor)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: primaryColor)),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                style: TextStyle(color: provider.changeFontColor()),
                controller: passwordController,
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return "Please Enter Valid Password";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: Text('Password'),
                  labelStyle: TextStyle(color: provider.changeFontColor()),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: primaryColor)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: primaryColor)),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      viewModel.login(
                          emailController.text, passwordController.text);
                      /*       FirebaseFunctions.login(
                          emailController.text, passwordController.text, () {
                        provider.initMyUser();
    
                        Navigator.pushNamedAndRemoveUntil(
                            context, HomeLayout.routeName, (route) => false);
                      }, (message) {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text("Error"),
                                  content: Text(message),
                                ));
                      });*/
                    }
                  },
                  child: Text('Login')),
              Row(
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(color: provider.changeFontColor()),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, SignUpScreen.routeName);
                      },
                      child: Text("Create account"))
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }

  @override
  goToHome() {
    Navigator.pushNamedAndRemoveUntil(
        context, HomeLayout.routeName, (route) => false);
  }

  @override
  hideDialog() {
    Navigator.pop(context);
    //    provider.initMyUser();
  }

  @override
  showLoading() {
    showDialog(
        context: context, builder: (context) => CircularProgressIndicator());
  }

  @override
  showMessage(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Error"),
              content: Text(message),
            ));
  }

  @override
  LoginViewModel initMyViewModel() {
    return LoginViewModel();
  }
}
