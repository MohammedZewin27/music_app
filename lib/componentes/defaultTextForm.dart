import 'package:flutter/material.dart';

import '../style/colors.dart';

class DefaultTextForm extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final void Function()? functionIcon;
  final IconData? suffixIcon;
  final bool isPassword;

   const DefaultTextForm(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.validator,
        this.textInputType,
        this.suffixIcon,
        this.functionIcon,
        this.isPassword=false
      });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: textInputType,
obscureText:isPassword ,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: LABLECOLOR),
      suffixIcon: IconButton(
          icon:  Icon(suffixIcon),
        onPressed:functionIcon ,
      ),
      ),
      style: Theme.of(context).textTheme.bodySmall,
    );
  }
}
