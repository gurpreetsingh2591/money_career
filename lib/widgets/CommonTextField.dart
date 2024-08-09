import 'package:flutter/material.dart';

import '../constant/constant.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool autocorrect;

  const CommonTextField({Key? key, required this.controller, required this.hintText, this.autocorrect = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: TextFormField(
        style: const TextStyle(
          fontSize: 14,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
          color: kBaseColor,
        ),
        keyboardType: TextInputType.emailAddress,
        enableSuggestions: false,
        autocorrect: autocorrect,
        controller: controller,
        textAlign: TextAlign.left,
        onEditingComplete: () => FocusScope.of(context).nextFocus(),
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          border: InputBorder.none,
          counterText: '',
          hintStyle: const TextStyle(fontSize: 14.0, color: kBaseColor),
          hintText: hintText,
          contentPadding: const EdgeInsets.all(10.0),
        ),
      ),
    );
  }
}
