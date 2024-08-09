import 'package:flutter/material.dart';
import 'package:money_carer/constant/constant.dart';
import 'package:money_carer/screens/SignUpScreen.dart';
import 'package:money_carer/utils/shared_preferences/shared_prefs.dart';

import '../constant/constant.dart';

class OnBoardScreenThree extends StatefulWidget {
  const OnBoardScreenThree({Key? key}) : super(key: key);

  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreenThree> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: mq.height,
          ),
          child: Stack(
            children: [
              buildBackContainer(context, mq),
              buildInputContainer(mq),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBackContainer(BuildContext context, Size mq) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: mq.height * 0.55,
          decoration: boxBoardThreeBg(),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: mq.height * 0.04,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildInputContainer(Size mq) {
    return Positioned(
      left: mq.width * 0.00,
      right: mq.width * 0.00,
      top: mq.height * 0.45,
      child: Column(
        children: [
          Container(
            height: mq.height * 0.6,
            decoration: boxUnion(),
            padding: const EdgeInsets.only(right: 50, left: 50),
            child: buildText(),
          ),
        ],
      ),
    );
  }

  Widget buildText() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          'Everyday money management',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 30.0, fontFamily: 'Poppins', fontWeight: FontWeight.w800, color: Colors.white),
        ),
        Container(
          padding: const EdgeInsets.only(top: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
        const Text(
          'For vulnerable people and their carers',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18.0, fontFamily: 'Poppins', fontWeight: FontWeight.w400, color: Colors.white),
        ),
        Container(
          padding: const EdgeInsets.only(top: 30.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
        Image.asset('assets/onBoard/slider_white.png', scale: 3),
        Container(
          padding: const EdgeInsets.only(top: 30.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
        SizedBox(
          height: 50.0,
          child: ElevatedButton(
            onPressed: () {
              _navigateToNextScreen(context);
            },
            child: const Text('Sign in or Sign up',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                )),
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: kBaseColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15), // <-- Radius
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _navigateToNextScreen(BuildContext context) {
    SharedPrefs().setIsOnBoardingCompleted(true);
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => const SignUpScreen(),
        transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }
}
