import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:money_carer/constant/constant.dart';
import 'package:money_carer/screens/BioMetricsScreen.dart';
import 'package:money_carer/screens/HomeScreen.dart';
import 'package:money_carer/screens/LoginScreen.dart';
import 'package:money_carer/screens/OTPVerifyScreen.dart';
import 'package:money_carer/screens/SignUpScreen.dart';
import 'package:money_carer/utils/shared_preferences/shared_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/constant.dart';
import '../data/api/ApiService.dart';
import '../utils/Authentication.dart';
import 'OnBoardScreenTwo.dart';

class OnBoardScreenOne extends StatefulWidget {
  const OnBoardScreenOne({Key? key}) : super(key: key);

  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreenOne> {
  bool isLogin = false;
  bool isRegister = false;
  bool isR2MFA = false;
  bool isBio = false;
  bool isOnBoardComplete = false;
  dynamic checkMFA;
  dynamic detailMFA;
  late bool _isProcess = false;

  @override
  void initState() {
    super.initState();
    initializePreference().whenComplete(() {
      var refreshToken = SharedPrefs().getRefreshTokenKey();
      if (kDebugMode) {
        print(refreshToken);
      }

      if (refreshToken != null) {
        if (SharedPrefs().getTokenTime() == null) {
          ApiService().getUserIDTokenRefresh(context);
        } else {
          DateTime datetime = DateTime.now();
          DateTime savedDateTime = DateTime.parse(SharedPrefs().getTokenTime().toString());
          final difference = datetime.difference(savedDateTime).inMinutes;
          if (kDebugMode) {
            print("difference" + difference.toString());
          }
          if (difference > 50) {
            ApiService().getUserIDTokenRefresh(context);
          }
        }

        Future.delayed(const Duration(seconds: 1)).then((value) => setState(() async {
              isLogin = SharedPrefs().isLogin();
              isOnBoardComplete = SharedPrefs().isOnBoardingCompleted();
              isRegister = SharedPrefs().isUserRegister();
              isR2MFA = SharedPrefs().isUser2MFA();
              isBio = SharedPrefs().isBio();
              if (kDebugMode) {
                print(isLogin);
              }
              if (isLogin && isRegister && !isR2MFA) {
                _getCheckMFAData();
              } else if (isLogin && isBio) {
                setState(() {
                  _isProcess = true;
                });
                bool isAuthenticated = await Authentication.authenticateWithBiometrics();

                if (isAuthenticated) {
                  _navigateToHomeScreen(context);
                } else {}
              } else if (isLogin && isRegister && isR2MFA) {
                setState(() {
                  _isProcess = true;
                });
                _navigateToHomeScreen(context);
                //_navigateToBioScreen(context);
              } else {
                setState(() {
                  _isProcess = true;
                });
              }
            }));
      } else {
        setState(() {
          _isProcess = true;
        });
      }
    });
  }

  void _getCheckMFAData() async {
    String? deviceId = await _getId();
    if (kDebugMode) {
      print("deviceIs---" + deviceId!);
    }
    if (deviceId != null) {
      SharedPrefs().setDeviceId(deviceId);
    }
    checkMFA = (await ApiService().getCheckMFA(deviceId!));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      //valueNotifier.value = _pcm; //provider
      setState(() async {
        if (checkMFA == null) {
          SharedPrefs().setIsLogin(false);
          _navigateToLoginScreen(context);
        } else {
          checkMFA = checkMFA;

          if (checkMFA != null) {
            if (checkMFA['success'] == true) {
              _getDetailMFAData();
            } else {
              if (SharedPrefs().isBioAuth() == true) {
                setState(() {
                  _isProcess = true;
                });
                bool isAuthenticated = await Authentication.authenticateWithBiometrics();

                if (isAuthenticated) {
                  _navigateToHomeScreen(context);
                } else {}
              } else {
                _navigateToHomeScreen(context);
              }
            }
          } else {
            SharedPrefs().setIsLogin(false);
            _navigateToLoginScreen(context);
          }
        }
      });
    });
  }

  void _getDetailMFAData() async {
    detailMFA = (await ApiService().getDetailMFA());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //valueNotifier.value = _pcm; //provider
      setState(() {
        detailMFA = detailMFA;
        if (detailMFA['maskedPhoneNo'] != "") {
          _isProcess = true;
          // String phoneNo = _getDetailMFAData() as String;
          _navigateToCodeScreen(context, detailMFA['maskedPhoneNo']);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      body: !_isProcess
          ? const Center(
              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(kBaseColor)),
            )
          : SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: mq.height,
                ),
                child: Stack(
                  children: [
                    buildBackContainer(context, mq),
                    buildInputContainer(mq),
                    buildSkipContainer(mq),
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
        Container(
          height: mq.height * 0.55,
          decoration: boxDecoration(),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: mq.height * 0.05,
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
            height: mq.height * 0.5,
            decoration: boxUnion(),
            padding: const EdgeInsets.only(right: 50, left: 50),
            child: buildText(),
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
        padding: const EdgeInsets.only(right: 20.0, left: 20),
        decoration: boxBottom(),
        constraints: BoxConstraints(
          maxHeight: mq.height,
        ),
        child: Stack(
          children: [buildSlider(), buildNextSkip()],
        ),
      ),
      //   child: Container(
      //       height: mq.height * 0.5,
      //       decoration: boxBottom(),
      //       padding: const EdgeInsets.only(right: 20.0, left: 20),
      //
      // ),
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
              Image.asset('assets/onBoard/slider.png', scale: 3),
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
                    onPressed: () => _navigateToSkipScreen(context)),
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
                  )
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
        pageBuilder: (c, a1, a2) => const OnBoardScreenTwo(),
        transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  void _navigateToBioScreen(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => const BioMetricsScreen(screen: "onBoard"),
        transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  void _navigateToHomeScreen(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const HomeScreen()), (Route<dynamic> route) => false);
  }

  void _navigateToLoginScreen(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => const LoginScreen(),
        transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  void _navigateToCodeScreen(BuildContext context, String phone) {
    Navigator.pop(context);
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => OTPVerifyScreen(
          phoneNo: phone,
          screen: "onboard",
        ),
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

  Widget buildText() {
    return Container(
      margin: const EdgeInsets.only(bottom: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Pragmatic help and support',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30.0, fontFamily: 'Poppins', fontWeight: FontWeight.w800, color: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(right: 20, left: 20),
            child: const Text(
              'Inclusive banking services and practical help',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0, fontFamily: 'Poppins', fontWeight: FontWeight.w400, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNextSkipContainer(Size mq) {
    return Row(
      children: const [
        Text(
          'Skip',
          textAlign: TextAlign.right,
          style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'Raleway'),
        ),
        //insert here

        SizedBox(
          width: 300,
          height: 80,
        ),

        Text(
          'Next',
          textAlign: TextAlign.left,
          style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'Raleway'),
        ),
      ],
    );
  }

  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
    return "";
  }
}
