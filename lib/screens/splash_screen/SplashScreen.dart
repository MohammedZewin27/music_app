import 'dart:async';
import 'package:flutter/material.dart';
import 'package:new_music/generated/assets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../loginScreen/loginScreen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
static const String routeName='SplashScreen';
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3),
    () => Navigator.pushReplacementNamed(context, LoginScreen.routeName),
    );
    return Scaffold(
      body: Image.asset(Assets.imageSplash,fit: BoxFit.fill,width: double.infinity,height: double.infinity,),
    );
  }
}
