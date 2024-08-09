import 'package:flutter/material.dart';
import 'package:money_carer/constant/constant.dart';
import 'package:money_carer/screens/OnBoardScreenOne.dart';
import 'package:money_carer/utils/shared_preferences/shared_prefs.dart';

import '../constant/constant.dart';
import '../widgets/TopContainer.dart';

class LogoutScreen extends StatefulWidget {
  const LogoutScreen({Key? key}) : super(key: key);

  @override
  _LogoutScreen createState() => _LogoutScreen();
}

class _LogoutScreen extends State<LogoutScreen> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [kBaseLightColor, kBaseColor],
                stops: [0.5, 1.5],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: mq.height,
          ),
          child: Stack(
            children: [
              TopContainer(
                mq: mq,
                screen: "logout",
              ),
              buildBottomContainer(mq),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextContainer(BuildContext context, Size mq) {
    return const Text(
      kSureToLogout,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 24, color: Colors.white, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
    );
  }

  Widget buildButtonContainer(Size mq) {
    return Container(
      margin: const EdgeInsets.only(bottom: 100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(
            width: 120,
            height: 50.0,
            child: ElevatedButton(
              onPressed: () {
                dialog();
              },
              child: const Text(kYes, style: TextStyle(fontSize: 16, fontFamily: 'Inter', fontWeight: FontWeight.w700)),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: kBaseColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // <-- Radius
                ),
              ),
            ),
          ),
          SizedBox(
            width: 120,
            height: 50.0,
            child: FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(kNo, style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Inter', fontWeight: FontWeight.w700)),
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.white, width: 1, style: BorderStyle.solid), borderRadius: BorderRadius.circular(15)),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBottomContainer(Size mq) {
    return Positioned(
      left: mq.width * 0.00,
      right: mq.width * 0.00,
      top: mq.height * 0.2,
      child: Column(
        children: [
          Container(
            height: mq.height * 0.8,
            decoration: boxOTPBg(),
            padding: const EdgeInsets.only(right: 30, left: 30),
            child: Stack(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildTextContainer(context, mq),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  buildButtonContainer(mq),
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const OnBoardScreenOne()), (Route<dynamic> route) => false);
  }

  Future dialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text(kLogoutInfo),
        actions: [
          FlatButton(
            child: const Text(
              kCancel,
              style: TextStyle(fontSize: 18, fontFamily: 'Inter', fontWeight: FontWeight.w700, color: kTextColor),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: const Text(
              kOK,
              style: TextStyle(fontSize: 18, fontFamily: 'Inter', fontWeight: FontWeight.w700, color: kTextColor),
            ),
            onPressed: () {
              SharedPrefs().removeTokenKey();
              SharedPrefs().removeRefreshTokenKey();
              SharedPrefs().setIsLogin(false);
              SharedPrefs().setIsUserRegister(false);
              SharedPrefs().setIsSignUp(false);
              SharedPrefs().setIsBio(false);
              SharedPrefs().setIsBioAuth(false);
              SharedPrefs().setIsOnBoardingCompleted(false);
              SharedPrefs().setIsUser2MFA(false);
              Navigator.pop(context);
              _navigateToNextScreen(context);
            },
          ),
        ],
      ),
    );
  }
}
