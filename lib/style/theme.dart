import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

class MyTheme {
  static ThemeData lightTheme = ThemeData(
    // visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme:
        ColorScheme.fromSeed(background: PREMIUMCOLOR, seedColor: BUTTONCOLOR),
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        systemNavigationBarColor: PREMIUMCOLOR,
        statusBarColor: PREMIUMCOLOR,
      ),
      color: PREMIUMCOLOR,
      // iconTheme: IconThemeData(
      //   color: TEXTCOLOR
      // )
    ),
    textTheme: const TextTheme(
        bodyLarge: TextStyle(color: TEXTCOLOR, fontSize: 35,fontFamily: 'My_Font'),
        bodyMedium: TextStyle(fontSize: 30, color: TEXTCOLOR),
        bodySmall: TextStyle(fontSize: 20, color: TEXTCOLOR),



    ),
  );

  static ThemeData darkThem = ThemeData();
}
