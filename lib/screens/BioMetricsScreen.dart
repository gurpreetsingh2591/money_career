import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:money_carer/constant/constant.dart';
import 'package:money_carer/screens/TermsAndConditionScreen.dart';
import 'package:money_carer/utils/shared_preferences/shared_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/constant.dart';
import '../utils/Authentication.dart';
import '../widgets/TopContainer.dart';

class BioMetricsScreen extends StatefulWidget {
  final String screen;
  const BioMetricsScreen({Key? key, required this.screen}) : super(key: key);

  @override
  _BioMetricsScreen createState() => _BioMetricsScreen();
}

class _BioMetricsScreen extends State<BioMetricsScreen> {
  // final _formKey = GlobalKey<FormState>();
  final LocalAuthentication auth = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    initializePreference().whenComplete(() {
      if (SharedPrefs().getBioAuthTime().toString() != "") {
        DateTime datetime = DateTime.now();
        DateTime savedDateTime = DateTime.parse(SharedPrefs().getBioAuthTime().toString());
        final difference = datetime.difference(savedDateTime).inMinutes;
        if (kDebugMode) {
          print("difference" + difference.toString());
        }
        if (difference < 20) {
          _navigateToNextScreen(context);
        }
      } else {}
    });
  }

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
                screen: "bio",
              ),
              buildBackContainer(context, mq),
              buildBottomContainer(mq),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> initializePreference() async {
    SharedPrefs.init(await SharedPreferences.getInstance());
  }

  Widget buildBackContainer(BuildContext context, Size mq) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: mq.height * 0.5,
          child: Center(
            child: Container(
              padding: const EdgeInsets.only(top: 50, right: 30, left: 30),
              child: Column(
                children: [
                  SizedBox(
                    height: mq.height * 0.05,
                  ),
                  const Text(
                    kBioMetrics,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 26, color: kBaseColor, fontFamily: 'Poppins', fontWeight: FontWeight.w700),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ),
                  const Text(
                    kBioAuthText,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: kBaseColor, fontFamily: 'Inter', fontWeight: FontWeight.w600),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ),
                  Image.asset('assets/otp/face_id.png', scale: 5),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SizedBox(
          width: 100,
          height: 50.0,
          child: ElevatedButton(
            onPressed: () async {
              bool isAuthenticated = await Authentication.authenticateWithBiometrics();

              if (isAuthenticated) {
                SharedPrefs().setIsBioAuth(true);
                DateTime datetime = DateTime.now();
                SharedPrefs().setIsBio(true);
                SharedPrefs().setBioAuthTime(datetime.toString());
                _navigateToNextScreen(context);
              } else {
                SharedPrefs().setIsBioAuth(false);
              }
            },
            child: const Text(kYes, style: TextStyle(fontSize: 16, fontFamily: 'Inter', fontWeight: FontWeight.w700)),
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: kBaseColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // <-- Radius
              ),
            ),
          ),
        ),
        SizedBox(
          width: 100,
          height: 50.0,
          child: FlatButton(
            onPressed: () {
              SharedPrefs().setBioAuthTime("");
              _navigateToNextScreen(context);
              SharedPrefs().setIsBioAuth(false);
            },
            child: const Text(kNo, style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Inter', fontWeight: FontWeight.w700)),
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.white, width: 1, style: BorderStyle.solid), borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }

  Widget buildBottomContainer(Size mq) {
    return Positioned(
      left: mq.width * 0.00,
      right: mq.width * 0.00,
      top: mq.height * 0.5,
      child: Column(
        children: [
          Container(height: mq.height * 0.6, decoration: boxOTPBg(), padding: const EdgeInsets.only(right: 50, left: 50), child: buildText()),
        ],
      ),
    );
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => const TermsConditionScreen(),
        transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }
}
