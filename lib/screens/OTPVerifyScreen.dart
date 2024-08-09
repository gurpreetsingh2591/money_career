import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:money_carer/constant/constant.dart';
import 'package:money_carer/screens/BioMetricsScreen.dart';
import 'package:money_carer/screens/HomeScreen.dart';
import 'package:money_carer/screens/RegisterForAccountScreen.dart';
import 'package:money_carer/utils/shared_preferences/shared_prefs.dart';
import 'package:money_carer/widgets/CodeBox.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/constant.dart';
import '../data/api/ApiService.dart';
import '../dialogs/custom_alert_dialog.dart';
import '../utils/center_loader.dart';
import '../widgets/TopContainer.dart';

class OTPVerifyScreen extends StatefulWidget {
  final String phoneNo;
  final String screen;

  const OTPVerifyScreen({Key? key, required this.phoneNo, required this.screen}) : super(key: key);

  @override
  State<OTPVerifyScreen> createState() => _OTPVerifyScreen();
}

class _OTPVerifyScreen extends State<OTPVerifyScreen> {
  final _otpText1 = TextEditingController();
  final _otpText2 = TextEditingController();
  final _otpText3 = TextEditingController();
  final _otpText4 = TextEditingController();

  dynamic startMFA;
  dynamic validateMFA;

  void _getStartMFAData() async {
    startMFA = (await ApiService().getStartMFA(SharedPrefs().getDeviceId().toString(), "POST"));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (startMFA == null) {
        } else {
          startMFA = startMFA;
        }
      });
    });
  }

  void _getValidateMFAData(String code) async {
    validateMFA = (await ApiService().getValidateMFA(SharedPrefs().getDeviceId().toString(), "sms", code));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        validateMFA = validateMFA;
        Navigator.of(context).pop();
        if (validateMFA['success'] == true) {
          SharedPrefs().setIsUser2MFA(true);
          if (widget.screen == "register" || widget.screen == "home") {
            Navigator.of(context).pop();

            if (SharedPrefs().isUserRegisterAnAccount() == true) {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const HomeScreen()), (Route<dynamic> route) => false);
            } else {
              Navigator.of(context)
                  .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const RegisterForAccountScreen()), (Route<dynamic> route) => false);
            }
          } else {
            if (widget.screen == "login_onboard") {
              _navigateToHomeScreen(context);
            } else {
              _navigateToNextScreen(context, widget.screen);
            }
          }
        } else {
          Fluttertoast.showToast(
              msg: "Please enter correct code",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: kBaseLightColor,
              textColor: Colors.white);
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    initializePreference().whenComplete(() {
      setState(() {
        _getStartMFAData();
      });
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
                screen: "OTP",
              ),
              buildCodeContainer(context, mq),
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

  Widget buildCodeContainer(BuildContext context, Size mq) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: mq.height * 0.5,
          child: Center(
            child: Container(
              padding: const EdgeInsets.only(top: 30, right: 30, left: 30),
              child: Column(
                children: [
                  SizedBox(
                    height: mq.height * 0.05,
                  ),
                  const Text(
                    "Enter your 4-digit code",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      color: kBaseColor,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    k2FactorSMS,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: kBaseColor,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  PinCodeTextField(
                      appContext: context,
                      keyboardType: TextInputType.number,
                      controller: _otpText1,
                      length: 4,
                      onChanged: (value) {
                        // print(value);
                      },
                      cursorColor: kBaseLightColor,
                      autoFocus: true,
                      pinTheme: PinTheme(
                        selectedColor: kBaseLightColor,
                        activeColor: kBaseLightColor,
                        inactiveColor: kBaseLightColor,
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 60,
                        fieldWidth: 60,
                        activeFillColor: Colors.white,
                      )),

                  //  buildContainer(mq),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildText() {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(top: 100.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
        SizedBox(
          width: 200,
          height: 50.0,
          child: ElevatedButton(
            onPressed: () {
              if (_otpText1.text.length != 4) {
                const CustomAlertDialog().errorDialog("", kCorrectCode, context);
                // } else if (_otpText2.text == "") {
                //   const CustomAlertDialog().errorDialog("", kCorrectCode, context);
                // } else if (_otpText3.text == "") {
                //   const CustomAlertDialog().errorDialog("", kCorrectCode, context);
                // } else if (_otpText4.text == "") {
                //   const CustomAlertDialog().errorDialog("", kCorrectCode, context);
              } else {
                showCenterLoader(context, MediaQuery.of(context).size, kPleaseWait);
                var code = _otpText1.text.toString();
                _getValidateMFAData(code);
              }
            },
            child: const Text(kSetCode, style: TextStyle(fontSize: 16, fontFamily: 'Inter', fontWeight: FontWeight.w700)),
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: kBaseColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // <-- Radius
              ),
            ),
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
          Container(height: mq.height * 0.7, decoration: boxOTPBg(), padding: const EdgeInsets.only(right: 100, left: 100), child: buildText()),
        ],
      ),
    );
  }

  Widget buildOTPContainer(Size mq) {
    return AutofillGroup(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(
            height: 60,
            width: 60,
            child: Stack(
              children: [
                Align(
                  child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          child: CodeBoxOne(controller: _otpText1),
                          decoration: kInnerDecoration,
                        ),
                      ),
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage("assets/otp/rectangle.png"),
                        fit: BoxFit.fill,
                      ))),
                  alignment: AlignmentDirectional.center,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          SizedBox(
            height: 60,
            width: 60,
            child: Stack(
              children: [
                Align(
                  child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          child: CodeBoxOne(controller: _otpText2),
                          decoration: kInnerDecoration,
                        ),
                      ),
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage("assets/otp/rectangle.png"),
                        fit: BoxFit.fill,
                      ))),
                  alignment: AlignmentDirectional.center,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          SizedBox(
            height: 60,
            width: 60,
            child: Stack(
              children: [
                Align(
                  child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          child: CodeBoxOne(controller: _otpText3),
                          decoration: kInnerDecoration,
                        ),
                      ),
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage("assets/otp/rectangle.png"),
                        fit: BoxFit.fill,
                      ))),
                  alignment: AlignmentDirectional.center,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          SizedBox(
            height: 60,
            width: 60,
            child: Stack(
              children: [
                Align(
                  child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          child: CodeBoxOne(controller: _otpText4),
                          decoration: kInnerDecoration,
                        ),
                      ),
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage("assets/otp/rectangle.png"),
                        fit: BoxFit.fill,
                      ))),
                  alignment: AlignmentDirectional.center,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _navigateToNextScreen(BuildContext context, String screen) {
    Future.delayed(const Duration(milliseconds: 1000), () {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => BioMetricsScreen(screen: screen)), (Route<dynamic> route) => false);
    });
  }

  void _navigateToHomeScreen(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1000), () {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const HomeScreen()), (Route<dynamic> route) => false);
    });
  }
}
