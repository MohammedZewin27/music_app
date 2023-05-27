import 'package:flutter/material.dart';

import '../style/colors.dart';

class DefaultTextForm extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const DefaultTextForm(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: LABLECOLOR)),
    );
  }
}
