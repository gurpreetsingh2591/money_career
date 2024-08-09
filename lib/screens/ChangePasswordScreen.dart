import 'package:flutter/material.dart';
import 'package:money_carer/constant/constant.dart';
import 'package:money_carer/utils/shared_preferences/shared_prefs.dart';
import 'package:money_carer/widgets/PasswordField.dart';

import '../constant/constant.dart';
import '../data/api/ApiService.dart';
import '../utils/center_loader.dart';
import '../widgets/TopContainer.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreen createState() => _ChangePasswordScreen();
}

class _ChangePasswordScreen extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordText = TextEditingController();
  final _confirmPasswordText = TextEditingController();
  bool isLoading = false;

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
                screen: "changePassword",
              ),
              buildBackContainer(context, mq),
              buildBottomContainer(mq),
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
        SizedBox(
          height: mq.height * 0.7,
          child: Center(
            child: Container(
              padding: const EdgeInsets.only(top: 30, right: 30, left: 30),
              child: Column(
                children: [
                  SizedBox(
                    height: mq.height * 0.05,
                  ),
                  const Text(
                    kChangePassword,
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
                    kChangePasswordText,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: kBaseColor, fontSize: 12.0, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                  ),
                  buildInputContainer(mq)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildButtonContainer() {
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
          width: 250,
          height: 50.0,
          child: ElevatedButton(
            onPressed: () {
              if (_passwordText.text.toString().isEmpty) {
              } else if (_confirmPasswordText.text.toString().isEmpty) {
              } else {
                if (_confirmPasswordText.text.toString() == _passwordText.text.toString()) {
                  if (mounted) {
                    setState(() {
                      showCenterLoader(context, MediaQuery.of(context).size, kPleaseWait);
                      ApiService().getChangePassword(SharedPrefs().getTokenKey().toString(), _passwordText.text, context);
                    });
                  }
                } else {}
              }
            },
            child: const Text(kChangePassword, style: TextStyle(fontSize: 18, fontFamily: 'Inter', fontWeight: FontWeight.w700)),
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
      top: mq.height * 0.7,
      child: Column(
        children: [
          Container(height: mq.height * 0.7, decoration: boxOTPBg(), padding: const EdgeInsets.only(right: 50, left: 50), child: buildButtonContainer()),
        ],
      ),
    );
  }

  Widget buildInputContainer(Size mq) {
    return Container(
      width: mq.width * 0.8,
      padding: EdgeInsets.only(left: mq.width * 0.00, right: mq.width * 0.00, top: mq.height * 0.04, bottom: mq.height * 0.01),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            buildTextField(),
            SizedBox(height: mq.height * 0.02),
            SizedBox(
              child: Stack(
                children: [
                  Align(
                    child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            child: PasswordField(controller: _passwordText, hintText: kNewPassword),
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
            SizedBox(height: mq.height * 0.02),
            SizedBox(
              child: Stack(
                children: [
                  Align(
                    child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            child: PasswordField(controller: _confirmPasswordText, hintText: kConfirmNewPassword),
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
            SizedBox(height: mq.height * 0.02),
          ],
        ),
      ),
    );
  }

  Widget buildTextField() {
    return Container(
      padding: const EdgeInsets.only(top: 40),
      child: const Text(
        kEnterNewPassword,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18, color: kBaseColor, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
      ),
    );
  }
}
