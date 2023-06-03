import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

class MyTheme {
  static ThemeData lightTheme = ThemeData(
      // visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: ColorScheme.fromSeed(
          background: PREMIUMCOLOR, seedColor: BUTTONCOLOR,


      ),
      iconTheme: const IconThemeData(color: LABLECOLOR),
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: PREMIUMCOLOR,
          statusBarColor: PREMIUMCOLOR,
        ),
        color: PREMIUMCOLOR,
        centerTitle: true,
        titleTextStyle:
            TextStyle(color: TEXTCOLOR, fontSize: 30, fontFamily: 'My_Font'),
      ),
      textTheme: const TextTheme(
        bodyLarge:
            TextStyle(color: TEXTCOLOR, fontSize: 35, fontFamily: 'My_Font'),
        bodyMedium: TextStyle(fontSize: 30, color: TEXTCOLOR,fontFamily: 'My_Font'),
       headlineLarge: TextStyle(fontSize: 30, color: TEXTCOLOR,fontFamily: 'My_Font2'),
        bodySmall: TextStyle(fontSize: 20, color: TEXTCOLOR),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: LABLECOLOR, type: BottomNavigationBarType.fixed));

  static ThemeData darkThem = ThemeData();
}
