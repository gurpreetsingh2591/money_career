import 'package:flutter/material.dart';

import '../constant/constant.dart';

class NoteField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const NoteField({Key? key, required this.controller, required this.hintText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: TextFormField(
        maxLines: 7,
        //obscureText: true,
        style: const TextStyle(
          fontSize: 14,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
          color: kBaseColor,
        ),
        keyboardType: TextInputType.text,
        controller: controller,
        textAlign: TextAlign.left,
        onEditingComplete: () => FocusScope.of(context).nextFocus(),
        textInputAction: TextInputAction.done,
        decoration: const InputDecoration(
          border: InputBorder.none,
          counterText: '',
          hintStyle: TextStyle(fontSize: 14.0, color: kBaseColor),
          hintText: 'Note',
          contentPadding: EdgeInsets.all(10.0),
        ),
      ),
    );
  }
}
