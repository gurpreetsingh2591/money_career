import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:money_carer/constant/constant.dart';
import 'package:money_carer/screens/BioMetricsScreen.dart';
import 'package:money_carer/screens/SignUpScreen.dart';
import 'package:money_carer/widgets/CommonTextField.dart';
import 'package:money_carer/widgets/PasswordField.dart';

import '../constant/constant.dart';
import '../data/api/ApiService.dart';
import '../dialogs/custom_alert_dialog.dart';
import '../utils/center_loader.dart';
import '../utils/shared_preferences/shared_prefs.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  // final _formKey = GlobalKey<FormState>();
  final _emailText = TextEditingController();
  final _passwordText = TextEditingController();
  Future<String?>? _futureLogin;
  bool isLoading = false;

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
              (_futureLogin == null) ? buildInputContainer(mq) : buildFutureBuilder(),
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
        Stack(
          children: [
            Image.asset('assets/login/ellipse_colored.png', width: mq.width, height: 300, fit: BoxFit.fill),
            Center(
              child: Column(
                children: <Widget>[
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
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset('assets/login/logo_img.png', scale: 3.5),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(kSignIn,
                      style: TextStyle(
                        fontSize: 26.0,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildInputContainer(Size mq) {
    return Positioned(
      left: mq.width * 0.055,
      right: mq.width * 0.055,
      top: mq.height * 0.5,
      child: Container(
        width: mq.width * 0.8,
        padding: EdgeInsets.only(left: mq.width * 0.05, right: mq.width * 0.05, top: mq.height * 0.02, bottom: mq.height * 0.01),
        child: Form(
          // key: _formKey,
          child: Column(
            children: [
              const Text(
                kSignInText,
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
              SizedBox(
                child: Stack(
                  children: [
                    Align(
                      child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              child: CommonTextField(controller: _emailText, hintText: kEnterEmail),
                              decoration: kInnerDecoration,
                            ),
                          ),
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage("assets/login/edit_bg.png"),
                            fit: BoxFit.fill,
                          ))),
                      alignment: AlignmentDirectional.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                child: Stack(
                  children: [
                    Align(
                      child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              child: PasswordField(controller: _passwordText, hintText: kEnterPassword),
                              decoration: kInnerDecoration,
                            ),
                          ),
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage("assets/login/edit_bg.png"),
                            fit: BoxFit.fill,
                          ))),
                      alignment: AlignmentDirectional.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  child: const Text(
                    kDoNotHaveAccountText,
                    style: TextStyle(
                      color: kBaseColor,
                      fontSize: 12.0,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () => _navigateToRegisterScreen(context),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 250,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () {
                    if (_emailText.text.toString() == "") {
                      const CustomAlertDialog().errorDialog("", kEmailNullError, context);
                    } else if (_passwordText.text.toString() == "") {
                      const CustomAlertDialog().errorDialog("", kPassNullError, context);
                    } else if (_passwordText.text.length < 6) {
                      const CustomAlertDialog().errorDialog("", kShortPassError, context);
                    } else {
                      // if (!emailValidatorRegExp.hasMatch(_emailText.text.toString())) {
                      //   const CustomAlertDialog().dialog(
                      //       "Email", "Please enter valid email", context);
                      // } else {
                      if (mounted) {
                        setState(() {
                          showCenterLoader(context, MediaQuery.of(context).size, kPleaseWait);
                          _futureLogin = ApiService().getUserLogin(_emailText.text.toString(), _passwordText.text.toString(), context);
                        });
                        // }
                        // _navigateToOTPScreen(context);
                      }
                    }
                  },
                  child: const Text(kSignIn,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      )),
                  style: ElevatedButton.styleFrom(
                    primary: kBaseColor,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // <-- Radius
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSkipContainer(Size mq) {
    return Positioned(
      left: mq.width * 0.00,
      right: mq.width * 0.00,
      top: mq.height * 0.850,
      child: Container(
        height: mq.height * 0.5,
        decoration: boxBottom(),
        padding: const EdgeInsets.only(right: 20.0, left: 20),
      ),
    );
  }

  void _navigateToRegisterScreen(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => const SignUpScreen(),
        transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  void _navigateToOTPScreen(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1000), () {
      Navigator.of(context).pop();
      Navigator.pop(context);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => const BioMetricsScreen(
                    screen: "login",
                  )),
          (Route<dynamic> route) => false);
    });
  }

  FutureBuilder<String?> buildFutureBuilder() {
    return FutureBuilder<String?>(
      future: _futureLogin,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //  isLoading=true;
          Map<String, dynamic> data = json.decode(snapshot.data!);
          var errorMsg = data['error'];
          //ErrorHandlingModel errorHandlingModel = ErrorHandlingModel(error: data['error']);
          if (errorMsg != null) {
            if (errorMsg["message"].toString() == "EMAIL_NOT_FOUND") {
              Future(() {
                const CustomAlertDialog().errorDialog("", "Your email not registered, Please sign Up", context);
                _futureLogin = null;
              });
            } else if (errorMsg["message"].toString() == "INVALID_PASSWORD") {
              Future(() {
                const CustomAlertDialog().errorDialog("", "You appear to have entered an invalid password", context);
                _futureLogin = null;
              });
            }
          } else {
            // isLoading=true;
            var idToken = jsonDecode(snapshot.data!)['idToken'];
            // var kind = jsonDecode(snapshot.data!)['kind'];
            var email = jsonDecode(snapshot.data!)['email'];
            var refreshToken = jsonDecode(snapshot.data!)['refreshToken'];
            // var expiresIn = jsonDecode(snapshot.data!)['expiresIn'];
            // var localId = jsonDecode(snapshot.data!)['localId'];
            // var displayName = jsonDecode(snapshot.data!)['displayName'];
            // var registered = jsonDecode(snapshot.data!)['registered'];

            SharedPrefs().removeTokenKey;
            SharedPrefs().setTokenKey(idToken);
            SharedPrefs().setRefreshTokenKey(refreshToken);
            SharedPrefs().setIsLogin(true);
            SharedPrefs().setUserEmail(email);
            _navigateToOTPScreen(context);
            if (kDebugMode) {
              print(email);
            }
          }
          isLoading = false;
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        } else {
          return Text('${snapshot.error}');
        }

        return isLoading ? const Center(child: CircularProgressIndicator()) : const Text("");
      },
    );
  }

  void errorDialog() {}
}
