import 'dart:async';
import 'package:flutter/material.dart';
import 'package:media_z/screens/LayoutScreen/LayoutScreen.dart';
import 'package:provider/provider.dart';

import '../../provider/provider.dart';
import '../outh/loginScreen/loginScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const String routeName = 'SplashScreen';
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    timerOpen();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      color: Colors.white,
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    'v1.0',
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'My_Font',
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            'محمد زوين',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontFamily: 'My_Font3',
              fontSize: 25,
            ),
          ),
        ],
      ),
    );
  }

  void timerOpen() {
    Timer(
      const Duration(seconds: 2),
          () {
        var provider = Provider.of<MyProvider>(context, listen: false);
        if (provider.firebaseUser != null) {
          Navigator.pushReplacementNamed(context, LayoutScreen.routeName);
        } else {
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        }
      },
    );
  }
}

// void timerOpen(BuildContext context) {
//   Timer(
//     const Duration(seconds: 2),
//         () {
//       var provider = Provider.of<MyProvider>(context, listen: false);
//       if (provider.firebaseUser != null) {
//         Navigator.pushReplacementNamed(context, LayoutScreen.routeName);
//       } else {
//         Navigator.pushReplacementNamed(context, LoginScreen.routeName);
//       }
//     },
//   );
// }
