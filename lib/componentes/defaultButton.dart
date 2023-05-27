import 'package:flutter/material.dart';

import '../style/colors.dart';

class DefaultButton extends StatelessWidget {

  final String text;
 final void Function()? onPressed;

  const DefaultButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: BOTTOMMCOLOR,
      height: 40,
      minWidth: double.infinity,
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
