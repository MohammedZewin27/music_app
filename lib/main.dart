import 'package:flutter/material.dart';
import 'package:new_music/screens/homeLayoutScreen/homeLayoutScreen.dart';
import 'package:new_music/screens/loginScreen/loginScreen.dart';
import 'package:new_music/screens/signupScreen/signupScreen.dart';
import 'package:new_music/screens/splash_screen/SplashScreen.dart';
import 'package:new_music/style/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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


      localizationsDelegates:  const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('ar'), // Spanish
      ],

locale: Locale('en'),
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
