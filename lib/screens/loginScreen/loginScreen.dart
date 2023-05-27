import 'package:flutter/material.dart';
import 'package:new_music/componentes/defaultButton.dart';
import 'package:new_music/componentes/defaultTextForm.dart';
import 'package:new_music/screens/signupScreen/signupScreen.dart';

import 'package:new_music/style/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String routeName = 'loginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
    bool isPassword=true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Form(
          key: formKey,
          child: Stack(
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
                          validator: (value) {
                            if (value!.isEmpty||value==''){
                              return "Email";
                            }
                            final bool emailValid =
                            RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value);
                            if(!emailValid){
                              return 'Correct the Email';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      DefaultTextForm(
                          hintText: 'Password',
                          controller: passwordController,
                          isPassword:isPassword ,
                          suffixIcon:isPassword?Icons.remove_red_eye: Icons.remove_red_eye_outlined,
                          functionIcon: (){
                            isPassword=!isPassword;
                            setState(() {
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty||value==''){
                              return "Username";
                            }
                            return null;

                          }),
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
                      DefaultElevatedButton(text: 'sign in',
                          onPressed: () async {
                            await goToHomePage();
                          }),
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
      ),
    );
  }

  goToHomePage() {
    if (formKey.currentState!.validate()) {

    }
  }
}
