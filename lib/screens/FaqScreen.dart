import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:money_carer/constant/constant.dart';

import '../constant/constant.dart';
import '../data/api/ApiService.dart';
import '../widgets/TopContainer.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  _FaqScreen createState() => _FaqScreen();
}

class _FaqScreen extends State<FaqScreen> {
  // final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isQuestionOneVisible = true;
  dynamic faq;
  List<dynamic>? faqList = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    faq = (await ApiService().getFAQ())!;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        faq = faq;
        faqList?.addAll(faq['data']['faqItems']);
        if (kDebugMode) {
          print(faqList);
        }
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
      body: faq == null || faq!.isEmpty
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
                    TopContainer(
                      mq: mq,
                      screen: "FAQ",
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
              padding: const EdgeInsets.only(top: 30, right: 30, left: 30),
              child: Column(
                children: [
                  SizedBox(
                    height: mq.height * 0.05,
                  ),
                  const Text(
                    "FAQ",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 26, color: kBaseColor, fontFamily: 'Poppins', fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: const Text(
                      kFAQText,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: kBaseColor, fontFamily: 'Inter', fontWeight: FontWeight.w600),
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

  Widget buildQuestionContainer() {
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    return ListView.builder(
      itemCount: faqList!.length,
      itemBuilder: (context, i) {
        return Column(children: <Widget>[
          Theme(
            data: theme,
            child: IgnorePointer(
              ignoring: false,
              child: ExpansionTile(
                title: buildQuestionTitleContainer(faqList![i]['question']),
                trailing: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                ),
                children: <Widget>[
                  buildQuestionOneContainer(faqList![i]['answer']),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          buildDivider()
        ]);
      },
    );
  }

  Widget buildBottomContainer(Size mq) {
    return Positioned(
      left: mq.width * 0.00,
      right: mq.width * 0.00,
      top: mq.height * 0.25,
      child: Column(
        children: [
          Container(
              height: mq.height * 0.8, decoration: boxOTPBg(), padding: const EdgeInsets.only(top: 40, right: 10, left: 10), child: buildQuestionContainer()),
        ],
      ),
    );
  }

  Widget buildQuestionTitleContainer(String title) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.zero,
          alignment: Alignment.centerLeft,
          child: TextButton(
              child: Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 18.0, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
              ),
              onPressed: null),
        ),
      ],
    );
  }

  Widget buildQuestionOneContainer(String msg) {
    return Visibility(
      visible: isQuestionOneVisible,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 25, right: 25),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                msg,
                style: const TextStyle(color: Colors.white, fontSize: 12.0, fontFamily: 'Poppins', fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider() {
    return Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        child: const Divider(
          height: 5,
          color: Colors.white,
        ));
  }
}

class Faq {
  final String id;
  final String question;
  final String answer;

  Faq(this.id, this.question, this.answer);
}
