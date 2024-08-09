import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_carer/constant/constant.dart';
import 'package:money_carer/utils/shared_preferences/shared_prefs.dart';
import 'package:money_carer/widgets/CommonTextField.dart';

import '../constant/constant.dart';
import '../data/api/ApiService.dart';
import '../dialogs/custom_alert_dialog.dart';

class UserRegisterScreen extends StatefulWidget {
  const UserRegisterScreen({Key? key}) : super(key: key);

  @override
  _UserRegisterScreen createState() => _UserRegisterScreen();
}

class _UserRegisterScreen extends State<UserRegisterScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  final _nameText = TextEditingController();
  final _dobText = TextEditingController();
  final _phoneText = TextEditingController();
  bool isRegisterNotification = false;
  String initialValue = 'Tell us about yourself';
  List<String> tellUsAboutYourselfList = [
    'Tell us about yourself',
    'I’m a Client',
    'I’m a Carer',
    'I’m a Family Member',
    'I’m a Social Worker',
    'I’m a Solicitor',
    'I’m a Medical Professional'
  ];

  void _getData() {
    ApiService().getRequestForRegistration(_nameText.text.toString(), _dobText.text.toString(), _phoneText.text.toString(), initialValue.toString(), context);
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
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: mq.height,
          ),
          child: Stack(
            children: [
              buildTopContainer(context, mq),
              buildBackContainer(context, mq),
              buildBottomContainer(mq),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTopContainer(BuildContext context, Size mq) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
          height: mq.height * 0.1,
          child: Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: kBaseColor),
              onPressed: () {
                if (SharedPrefs().isUserRegister()) {
                  Navigator.pop(context);
                } else {
                  if (Platform.isAndroid) {
                    SystemNavigator.pop();
                  } else if (Platform.isIOS) {
                    exit(0);
                  }
                }
              },
            ),
          ),
        ),
      ],
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
              padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
              child: Column(
                children: [
                  SizedBox(
                    height: mq.height * 0.05,
                  ),
                  const Text(
                    kRegister,
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
                  Container(
                    padding: const EdgeInsets.only(left: 30.0, right: 30),
                    child: const Text(
                      kFillDetailInfo,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: kBaseColor, fontFamily: 'Inter', fontWeight: FontWeight.w600),
                    ),
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
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        SizedBox(
          width: 200,
          height: 50.0,
          child: ElevatedButton(
            onPressed: () {
              if (_nameText.text.toString() == "") {
                const CustomAlertDialog().errorDialog("", kEnterName, context);
              } else if (_dobText.text.toString() == "") {
                const CustomAlertDialog().errorDialog("", kEnterDob, context);
              } else {
                FocusScope.of(context).unfocus();
                _getData();
              }
            },
            child: const Text(kSubmit, style: TextStyle(fontSize: 16, fontFamily: 'Inter', fontWeight: FontWeight.w700)),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(children: [
            Image.asset('assets/otp/ellipse_bottom.png', width: mq.width, fit: BoxFit.fill),
            Container(alignment: Alignment.center, padding: const EdgeInsets.only(top: 100), child: buildButtonContainer()),
          ]),
        ],
      ),
    );
  }

  Widget buildInputContainer(Size mq) {
    return Container(
      width: mq.width * 0.8,
      padding: EdgeInsets.only(left: mq.width * 0.05, right: mq.width * 0.05, top: mq.height * 0.04, bottom: mq.height * 0.01),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              child: Stack(
                children: [
                  Align(
                    child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            child: CommonTextField(controller: _nameText, hintText: kEnterFullName),
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
                            child: buildDOBField(),
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
                            child: CommonTextField(controller: _phoneText, hintText: kEnterPhone),
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
                            child: buildAboutSelfField(mq),
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
            Row(
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
                        margin: const EdgeInsets.only(right: 10, top: 20),
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
                        margin: const EdgeInsets.only(right: 10, top: 20),
                      ),
                Container(
                    width: mq.width * 0.55,
                    margin: const EdgeInsets.only(top: 20),
                    child: const Text(
                      kNotificationText,
                      maxLines: 4,
                      style: TextStyle(fontSize: 11, color: kBaseColor, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildDOBField() {
    return Container(
      color: Colors.white,
      child: GestureDetector(
        child: TextFormField(
          readOnly: true,
          //obscureText: true,
          style: const TextStyle(
            fontSize: 14,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            color: kBaseColor,
          ),
          keyboardType: TextInputType.datetime,
          controller: _dobText,
          textAlign: TextAlign.left,
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: '',
            hintStyle: TextStyle(fontSize: 14.0, color: kBaseColor),
            hintText: 'Date of birth',
            contentPadding: EdgeInsets.all(10.0),
          ),
          onTap: () => _selectDate(context),
        ),
      ),
    );
  }

  Widget buildAboutSelfField(Size mq) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      width: mq.width,
      color: Colors.white,
      child: DropdownButton<String>(
        value: initialValue,
        isExpanded: true,
        icon: const Icon(Icons.keyboard_arrow_down),
        iconSize: 24,
        elevation: 16,
        dropdownColor: Colors.white,
        style: const TextStyle(
          fontSize: 14,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
          color: kBaseColor,
        ),
        underline: Container(
          height: 0,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String? data) {
          setState(() {
            initialValue = data!;
          });
        },
        items: tellUsAboutYourselfList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        initialDatePickerMode: DatePickerMode.day,
        helpText: ' ',
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1950, 1),
        lastDate: DateTime.now(),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: kBaseColor, // <-- SEE HERE
                onPrimary: Colors.white, // <-- SEE HERE
                onSurface: kBaseColor, // <-- SEE HERE
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: kBaseColor, // button text color
                ),
              ),
            ),
            child: child!,
          );
        });

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        var dateTime = DateTime.parse(selectedDate.toString());
        var dobFormat = "${dateTime.year}-${dateTime.month}-${dateTime.day}";
        _dobText.text = dobFormat.toString();
      });
    }
  }
}
