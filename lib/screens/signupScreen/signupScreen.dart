import 'package:flutter/material.dart';
import 'package:new_music/screens/loginScreen/loginScreen.dart';
import '../../componentes/defaultButton.dart';
import '../../componentes/defaultTextForm.dart';
import '../../style/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);
  static const String routeName = 'SignUpScreen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

   bool isPassword = true;

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
                          hintText: 'Username',
                          controller: usernameController,
                          validator: (value) {
                            if (value!.isEmpty || value == '') {
                              return "please insert Username";
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 8,
                      ),
                      DefaultTextForm(
                          hintText: 'Email',
                          textInputType: TextInputType.emailAddress,
                          controller: emailController,
                          validator: (value) {
                            if (value!.isEmpty || value == '') {
                              return "please insert Email";
                            }
                            final bool emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value);
                            if (!emailValid) {
                              return 'Correct the email';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 8,
                      ),
                      DefaultTextForm(
                          hintText: 'Password',
                          controller: passwordController,
                          isPassword: isPassword,
                          suffixIcon: isPassword
                              ? Icons.remove_red_eye
                              : Icons.remove_red_eye_outlined,
                          functionIcon: () {
                            isPassword = !isPassword;
                            setState(() {});
                          },
                          validator: (value) {
                            if (value!.isEmpty || value == '') {
                              return "please insert Username";
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      DefaultElevatedButton(
                          text: 'sign up',
                          onPressed: () async {
                            await goToHomePage();
                          }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, LoginScreen.routeName);
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
      ),
    );
  }

  goToHomePage() async {
    if (formKey.currentState!.validate()) {

    }
  }
}
