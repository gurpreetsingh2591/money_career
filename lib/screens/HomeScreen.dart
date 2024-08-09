import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:money_carer/constant/constant.dart';
import 'package:money_carer/screens/OTPVerifyScreen.dart';
import 'package:money_carer/screens/SendVideoScreen.dart';
import 'package:money_carer/screens/SingleAccountScreen.dart';
import 'package:money_carer/screens/UserRegisterScreen.dart';
import 'package:money_carer/utils/shared_preferences/shared_prefs.dart';
import 'package:money_carer/widgets/AccountHolderNameContainer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ItemListAdapter/NewsList.dart';
import '../constant/NavigationDrawer.dart';
import '../constant/constant.dart';
import '../data/api/ApiService.dart';
import '../dialogs/custom_alert_dialog.dart';
import '../widgets/BalanceContainer.dart';
import '../widgets/TransactionContainer.dart';
import 'RegisterForAccountScreen.dart';
import 'ScanReceiptScreen.dart';
import 'dialogs/ExtraFundsDialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  //final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late bool _welcomeContainerVisible = false;
  late bool _2MFA = false;

  late final List<bool> _buttonContainerVisible = [];
  late bool _isProcess = false;
  dynamic news;
  List<dynamic>? newList = [];
  late List<dynamic>? accountList = [];
  late List<dynamic>? registerAccount = [];
  late List<dynamic>? registerAccountList = [];
  Future<List<dynamic>?>? futureAccount;
  Future<dynamic>? futureRegister;
  late List<dynamic>? transactionList = [];

  late List<dynamic>? transactionListNew = [];
  Future<List<dynamic>?>? transactionListTotal;

  late dynamic register;
  final _requestText = TextEditingController();
  final _fundText = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    SharedPrefs().setInitValue(10);
    initializePreference().whenComplete(() {
      if (SharedPrefs().getRefreshTokenKey().toString() != "") {
        if (SharedPrefs().getTokenTime() == null) {
          ApiService().getUserIDTokenRefresh(context);
        } else {
          DateTime datetime = DateTime.now();
          DateTime savedDateTime = DateTime.parse(SharedPrefs().getTokenTime().toString());
          final difference = datetime.difference(savedDateTime).inMinutes;
          if (kDebugMode) {
            print("difference" + difference.toString());
          }
          if (difference > 50) {
            ApiService().getUserIDTokenRefresh(context);
          }
        }
      }
      _getData();
      // if (SharedPrefs().isUserRegister() == true) {
      _getDataAfterRegister();
      // }
    });
  }

  Future<void> initializePreference() async {
    SharedPrefs.init(await SharedPreferences.getInstance());
  }

  void _getIsUserRegister() async {
    setState(() {
      _welcomeContainerVisible = SharedPrefs().isUserRegister();
      _2MFA = SharedPrefs().isUser2MFA();
      if (!_welcomeContainerVisible) {
        _navigateToRegisterScreen(context);
      } else if (_welcomeContainerVisible && !_2MFA) {
        _navigateToOTPScreen(
          context,
          SharedPrefs().getUserPhone().toString(),
        );
      }
    });
  }

  void _navigateToRegisterScreen(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const UserRegisterScreen()), (Route<dynamic> route) => false);
  }

  void _navigateToOTPScreen(BuildContext context, String phone) {
    Navigator.of(context)
        .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => OTPVerifyScreen(phoneNo: phone, screen: "home")), (Route<dynamic> route) => false);
  }

  void _getData() async {
    final tmpRegister = await ApiService().getRegister();
    final tmpRegisterAccount = await ApiService().getRequestList();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //valueNotifier.value = _pcm; //provider
      setState(() {
        _isProcess = true;
        register = tmpRegister;

        registerAccount = tmpRegisterAccount;

        _getIsUserRegister();
      });
    });
  }

  Future<void> _getDataAfterRegister() async {
    news = (await ApiService().getFAQ())!;
    accountList = await ApiService().getAccountList();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //valueNotifier.value = _pcm; //provider
      setState(() {
        newList?.addAll(news['data']['feedItems']);
        if (kDebugMode) {
          print(newList);
        }
        accountList = accountList;
        news = news;
      });
    });
  }

  void transactionsListWidget(int index) async {
    transactionListTotal = ApiService().getTransactionList(accountList![index]['clientId'], accountList![index]['id'], 1, 5);
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
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      endDrawer: const NavigationDrawer(),
      body: !_isProcess
          ? const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(kBaseColor)))
          : SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Container(
                  constraints: BoxConstraints(
                    maxHeight: mq.height,
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    primary: false,
                    children: [
                      buildTopBarContainer(context, mq),
                      !_welcomeContainerVisible ? buildWelcomeContainer(context, mq, true) : buildUserDetailContainer(context, mq),
                      buildNewsContainer(mq),
                    ],
                  ),
                ),
              ]),
            ),
    );
  }

  Widget buildTopBarContainer(BuildContext context, Size mq) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 20, right: 20, left: 10),
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

  Widget buildWelcomeContainer(BuildContext context, Size mq, bool _welcomeContainerVisible) {
    return Visibility(
      visible: _welcomeContainerVisible,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            child: Center(
              child: Container(
                padding: const EdgeInsets.only(right: 50, left: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 50, right: 50),
                      child: const Text(
                        kWelcomeText,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 26, color: kBaseColor, fontFamily: 'Poppins', fontWeight: FontWeight.w800),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: const Text(
                        "",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: kBaseColor, fontFamily: 'Inter', fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    ),
                    SizedBox(
                      width: 250,
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          _navigateToNextScreen(context);
                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                        padding: const EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(colors: [kBaseLightColor, kBaseColor]),
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          ),
                          child: Container(
                            constraints: const BoxConstraints(minWidth: 88.0, minHeight: 36.0),
                            // min sizes for Material buttons
                            alignment: Alignment.center,
                            child: const Text(kRegister, style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Inter', fontWeight: FontWeight.w700)),
                          ),
                        ),
                      ),
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

  Widget buildUserDetailContainer(BuildContext context, Size mq) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              (accountList!.isNotEmpty)
                  ? ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: accountList!.length,
                      itemBuilder: (BuildContext context, int index) {
                        transactionsListWidget(index);
                        return buildUserAccountDetailContainer(accountList![index], mq, index);
                      })
                  : Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                      const SizedBox(
                        height: 50,
                        child: Text(kNotAccount),
                      ),
                      (registerAccount!.isEmpty) ? buildDialogSubmitContainer() : const Text("You have already submit request for an account!")
                    ]),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildUserAccountDetailContainer(dynamic accDetail, Size mq, int listIndex) {
    _buttonContainerVisible.add(false);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: GestureDetector(
            onTap: () {
              _navigateSingleAccountScreen(context, accDetail['clientId'].toString(), accDetail['id'].toString(), accDetail);
            },
            child: Container(
              decoration: kGradientBoxDecoration,
              padding: const EdgeInsets.only(bottom: 10, right: 15, left: 15),
              child: Column(
                children: [
                  (accDetail['allowanceLeft'].toString() != "0")
                      ? Column(children: [
                          BalanceContainer(accDetail: accDetail),
                          AccountHolderNameContainer(accDetail: accDetail),
                        ])
                      : AccountHolderNameContainer(accDetail: accDetail),
                  ((accDetail['access']['showTransactions'] == true)) ? buildTransactionFutureBuilder() : const Text("Loading.."),
                  (accDetail['access']['requestDiscretionary'] == true ||
                          accDetail['access']['sendImages'] == true ||
                          accDetail['access']['sendVideos'] == true)
                      ? buildBottomArrow(listIndex)
                      : const Text(""),
                  buildButtonContainer(context, mq, accDetail, listIndex)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildButtonContainer(BuildContext context, Size mq, dynamic accDetail, int index) {
    bool requestDictionary = accDetail['access']['requestDiscretionary'];
    bool sendImages = accDetail['access']['sendImages'];
    bool sendVideos = accDetail['access']['sendVideos'];
    return Visibility(
      visible: _buttonContainerVisible[index],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          requestDictionary == true && accDetail['allowanceLeft'].toString() != "0"
              ? SizedBox(
                  width: mq.width,
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () {
                      modalRequestExtraFundBottomDialog(
                        accDetail['clientId'],
                        accDetail['id'],
                        context,
                        mq,
                        accDetail['allowanceLeft'],
                      );
                    },
                    child: const Text(kExtraFund, style: TextStyle(fontSize: 16, fontFamily: 'Inter', fontWeight: FontWeight.w700)),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: kBaseColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15), // <-- Radius
                      ),
                    ),
                  ),
                )
              : const Text(""),
          sendImages == true
              ? Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: mq.width,
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () {
                      _navigateToScanReceiptScreen(context, accDetail['clientId']);
                    },
                    child: const Text(kScanReceipt, style: TextStyle(fontSize: 16, fontFamily: 'Inter', fontWeight: FontWeight.w700)),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: kBaseColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15), // <-- Radius
                      ),
                    ),
                  ),
                )
              : const Text(""),
          sendVideos == true
              ? Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: mq.width,
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () {
                      _navigateToSendVideoScreen(context, accDetail['clientId']);
                    },
                    child: const Text(kSendVideo, style: TextStyle(fontSize: 16, fontFamily: 'Inter', fontWeight: FontWeight.w700)),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: kBaseColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15), // <-- Radius
                      ),
                    ),
                  ),
                )
              : const Text(""),
        ],
      ),
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
                  fit: BoxFit.fitHeight,
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
          height: mq.height * 0.75,
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

  void _navigateToNextScreen(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => const UserRegisterScreen(),
        transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  void _navigateSingleAccountScreen(BuildContext context, String? _clientId, String? accId, dynamic accDetail) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => SingleAccountScreen(
          clientId: _clientId!,
          accId: accId!,
          accDetail: accDetail,
        ),
        transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  Widget buildBottomArrow(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
          child: Align(
            alignment: Alignment.center,
            child: IconButton(
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () {
                if (mounted) {
                  setState(() {
                    _buttonContainerVisible[index] = !_buttonContainerVisible[index];
                  });
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  void modalRequestExtraFundBottomDialog(String clientId, String accId, BuildContext context, Size mq, int maxAmount) {
    _fundText.text = "" + SharedPrefs().getInitValue().toString();
    setState(() {
      if (maxAmount > 10) {
        ExtraFundsDialog.show(context, mq, _fundText, _requestText, maxAmount, SharedPrefs().getInitValue()! + .0, clientId, accId);
      } else {
        const CustomAlertDialog().errorDialog("", "Your funds are low to request", context);
      }
    });
  }

  void _navigateToScanReceiptScreen(BuildContext context, String clientId) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => ScanReceiptScreen(
          clientId: clientId,
        ),
        transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  void _navigateToSendVideoScreen(BuildContext context, String clientId) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => SendVideoScreen(clientId: clientId),
        transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  void dispose() {
    SharedPrefs().setBioAuthTime("");
    super.dispose();
  }

  FutureBuilder<dynamic> buildTransactionFutureBuilder() {
    return FutureBuilder<dynamic>(
      future: transactionListTotal,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          transactionList = [];
          // List<dynamic> data = json.decode(snapshot.data!);
          transactionList!.addAll(snapshot.data!);
          isLoading = false;
        } else if (snapshot.hasError) {
          return const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)));
        } else {
          return const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)));
        }

        return isLoading
            ? const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)))
            : ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: 3,
                itemExtent: 30.0,
                itemBuilder: (BuildContext context, int index) {
                  return TransactionContainer(
                      date: transactionList![index]['date'].toString(),
                      name: transactionList![index]['narrative'][0].toString(),
                      amount: transactionList![index]['amount'].toString());
                });
      },
    );
  }

  Widget buildDialogSubmitContainer() {
    return Column(
      children: <Widget>[
        SizedBox(
          width: 250,
          height: 50.0,
          child: RaisedButton(
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => const RegisterForAccountScreen(),
                  transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                  transitionDuration: const Duration(milliseconds: 500),
                ),
              );
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
                child: const Text(kRegisterAnAccount, style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Inter', fontWeight: FontWeight.w700)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
