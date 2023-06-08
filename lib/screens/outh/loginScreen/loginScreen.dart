import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_music/componentes/defaultButton.dart';
import 'package:new_music/componentes/defaultTextForm.dart';
import 'package:new_music/generated/assets.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:new_music/componentes/loding.dart';
import 'package:new_music/style/colors.dart';


import '../../../firebaseError.dart';
import '../../LayoutScreen/LayoutScreen.dart';
import '../signupScreen/signupScreen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  static const String routeName = 'loginScreen';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var appLocal = AppLocalizations.of(context)!;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Form(
          key: formKey,
          child: Stack(
            children: [
              Image.asset(
                Assets.imageBack,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        appLocal.singIn,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        appLocal.singInText,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .09,
                      ),
                      DefaultTextForm(
                          hintText: appLocal.email,
                          textInputType: TextInputType.emailAddress,
                          controller: emailController,
                          validator: (value) {
                            if (value!.isEmpty || value == '') {
                              return appLocal.validEmail;
                            }
                            final bool emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value);
                            if (!emailValid) {
                              return appLocal.validEmail2;
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      DefaultTextForm(
                          hintText: appLocal.password,
                          controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty ||
                                value == '' ||
                                value.length < 6) {
                              return appLocal.validPassword;
                            }
                            return null;
                          }),
                      Row(
                        children: [
                          const Expanded(child: SizedBox()),
                          TextButton(
                            onPressed: () {},
                            child: Text(appLocal.forgot,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: LABLECOLOR)),
                          ),
                        ],
                      ),
                      DefaultButton(
                          text: appLocal.singIn,
                          onPressed: () async {
                            await goToHomeScreen(context);
                          }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, SignUpScreen.routeName);
                            },
                            child: Text(appLocal.dontHaveAccount,
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

  goToHomeScreen(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        Loading.showLoading(context: context);
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
         Loading.hideLoading(context);
        Loading.showMessage(FirebaseError.loginSuccessfully, context);
        Navigator.pushReplacementNamed(context, LayoutScreen.routeName);
      } on FirebaseAuthException catch (e) {
        Loading.hideLoading(context);
        Loading.showMessage(FirebaseError.wrongEmailOrPassword,context);
      }
    }
  }
}
