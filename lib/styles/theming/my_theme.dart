import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../colors/app_colors.dart';

class MyThemeData {
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: Color(0xffDFECDB),
      primaryColor: primaryColor,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        iconTheme: IconThemeData(color: blackColor),
        titleTextStyle: GoogleFonts.elMessiri(
            color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.white,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
      ));

  static ThemeData darkTheme = ThemeData(
      primaryColor: darkprimaryColor,
      scaffoldBackgroundColor: Color(0xff060E1E),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        iconTheme: IconThemeData(color: blackColor),
        titleTextStyle: GoogleFonts.elMessiri(
            color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        backgroundColor: Color(0xff5D9CEC),
        elevation: 0,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: darkprimaryColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.white,
      ));
}
