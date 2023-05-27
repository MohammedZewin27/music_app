import 'package:flutter/material.dart';
import 'package:new_music/componentes/defaultButton.dart';
import 'package:new_music/componentes/defaultTextForm.dart';
import 'package:new_music/screens/signupScreen/signupScreen.dart';

import 'package:new_music/style/colors.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  static const String routeName = 'loginScreen';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Stack(
          children: [
            Image.asset(
              'assets/image/back.png',
              height: double.infinity,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sing In',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      'Sign in now to access your saved music.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .11,
                    ),
                    DefaultTextForm(
                        hintText: 'Email',
                        controller: emailController,
                        validator: (value) {}),
                    const SizedBox(
                      height: 10,
                    ),
                    DefaultTextForm(
                        hintText: 'Password',
                        controller: passwordController,
                        validator: (value) {}),
                    Row(
                      children: [
                        const Expanded(child: SizedBox()),
                        TextButton(
                          onPressed: () {},
                          child: Text('Forgot',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: LABLECOLOR)),
                        ),
                      ],
                    ),
                    DefaultButton(text: 'sign in', onPressed: () {}),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, SignUpScreen.routeName);
                          },
                          child: Text('Don’t have an account?',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: LABLECOLOR)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
