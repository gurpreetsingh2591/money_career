import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:money_carer/constant/constant.dart';
import 'package:money_carer/screens/BioMetricsScreen.dart';
import 'package:money_carer/utils/shared_preferences/shared_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/constant.dart';
import '../data/api/ApiService.dart';
import '../dialogs/custom_alert_dialog.dart';
import '../utils/center_loader.dart';
import '../widgets/CommonTextField.dart';
import '../widgets/PasswordField.dart';
import 'LoginScreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreen createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  @override
  void initState() {
    super.initState();
    initializePreference().whenComplete(() {
      setState(() {});
    });
  }

  final _formKey = GlobalKey<FormState>();
  Future<String?>? _futureRegister;
  final _emailText = TextEditingController();
  final _passwordText = TextEditingController();
  bool isLoading = false;
  bool isRegisterNotification = false;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          transform: Matrix4.translationValues(0.0, -50.0, 0.0),
          constraints: BoxConstraints(
            maxHeight: mq.height,
          ),
          child: ListView(
            children: [
              buildBackContainer(context, mq),
              buildInputContainer(mq),
              (_futureRegister == null) ? buildInputContainer(mq) : buildFutureBuilder(),
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
        Stack(
          children: [
            Image.asset('assets/login/ellipse_colored.png', width: mq.width, height: 320, fit: BoxFit.fill),
            Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: mq.height * 0.05,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset('assets/login/logo_img.png', scale: 3.5),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    kSignUp,
                    style: TextStyle(
                      fontSize: 26.0,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildInputContainer(Size mq) {
    return Container(
      padding: EdgeInsets.only(left: mq.width * 0.1, right: mq.width * 0.1, bottom: mq.height * 0.04),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              kSignUpText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.0,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                color: kBaseColor,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              child: Align(
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
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              child: Align(
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
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: mq.width * 0.8,
              alignment: Alignment.centerLeft,
              child: buildContainer(mq),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              alignment: Alignment.center,
              child: TextButton(
                child: const Text(
                  "Already have an account? Sign in here",
                  style: TextStyle(
                    color: kBaseColor,
                    fontSize: 12.0,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () => _navigateToLoginScreen(context),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: SizedBox(
                width: 250,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () {
                    if (_emailText.text == "") {
                      const CustomAlertDialog().errorDialog("", kEmailNullError, context);
                    } else if (_passwordText.text == "") {
                      const CustomAlertDialog().errorDialog("", kPassNullError, context);
                    } else if (_passwordText.text.length < 6) {
                      const CustomAlertDialog().errorDialog("", kShortPassError, context);
                    } else {
                      // bool emailValid = emailValidatorRegExp.hasMatch(_emailText.text);
                      // if (!emailValid) {
                      //   const CustomAlertDialog().dialog(
                      //       "Email", "Please enter valid email", context);
                      // } else {

                      setState(() {
                        showCenterLoader(context, MediaQuery.of(context).size, kPleaseWait);
                        _futureRegister = ApiService().getUsersRegister(_emailText.text, _passwordText.text, context);
                      });
                      //}
                    }
                  },
                  child: const Text(kSignUp, style: TextStyle(fontSize: 20, fontFamily: 'Segoe UI')),
                  style: ElevatedButton.styleFrom(
                    primary: kBaseColor,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // <-- Radius
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildContainer(Size mq) {
    return Container(
        alignment: Alignment.topLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            (isRegisterNotification == false)
                ? Container(
                    width: 30,
                    child: Material(
                        child: InkWell(
                      onTap: () {
                        setState(() {
                          isRegisterNotification = true;
                        });
                      },
                      child: Image.asset(
                        'assets/login/rectangle_checkbox_bg.png',
                      ),
                    )),
                    height: 25,
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.only(right: 10, top: 10),
                  )
                : Container(
                    width: 30,
                    child: Material(
                        child: InkWell(
                      onTap: () {
                        setState(() {
                          isRegisterNotification = false;
                        });
                      },
                      child: Image.asset(
                        'assets/home/checked_checkbox.png',
                      ),

                      //child: Image.asset('assets/home/profile_circle.png', scale:3),),
                    )),
                    height: 25,
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.only(right: 10, top: 10),
                  ),
            Container(
              width: mq.width * 0.6,
              margin: const EdgeInsets.only(top: 10),
              child: const Text(
                kNotificationText,
                maxLines: 4,
                style: TextStyle(fontSize: 11, color: kBaseColor, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ));
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

  void _navigateToOTPScreen(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1000), () {
      Navigator.of(context).pop();
      Navigator.pop(context);
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (c, a1, a2) => const BioMetricsScreen(
            screen: "signup",
          ),
          transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    });
  }

  FutureBuilder<String?> buildFutureBuilder() {
    return FutureBuilder<String?>(
      future: _futureRegister,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic> data = json.decode(snapshot.data!);
          var errorMsg = data['error'];
          //ErrorHandlingModel errorHandlingModel = ErrorHandlingModel(error: data['error']);
          if (errorMsg != null) {
            if (errorMsg["message"].toString() == "EMAIL_EXISTS") {
              Future(() {
                const CustomAlertDialog().errorDialog("", "You are already registered, please try to Sign In", context);
                _futureRegister = null;
              });
            }
          } else {
            // isLoading = true;
            var idToken = jsonDecode(snapshot.data!)['idToken'];
            // var kind = jsonDecode(snapshot.data!)['kind'];
            var email = jsonDecode(snapshot.data!)['email'];
            var refreshToken = jsonDecode(snapshot.data!)['refreshToken'];
            // var expiresIn = jsonDecode(snapshot.data!)['expiresIn'];
            // var localId = jsonDecode(snapshot.data!)['localId'];
            // var displayName = jsonDecode(snapshot.data!)['displayName'];
            //var registered = jsonDecode(snapshot.data!)['registered'];

            SharedPrefs().setRefreshTokenKey(refreshToken);
            SharedPrefs().setTokenKey(idToken);
            SharedPrefs().setIsSignUp(true);
            SharedPrefs().setIsLogin(true);
            SharedPrefs().setIsUserRegister(false);
            SharedPrefs().setUserEmail(email);
            _navigateToOTPScreen(context);
            // print(email);
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
}
