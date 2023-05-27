import 'package:flutter/material.dart';
import 'package:new_music/screens/homeLayoutScreen/homeLayoutScreen.dart';
import 'package:new_music/screens/loginScreen/loginScreen.dart';
import 'package:new_music/screens/signupScreen/signupScreen.dart';
import 'package:new_music/screens/splash_screen/SplashScreen.dart';
import 'package:new_music/style/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'music app',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkThem,

      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName:(context) => const SplashScreen(),
        HomeLayoutScreen.routeName:(context) => const HomeLayoutScreen(),
        LoginScreen.routeName:(context) =>  LoginScreen(),
        SignUpScreen.routeName:(context) =>  SignUpScreen(),
      },
    );
  }
}
