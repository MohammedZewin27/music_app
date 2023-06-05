import 'package:flutter/material.dart';

import '../style/colors.dart';

/// MaterialButton
class DefaultButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final Color? color;
  final double? width;

  const DefaultButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.color = BUTTONCOLOR,
      this.width = double.infinity});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color,
      height: 40,
      minWidth: width,
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}

/// ElevatedButton
class DefaultElevatedButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final double? elevation;

  const DefaultElevatedButton(
      {super.key, required this.text, required this.onPressed, this.elevation});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: BUTTONCOLOR,
          elevation: elevation,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
