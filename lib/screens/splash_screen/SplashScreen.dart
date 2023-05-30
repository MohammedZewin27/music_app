import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../LayoutScreen/LayoutScreen.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
static const String routeName='SplashScreen';
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 1),
    () => Navigator.pushReplacementNamed(context,LayoutScreen.routeName),
    );
    return  Scaffold(
      // body: Image.asset(Assets.imageSplash,fit: BoxFit.fill,width: double.infinity,height: double.infinity,),
      body: Center(child: Text('Music',style: TextStyle(
        fontSize: MediaQuery.of(context).size.width*.20,
        fontFamily: 'My_Font',
        color: Colors.white
      ),)),
    );
  }
}
