import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

class MyTheme {
  static ThemeData lightTheme = ThemeData(
    // visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme:
        ColorScheme.fromSeed(background: PREMIUMCOLOR, seedColor: BOTTOMMCOLOR),
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        systemNavigationBarColor: PREMIUMCOLOR,
        statusBarColor: PREMIUMCOLOR,
      ),
      color: PREMIUMCOLOR,
    ),
    textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.white, fontSize: 35),
        bodyMedium: TextStyle(fontSize: 30, color: Colors.white),
        bodySmall: TextStyle(fontSize: 20, color: Colors.white),



    ),
  );

  static ThemeData darkThem = ThemeData();
}
