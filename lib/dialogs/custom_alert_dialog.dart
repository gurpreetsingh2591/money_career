import 'package:flutter/material.dart';
import 'package:money_carer/constant/constant.dart';

import '../screens/HomeScreen.dart';
import '../screens/RegisterForAccountScreen.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return showAlertDialog(context);
  }

  Future errorDialog(String title, String password, BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(password),
        actions: [
          FlatButton(
            child: const Text(
              "OK",
              style: TextStyle(fontSize: 18, fontFamily: 'Poppins', fontWeight: FontWeight.w800, color: kBaseColor),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  Future dialogAnAccount(String title, String password, BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Text(password),
        actions: [
          FlatButton(
            child: const Text(
              "OK",
              style: TextStyle(fontSize: 18, fontFamily: 'Poppins', fontWeight: FontWeight.w800, color: kBaseColor),
            ),
            onPressed: () {
              _navigateToHomeScreen(context);
            },
          ),
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: const Text(
        "Cancel",
        style: TextStyle(fontSize: 18, fontFamily: 'Inter', fontWeight: FontWeight.w700, color: kBaseColor),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: const Text("OK", style: TextStyle(fontSize: 18, fontFamily: 'Inter', fontWeight: FontWeight.w700, color: kBaseColor)),
      onPressed: () {
        Navigator.of(context).pop();
        _navigateToNextScreen(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: const Text("Thanks for registering with Money Carer. You can now see the accounts you have access to"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => const RegisterForAccountScreen(),
        transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  void _navigateToHomeScreen(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const HomeScreen()), (Route<dynamic> route) => false);
  }
}
