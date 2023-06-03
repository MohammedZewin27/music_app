import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_music/style/colors.dart';

class Loading {
  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void showLoading(
      {String message = "Loading...", required BuildContext context}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: LABLECOLOR,
          title: Center(
              child: Row(
            children: [
              Text(
                message,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 22, color: PREMIUMCOLOR),
              ),
              const SizedBox(
                width: 15,
              ),
              const CircularProgressIndicator(
                color: PREMIUMCOLOR,
              ),
            ],
          )),
        );
      },
    );
  }

  static void showMessage(String message, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: BUTTONCOLOR3,
          content: Text(
            message,
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 15),
          ),
        );
      },
    );
  }
}
