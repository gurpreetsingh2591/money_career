import 'package:flutter/material.dart';
import 'package:money_carer/constant/constant.dart';

import '../ItemListAdapter/NewsList.dart';
import '../constant/NavigationDrawer.dart';
import '../constant/constant.dart';
import '../data/api/ApiService.dart';
import '../utils/shared_preferences/shared_prefs.dart';
import '../widgets/CommonTextField.dart';

class RegisterForAccountScreen extends StatefulWidget {
  const RegisterForAccountScreen({Key? key}) : super(key: key);

  @override
  _RegisterForAccountScreen createState() => _RegisterForAccountScreen();
}

class _RegisterForAccountScreen extends State<RegisterForAccountScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  final _nameText = TextEditingController();
  final _dobText = TextEditingController();
  final _phoneText = TextEditingController();
  final _noteText = TextEditingController();
  late List<dynamic>? requestList = [];
  List<dynamic>? newList = [];
  dynamic news;
  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    news = (await ApiService().getFAQ())!;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      //valueNotifier.value = _pcm; //provider
      setState(() {
        news = news;
        newList?.addAll(news['data']['feedItems']);
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
      key: _scaffoldKey,
      endDrawer: const NavigationDrawer(),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            constraints: BoxConstraints(
              maxHeight: mq.height,
            ),
            child: ListView(
              children: [
                buildTopContainer(context, mq),
                buildDetailContainer(context, mq),
                buildNewsContainer(mq),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget buildTopContainer(BuildContext context, Size mq) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.only(right: 20, left: 10),
          height: mq.height * 0.1,
          child: Align(
            alignment: Alignment.centerRight,
            child: Material(
              child: InkWell(
                onTap: () {
                  _scaffoldKey.currentState?.openEndDrawer();
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset('assets/home/profile_circle.png', scale: 3),
                ),
              ),

              //child: Image.asset('assets/home/profile_circle.png', scale:3),),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDetailContainer(BuildContext context, Size mq) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
            child: Center(
          child: Container(
            padding: const EdgeInsets.only(right: 30, left: 30),
            child: Column(
              children: [
                Text(
                  "Hi " + SharedPrefs().getUserFullName().toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20.0, fontFamily: 'Poppins', fontWeight: FontWeight.w700, color: kBaseColor),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  kRegisterAnAccountIpsum,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: kBaseColor,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: 250,
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      _modalBottomSheetMenu();
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                    padding: const EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(colors: [kBaseLightColor, kBaseColor]),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: Container(
                        constraints: const BoxConstraints(minWidth: 88.0, minHeight: 36.0),
                        // min sizes for Material buttons
                        alignment: Alignment.center,
                        child: const Text(kRegisterAnAccount,
                            style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Inter', fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),
      ],
    );
  }

  Widget buildNewsContainer(Size mq) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
              margin: const EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/otp/ellipse_bottom.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: buildNewsListContainer(mq)),
        ],
      ),
    );
  }

  Widget buildNewsListContainer(Size mq) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 60, left: 25),
          alignment: Alignment.centerLeft,
          child: const Text(kLatestNews,
              textAlign: TextAlign.left, style: TextStyle(fontSize: 18, fontFamily: 'Poppins', fontWeight: FontWeight.w600, color: Colors.white)),
        ),
        Container(
          height: mq.height * 0.7,
          padding: const EdgeInsets.only(
            top: 10,
            right: 20,
            left: 20,
          ),
          child: news == null || news.isEmpty
              ? const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)))
              : NewListScreen(items: newList!),
          // child: buildText()
        ),
      ],
    );
  }

  void _modalBottomSheetMenu() {
    final mq = MediaQuery.of(context).size;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.9,
          child: Container(
            constraints: BoxConstraints(
              maxHeight: mq.height,
            ),
            child: Stack(
              children: [
                buildDialogRegisterContainer(context, mq),
                buildDialogBottomContainer(mq),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildDialogRegisterContainer(BuildContext context, Size mq) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: mq.height * 0.7,
          child: Center(
            child: Container(
              padding: const EdgeInsets.only(top: 10, right: 30, left: 30),
              child: Column(
                children: [
                  SizedBox(
                    height: mq.height * 0.05,
                  ),
                  const Text(
                    kRegisterAnAccount,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 26.0, fontFamily: 'Poppins', fontWeight: FontWeight.w700, color: kBaseColor),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ),
                  const Text(
                    kFillDetailInfo,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: kBaseColor, fontFamily: 'Inter', fontWeight: FontWeight.w600),
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

  Widget buildDialogSubmitContainer() {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(top: 50.0),
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
              ApiService().getRequestCreate(_nameText.text, _dobText.text, _phoneText.text, _noteText.text, context);
            },
            child: const Text('Register', style: TextStyle(fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
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

  Widget buildDialogBottomContainer(Size mq) {
    return Positioned(
      left: mq.width * 0.00,
      right: mq.width * 0.00,
      top: mq.height * 0.7,
      child: Column(
        children: [
          Container(height: mq.height * 0.7, decoration: boxOTPBg(), padding: const EdgeInsets.only(right: 50, left: 50), child: buildDialogSubmitContainer()),
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
                            child: CommonTextField(controller: _nameText, hintText: kEnterName),
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
                            child: CommonTextField(
                              controller: _phoneText,
                              hintText: kEnterPhone,
                            ),
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
                            child: buildAboutSelfField(),
                            decoration: kInnerDecoration,
                          ),
                        ),
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage("assets/scan/note_bg.png"),
                          fit: BoxFit.fill,
                        ))),
                    alignment: AlignmentDirectional.center,
                  ),
                ],
              ),
            ),
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
            hintText: 'Date of Birth',
            contentPadding: EdgeInsets.all(10.0),
          ),
          onTap: () => _selectDate(context),
        ),
      ),
    );
  }

  Widget buildAboutSelfField() {
    return Container(
      color: Colors.white,
      child: TextFormField(
        //obscureText: true,
        style: const TextStyle(
          fontSize: 14,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
          color: kBaseColor,
        ),
        maxLines: 5,
        keyboardType: TextInputType.text,
        controller: _noteText,
        textAlign: TextAlign.left,
        onEditingComplete: () => FocusScope.of(context).nextFocus(),
        textInputAction: TextInputAction.done,
        decoration: const InputDecoration(
          border: InputBorder.none,
          counterText: '',
          hintStyle: TextStyle(fontSize: 14.0, color: kBaseColor),
          hintText: 'Note',
          contentPadding: EdgeInsets.all(10.0),
        ),
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
