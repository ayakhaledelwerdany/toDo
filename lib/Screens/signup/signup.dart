import 'package:flutter/material.dart';
import 'package:newtodo/Screens/signup/signup_view_connector.dart';
import 'package:newtodo/Screens/signup/signup_view_model.dart';
import 'package:newtodo/Shared/base.dart';
import 'package:provider/provider.dart';

import '../../Shared/network/firebase/firebase_function.dart';
import '../../provider/my_provider.dart';
import '../../styles/colors/app_colors.dart';
import '../login/login.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = 'SignUp';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends BaseView<SignUpScreen, SignUpViewModel>
    implements SignUpConnector {
  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var nameController = TextEditingController();

  var ageController = TextEditingController();

  @override
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
                controller: nameController,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value == "") {
                    return "Please Enter your Name";
                  }

                  return null;
                },
                decoration: InputDecoration(
                  label: Text(
                    ' Name',
                  ),
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
                controller: ageController,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value == "") {
                    return "Please Enter Your Age";
                  }

                  return null;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  label: Text(
                    'Age',
                  ),
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
                controller: emailController,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value == "") {
                    return "Please Enter Email";
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
                  label: Text(
                    'Email',
                  ),
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
                textInputAction: TextInputAction.done,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.length < 4) {
                    return "Please Enter Valid Password";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: Text(
                    'Password',
                  ),
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
              ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      viewModel.signUp(
                          emailController.text,
                          passwordController.text,
                          nameController.text,
                          int.parse(ageController.text));
                    }
                  },
                  child: Text('Sign Up')),
              Row(
                children: [
                  Text(
                    "I have an accounts...",
                    style: TextStyle(color: provider.changeFontColor()),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, LoginScreen.routeName, (route) => false);
                      },
                      child: Text("Login"))
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
        context, LoginScreen.routeName, (route) => false);
  }

  @override
  SignUpViewModel initMyViewModel() {
    return SignUpViewModel();
  }
}
