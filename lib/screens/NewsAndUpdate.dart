import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:money_carer/constant/constant.dart';

import '../ItemListAdapter/NewsList.dart';
import '../constant/NavigationDrawer.dart';
import '../constant/constant.dart';
import '../data/api/ApiService.dart';

class NewsAndUpdateScreen extends StatefulWidget {
  const NewsAndUpdateScreen({Key? key}) : super(key: key);

  @override
  _NewsAndUpdateScreen createState() => _NewsAndUpdateScreen();
}

class _NewsAndUpdateScreen extends State<NewsAndUpdateScreen> {
  //final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  dynamic news;
  List<dynamic>? newList = [];
  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    news = (await ApiService().getFAQ())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          news = news;

          newList?.addAll(news['data']['feedItems']);

          if (kDebugMode) {
            print(newList);
          }
        }));
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
        child: Container(
          constraints: BoxConstraints(
            maxHeight: mq.height,
          ),
          child: Stack(
            children: [
              buildTopBarContainer(context, mq),
              buildNewsContainer(context, mq),
              buildNewsListContainer(mq),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTopBarContainer(BuildContext context, Size mq) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.only(right: 20, left: 10),
          height: mq.height * 0.15,
          child: Align(
            alignment: Alignment.centerRight,
            child: Material(
              child: InkWell(
                onTap: () {
                  _scaffoldKey.currentState?.openEndDrawer();
                },
                child: Image.asset('assets/home/profile_circle.png', scale: 3),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildNewsContainer(BuildContext context, Size mq) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          child: Center(
            child: Container(
              padding: const EdgeInsets.only(top: 60, right: 30, left: 30),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "News & updates",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 26, color: kBaseColor, fontFamily: 'Poppins', fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    kNewsText,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: kBaseColor, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
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
      ],
    );
  }

  Widget buildNewsListContainer(Size mq) {
    return Positioned(
      left: mq.width * 0.00,
      right: mq.width * 0.00,
      top: mq.height * 0.3,
      child: Column(
        children: [
          Container(
            height: mq.height * 0.7,
            decoration: boxOTPBg(),
            padding: const EdgeInsets.only(top: 40, right: 20, left: 20, bottom: 20),
            child: news == null || news.isEmpty
                ? const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)))
                : NewListScreen(items: newList!),
            // child: buildText()
          ),
        ],
      ),
    );
  }
}
