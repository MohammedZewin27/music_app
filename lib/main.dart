import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:media_z/provider/provider.dart';
import 'package:media_z/provider/providerDatabase.dart';
import 'package:media_z/provider/providerMusic.dart';
import 'package:media_z/provider/providerVideo.dart';
import 'package:media_z/screens/LayoutScreen/LayoutScreen.dart';

import 'package:media_z/screens/home_screen/radioScreen.dart';
import 'package:media_z/screens/home_screen/tv/liveStream/live%20Stream.dart';
import 'package:media_z/screens/home_screen/tv/tvHome.dart';
import 'package:media_z/screens/outh/loginScreen/loginScreen.dart';
import 'package:media_z/screens/outh/signupScreen/signupScreen.dart';

import 'package:media_z/screens/splash_screen/SplashScreen.dart';
import 'package:media_z/style/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:media_z/screens/video_screen/fullScreen.dart';
import 'package:provider/provider.dart';

import 'componentes/openYouTubeScreen.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => MyProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => ProviderData()..createDatabase(),
    ),
    ChangeNotifierProvider(
      create: (context) => ProviderMusic(),
    ),
    ChangeNotifierProvider(
      create: (context) => ProviderVideo(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Provider.of<ProviderData>(context);
    return MaterialApp(
      title: 'music app',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('ar'), // arabic
      ],
      locale: Locale('en'),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkThem,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        LayoutScreen.routeName: (context) => const LayoutScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        SignUpScreen.routeName: (context) => SignUpScreen(),
        FullScreen.routeName: (context) => FullScreen(),
        OpenYouTube.routeName: (context) => OpenYouTube(),
        RadioScreen.routeName: (context) => RadioScreen(),
        LiveStream.routeName: (context) => LiveStream(),
        TvHome.routeName: (context) => const TvHome(),
      },
    );
  }
}
