import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newtodo/Shared/network/firebase/firebase_function.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user_model.dart';

class MyProvider extends ChangeNotifier {
  UserModel? userModel;
  User? firebaseUser;
  String language = 'en';
  ThemeMode themeMode = ThemeMode.light;

  MyProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      initMyUser();
    }
  }
  void initMyUser() async {
    firebaseUser = FirebaseAuth.instance.currentUser;
    userModel = await FirebaseFunctions.readUser(firebaseUser!.uid);
    notifyListeners();
  }

  void logout() {
    FirebaseAuth.instance.signOut();
    notifyListeners();
  }

  void changeLanguage(String lang) async {
    //  saveLang(lang);

    language = lang;
    notifyListeners();
  }

  void changeTheme(ThemeMode theme) async {
    themeMode = theme;
    //saveTheme(theme == ThemeData.dark ? true : false);
    /*
    if (themeMode == theme) {
      return;
    }
    theme = themeMode;*/ //
    notifyListeners();
  }

  saveLang(String lang) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('lang', lang);
  }

  saveTheme(bool isDark) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('theme', isDark);
  }

  getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    language = prefs.getString('lang') ?? 'en';
    notifyListeners();
  }

  getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool theme = prefs.getBool('theme') ?? false;
    themeMode = theme ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  Color changeColors() {
    return themeMode == ThemeMode.dark ? Color(0xff141922) : Colors.white;
  }

  Color changeFontColor() {
    return themeMode == ThemeMode.dark ? Colors.white : Color(0xff141922);
  }
}
