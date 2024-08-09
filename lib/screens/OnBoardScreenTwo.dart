import 'package:flutter/material.dart';
import 'package:money_carer/constant/constant.dart';

import '../constant/constant.dart';
import 'OnBoardScreenThree.dart';
import 'SignUpScreen.dart';

class OnBoardScreenTwo extends StatefulWidget {
  const OnBoardScreenTwo({Key? key}) : super(key: key);

  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreenTwo> {
  late String next = "Next";
  late String skip = "Skip";

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
            children: [buildBackContainer(context, mq), buildInputContainer(mq), buildSkipContainer(mq)],
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
          decoration: boxBoardTwoBg(),
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
        const Spacer(),
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
            height: mq.height * 0.5,
            decoration: boxUnion(),
            padding: const EdgeInsets.only(right: 30, left: 30),
            child: buildText(),
          ),
        ],
      ),
    );
  }

  Widget buildText() {
    return Container(
      margin: const EdgeInsets.only(bottom: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Financial planning for the future',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30.0, fontFamily: 'Poppins', fontWeight: FontWeight.w800, color: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(right: 30, left: 30),
            child: const Text(
              'Supporting families and their loved ones',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0, fontFamily: 'Poppins', fontWeight: FontWeight.w400, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSkipContainer(Size mq) {
    return Positioned(
      left: mq.width * 0.00,
      right: mq.width * 0.00,
      top: mq.height * 0.830,
      child: Container(
        height: mq.height * 0.25,
        decoration: boxBottom(),
        padding: const EdgeInsets.only(right: 20.0, left: 20),
        constraints: BoxConstraints(
          maxHeight: mq.height,
        ),
        child: Stack(
          children: [
            buildSlider(),
            buildNextSkip(),
          ],
        ),
      ),
    );
  }

  Widget buildSlider() {
    return Column(
      children: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 50.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
              Image.asset('assets/onBoard/slider_two.png', scale: 3),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildNextSkip() {
    return Column(
      children: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                alignment: Alignment.centerRight,
                child: TextButton(
                    child: const Text(
                      "Skip",
                      style: TextStyle(
                        color: kBaseColor,
                        fontSize: 20.0,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: () => _navigateToSkipScreen(context)

                    //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>OnBoardScreenTwo()))
                    ),
              ),
              const SizedBox(
                width: 5,
                height: 200,
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      child: const Text(
                        "Next",
                        style: TextStyle(
                          color: kBaseColor,
                          fontSize: 20.0,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () => _navigateToNextScreen(context),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    alignment: Alignment.centerRight,
                    child: Image.asset('assets/onBoard/icons.png', scale: 4),
                  ),
                ],
              ),
            ],
          ),
        ),
        // buildNextSkipContainer(mq)
        //   buildNext(),
        //  buildSkip()
      ],
    );
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => const OnBoardScreenThree(),
        transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  void _navigateToSkipScreen(BuildContext context) {
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
