import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:money_carer/constant/constant.dart';

Future<bool?> toast(String message, bool isError) {
  return Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: isError ? kBaseColor : kBaseLightColor,
    textColor: Colors.white,
    fontSize: 15.0,
  );
}
