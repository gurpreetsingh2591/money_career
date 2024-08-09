import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:money_carer/constant/constant.dart';
import 'package:money_carer/screens/HomeScreen.dart';

import '../constant/constant.dart';
import '../data/api/ApiService.dart';
import '../widgets/TopContainer.dart';

class TermsConditionScreen extends StatefulWidget {
  const TermsConditionScreen({Key? key}) : super(key: key);

  @override
  _TermsConditionScreen createState() => _TermsConditionScreen();
}

class _TermsConditionScreen extends State<TermsConditionScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  dynamic term;
  List<dynamic>? terms = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    term = (await ApiService().getFAQ())!;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      //valueNotifier.value = _pcm; //provider
      setState(() {
        term = term['data']['term'];
        // terms?.addAll(term['data']['term']);
        if (kDebugMode) {
          print(terms);
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
      body: term == null || term!.isEmpty
          ? const Center(
              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(kBaseColor)),
            )
          : Container(
              constraints: BoxConstraints(
                maxHeight: mq.height,
              ),
              child: Stack(
                children: [
                  TopContainer(
                    mq: mq,
                    screen: "termCondition",
                  ),
                  buildBackContainer(context, mq),
                  buildBottomContainer(mq),
                ],
              ),
            ),
    );
  }

  Widget buildBackContainer(BuildContext context, Size mq) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            child: Center(
              child: Container(
                padding: const EdgeInsets.only(top: 60, right: 20, left: 20, bottom: 150),
                child: Column(
                  children: [
                    Text(
                      term['title'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 26, color: kBaseColor, fontFamily: 'Poppins', fontWeight: FontWeight.w700),
                    ),
                    Markdown(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      data: term['content'],
                      styleSheet: MarkdownStyleSheet.fromTheme(ThemeData(
                          textTheme:
                              const TextTheme(bodyText2: TextStyle(fontSize: 12.0, color: kBaseColor, fontFamily: 'Inter', fontWeight: FontWeight.w600)))),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildText() {
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
              _navigateToNextScreen(context);
            },
            child: const Text(kAgree, style: TextStyle(fontSize: 16, fontFamily: 'Inter', fontWeight: FontWeight.w700)),
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
      top: mq.height * 0.8,
      child: Column(
        children: [
          Container(height: mq.height * 0.8, decoration: boxOTPBg(), padding: const EdgeInsets.only(right: 100, left: 100), child: buildText()),
        ],
      ),
    );
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const HomeScreen()), (Route<dynamic> route) => false);
  }
}
