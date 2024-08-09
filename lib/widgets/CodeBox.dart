import 'package:flutter/material.dart';

class CodeBoxOne extends StatelessWidget {
  final TextEditingController controller;

  const CodeBoxOne({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 70,
      width: 70,
      child: TextFormField(
        onChanged: (text) => {
          if (text.length == 1)
            {
              FocusScope.of(context).nextFocus(),
            }
          else if (text.isEmpty)
            {
              FocusScope.of(context).previousFocus(),
            }
        },
        // obscureText: true,
        controller: controller,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        autofocus: true,
        maxLength: 1,
        onEditingComplete: () => FocusScope.of(context).nextFocus(),
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(border: InputBorder.none, counterText: ''),
      ),
    );
  }
}
