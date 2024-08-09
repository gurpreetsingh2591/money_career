import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:money_carer/constant/constant.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constant/constant.dart';
import '../widgets/TopContainer.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({Key? key}) : super(key: key);

  @override
  _DeleteAccountScreen createState() => _DeleteAccountScreen();
}

class _DeleteAccountScreen extends State<DeleteAccountScreen> {
  //final _formKey = GlobalKey<FormState>();
  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: kSupportMail,
  );
  final Uri telLaunchUri = Uri(
    scheme: 'tel',
    path: kSupportPhone,
  );
  _callNumber() async {
    const number = kSupportPhone; //set the number here
    // ignore: unused_local_variable
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
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
                screen: "deleteAccount",
              ),
              buildScreenDetailContainer(context, mq),
              buildBottomContainer(mq),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildScreenDetailContainer(BuildContext context, Size mq) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: mq.height * 0.3,
          child: Center(
            child: Container(
              padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
              child: Column(
                children: [
                  SizedBox(
                    height: mq.height * 0.05,
                  ),
                  const Text(
                    kDeleteAccount,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 26, color: kBaseColor, fontFamily: 'Poppins', fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    kDeleteAccountInfo,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: kBaseColor, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildButtonContainer(Size mq) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: mq.height * 0.7,
          child: Center(
            child: Container(
              padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
              child: Column(
                children: [
                  const Text(
                    kCallToMoneyCarerText,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.white, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    kCallingInfo,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.white, fontFamily: 'Poppins', fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () async {
                      _callNumber();
                      //toast("message", false);
                      // launchUrl(telLaunchUri);
                    },
                    child: const Text(
                      kSupportPhone,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.white, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    kEmailInfo,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.white, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    kAccountDeleteInfo,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.white, fontFamily: 'Poppins', fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () async {
                      if (await canLaunchUrl(emailLaunchUri)) {
                        launchUrl(emailLaunchUri);
                      } else {
                        throw "Could not launch $emailLaunchUri";
                      }

                      //launchUrl(emailLaunchUri);
                    },
                    child: const Text(
                      kSupportMail,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.white, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
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
      top: mq.height * 0.3,
      child: Column(
        children: [
          Container(
              height: mq.height * 0.8,
              decoration: boxOTPBg(),
              padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
              margin: const EdgeInsets.only(top: 20),
              child: buildButtonContainer(mq)),
        ],
      ),
    );
  }
}
