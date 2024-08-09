import 'package:flutter/material.dart';
import 'package:money_carer/constant/constant.dart';

class VerticaDivider extends StatelessWidget {
  const VerticaDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5.0,
      width: 2.0,
      color: kBaseColor,
    );
  }
}
