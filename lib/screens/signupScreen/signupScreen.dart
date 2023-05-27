
import 'package:flutter/material.dart';
import 'package:new_music/screens/loginScreen/loginScreen.dart';
import '../../componentes/defaultButton.dart';
import '../../componentes/defaultTextForm.dart';
import '../../style/colors.dart';

class SignUpScreen extends StatelessWidget {
   SignUpScreen({Key? key}) : super(key: key);
   static const String routeName = 'SignUpScreen';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
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
                      'Sing Up',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      'Sign up now for free and start meditating, and explore Medic.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .11,
                    ),
                    DefaultTextForm(
                        hintText: 'Name',
                        controller: emailController,
                        validator: (value) {}),
                    const SizedBox(
                      height: 8,
                    ),
                    DefaultTextForm(
                        hintText: 'Email',
                        controller: emailController,
                        validator: (value) {}),
                    const SizedBox(
                      height: 8,
                    ),
                    DefaultTextForm(
                        hintText: 'Password',
                        controller: passwordController,
                        validator: (value) {}),
                    const SizedBox(
                      height: 15,
                    ),
                    DefaultButton(text: 'sign up', onPressed: () {}),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                          },
                          child: Text('Already have an account?',
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
