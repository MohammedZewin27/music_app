import 'dart:async';
import 'package:flutter/material.dart';
import 'package:new_music/screens/LayoutScreen/LayoutScreen.dart';
import 'package:provider/provider.dart';
import '../../outh/loginScreen/loginScreen.dart';
import '../../provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const String routeName = 'SplashScreen';

  @override
  Widget build(BuildContext context) {
    timerOpen(context);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Text(
                  'Music',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * .20,
                      fontFamily: 'My_Font',
                      color: Colors.white),
                )),
                const Center(
                    child: Text(
                  'v1.0',
                  style: TextStyle(
                      fontSize: 25, fontFamily: 'My_Font', color: Colors.white),
                )),
              ],
            ),
          ),
          Text(
            'محمد زوين',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontFamily: 'My_Font3',
                  fontSize: 25,
                ),
          ),
        ],
      ),
    );
  }
}

timerOpen(BuildContext context) {
  var provider = Provider.of<MyProvider>(context);
  Timer(
    const Duration(seconds: 2),
    () async => provider.firebaseUser != null
        ? await Navigator.pushReplacementNamed(context, LayoutScreen.routeName)
        : await Navigator.pushReplacementNamed(context, LoginScreen.routeName),
  );
}
