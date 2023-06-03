import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_music/firebaseError.dart';
import 'package:new_music/generated/assets.dart';
import 'package:new_music/loding.dart';

import '../../../componentes/defaultButton.dart';
import '../../../componentes/defaultTextForm.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../style/colors.dart';
import '../../screens/LayoutScreen/LayoutScreen.dart';
import '../loginScreen/loginScreen.dart';

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
    var appLocal=AppLocalizations.of(context)!;
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
                        appLocal.singUp,

                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        appLocal.singUpText,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .09,
                      ),
                      DefaultTextForm(
                          hintText: appLocal.username,
                          controller: usernameController,
                          validator: (value) {
                            if (value!.isEmpty || value == '') {
                              return appLocal.validUsername;
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 10,
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
                          isPassword: isPassword,
                          suffixIcon: isPassword
                              ? Icons.remove_red_eye
                              : Icons.remove_red_eye_outlined,
                          functionIcon: () {
                            isPassword = !isPassword;
                            setState(() {});
                          },
                          validator: (value) {
                            if (value!.isEmpty || value == ''||value.length<6) {
                              return appLocal.validPassword;
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      DefaultElevatedButton(
                          text: appLocal.singUp,
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
                            child: Text(appLocal.haveAccount,
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
              ),

            ],
          ),
        ),
      ),
    );
  }

  goToHomePage() async {
    if (formKey.currentState!.validate()) {
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        Loading.hideLoading(context);
        Loading.showMessage(FirebaseError.accountCreated,context);
        await Navigator.pushReplacementNamed(context, LayoutScreen.routeName);
      } on FirebaseAuthException catch (e) {
        if (e.code == FirebaseError.weakPassword) {
          Loading.hideLoading(context);
          Loading.showMessage(FirebaseError.passwordWeak,context);
        }else if (e.code == FirebaseError.emailAlreadyInUse) {
       Loading.hideLoading(context);
       Loading.showMessage(FirebaseError.existsEmail,context);
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
