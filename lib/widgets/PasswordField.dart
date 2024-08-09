import 'package:flutter/material.dart';

import '../constant/constant.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const PasswordField({Key? key, required this.controller, required this.hintText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: TextFormField(
        obscureText: true,
        style: const TextStyle(
          fontSize: 14,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
          color: kBaseColor,
        ),
        keyboardType: TextInputType.visiblePassword,
        controller: controller,
        textAlign: TextAlign.left,
        onEditingComplete: () => FocusScope.of(context).nextFocus(),
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          border: InputBorder.none,
          counterText: '',
          hintStyle: const TextStyle(fontSize: 14.0, color: kBaseColor),
          hintText: hintText.toString(),
          contentPadding: const EdgeInsets.all(10.0),
        ),
      ),
    );
  }
}
