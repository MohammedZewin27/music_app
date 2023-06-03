import 'dart:async';
import 'package:flutter/material.dart';
import '../outh/loginScreen/loginScreen.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
static const String routeName='SplashScreen';
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2),
    () => Navigator.pushReplacementNamed(context,LoginScreen.routeName),
    );
    return  Scaffold(

      body: Column(
        children: [

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text('Music',style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width*.20,
                  fontFamily: 'My_Font',
                  color: Colors.white
                ),)),
                const Center(child: Text('v1.0',style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'My_Font',
                  color: Colors.white
                ),)),
              ],
            ),
          ),
          Text('محمد زوين',style:Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontFamily: 'My_Font3',
            fontSize: 25,

          ),),
        ],
      ),
    );
  }
}
