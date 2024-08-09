import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:money_carer/constant/constant.dart';
import 'package:money_carer/screens/dialogs/ExtraFundsDialog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';

import '../ItemListAdapter/NewsList.dart';
import '../constant/NavigationDrawer.dart';
import '../constant/constant.dart';
import '../data/api/ApiService.dart';
import '../dialogs/custom_alert_dialog.dart';
import '../utils/center_loader.dart';
import '../utils/shared_preferences/shared_prefs.dart';
import '../widgets/BalanceContainer.dart';
import '../widgets/SingleTransactionContainer.dart';
import '../widgets/TopContainer.dart';
import '../widgets/UserNameContainer.dart';
import 'ScanReceiptScreen.dart';
import 'SendVideoScreen.dart';

class SingleAccountScreen extends StatefulWidget {
  final String clientId;
  final String accId;

  final dynamic accDetail;

  const SingleAccountScreen({Key? key, required this.clientId, required this.accId, this.accDetail}) : super(key: key);

  @override
  _SingleAccountScreenState createState() => _SingleAccountScreenState();
}

class _SingleAccountScreenState extends State<SingleAccountScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late bool _buttonContainerVisible = false;
  String _selectedType = "";
  final _requestText = TextEditingController();
  final _fundText = TextEditingController();
  final amount = TextEditingController();
  late Uint8List statement;
  File? file;
  late List<dynamic>? transactionList = [];
  dynamic news;
  dynamic requestFund;
  List<dynamic>? newList = [];
  bool requestDictionary = false;
  bool sendImages = false;
  bool sendVideos = false;

  @override
  void initState() {
    super.initState();
    requestDictionary = widget.accDetail['access']['requestDiscretionary'];
    sendImages = widget.accDetail['access']['sendImages'];
    sendVideos = widget.accDetail['access']['sendVideos'];
    _getNewsData();
    transactionsListWidget();
  }

  void _changed(bool visibility) {
    setState(() {
      _buttonContainerVisible = visibility;
    });
  }

  void _getNewsData() async {
    news = (await ApiService().getFAQ())!;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        news = news;
        newList?.addAll(news['data']['feedItems']);

        if (kDebugMode) {
          print(newList);
        }
      });
    });
  }

  void transactionsListWidget() async {
    transactionList = (await ApiService().getTransactionList(widget.accDetail['clientId'], widget.accDetail['id'], 1, 100));

    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          transactionList = transactionList;
        }));
  }

  void _getData(String type) async {
    statement = (await ApiService().getStatement(widget.accDetail['clientId'], widget.accDetail['id'], type, context))!;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() async {
        statement = statement;
        file = await getPdf(statement);
        Navigator.of(context).pop();
        modalStatementBottomDialog(context);
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
              children: <Widget>[
                TopContainer(
                  mq: mq,
                  screen: "singleAccount",
                ),
                buildUserDetailContainer(context, mq),
                buildNewsContainer(mq),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget buildUserDetailContainer(BuildContext context, Size mq) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              buildUserAccountDetailContainer(context, mq),
              buildUserContainer(context, mq),
              (transactionList != null && transactionList!.isNotEmpty)
                  ? ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: transactionList!.length,
                      itemExtent: 40.0,
                      itemBuilder: (BuildContext context, int index) {
                        return SingleTransactionContainer(
                            date: transactionList![index]['date'].toString(),
                            name: transactionList![index]['narrative'][0].toString(),
                            amount: transactionList![index]['amount'].toString());
                      })
                  : const Text(""),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildUserAccountDetailContainer(BuildContext context, Size mq) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            decoration: kGradientBoxDecoration,
            padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BalanceContainer(accDetail: widget.accDetail),
                (widget.accDetail['access']['requestDiscretionary'] == true ||
                        widget.accDetail['access']['sendImages'] == true ||
                        widget.accDetail['access']['sendVideos'] == true)
                    ? buildBottomArrow()
                    : const Text(""),
                Container(child: buildButtonContainer(context, mq, widget.accDetail["allowanceLeft"])),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildUserContainer(BuildContext context, Size mq) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: mq.width,
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: mq.width * 0.7,
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          UserNameContainer(accDetail: widget.accDetail),
                        ],
                      ),
                    ),
                    widget.accDetail['access']['statements'] == true
                        ? Material(
                            child: InkWell(
                              onTap: () {
                                selectStatementTypeBottomSheet(context, mq);
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.asset('assets/home/forward_button_pink.png', scale: 4),
                              ),
                            ),

                            //child: Image.asset('assets/home/profile_circle.png', scale:3),),
                          )
                        : const Text(""),
                  ],
                ),
              ),
              const Divider(
                height: 10,
                thickness: 2,
                color: Colors.transparent,
              ),
              SizedBox(
                width: mq.width,
                height: 2,
                child: Container(decoration: kGradientBoxDecoration),
              ),
              const Divider(
                height: 10,
                thickness: 2,
                color: Colors.transparent,
              ),
            ],
          ),
          // child: buildText()
        ),
      ],
    );
  }

  Widget buildButtonContainer(BuildContext context, Size mq, int maxAmount) {
    return Visibility(
      visible: _buttonContainerVisible,
      maintainState: true,
      maintainAnimation: true,
      maintainSize: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          requestDictionary == true && widget.accDetail['allowanceLeft'].toString() != "0"
              ? SizedBox(
                  width: mq.width,
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () {
                      modalRequestExtraFundBottomDialog(widget.accDetail['clientId'], widget.accDetail['id'], context, mq, maxAmount);
                    },
                    child: const Text(kExtraFund, style: TextStyle(fontSize: 18, fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
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
                      _navigateToScanReceiptScreen(context);
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
                      _navigateToSendVideoScreen(context, widget.accDetail['clientId']);
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
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Image.asset('assets/otp/ellipse_bottom.png', width: mq.width, height: mq.height * 0.8, fit: BoxFit.fitHeight),
              ),
              Container(child: buildNewsListContainer(mq)
                  // child: buildText()
                  ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildNewsListContainer(Size mq) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 60, left: 30),
          alignment: Alignment.centerLeft,
          child: const Text('Latest News',
              textAlign: TextAlign.left, style: TextStyle(fontSize: 18, color: Colors.white, fontFamily: 'Poppins', fontWeight: FontWeight.w800)),
        ),
        Container(
          height: mq.height * 0.7,
          padding: const EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 20),
          child: news == null || news.isEmpty
              ? const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)))
              : NewListScreen(items: newList!),
          // child: buildText()
        ),
      ],
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

  void _navigateToScanReceiptScreen(BuildContext context) {
    String? clientId = widget.clientId;
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => ScanReceiptScreen(clientId: clientId),
        transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  Widget buildBottomArrow() {
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
                _changed(!_buttonContainerVisible);
              },
            ),
          ),
        ),
      ],
    );
  }

  void selectStatementTypeBottomSheet(BuildContext context, Size mq) {
    showModalBottomSheet<dynamic>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
      ),
      builder: (context) {
        return SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildTopBarContainer(context),
              Container(
                alignment: Alignment.center,
                child: const Text(
                  kStatementExport,
                  style: TextStyle(fontSize: 18, color: kBaseColor, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                ),
              ),
              buildDialogRadioContainer(context, mq, kThisMonth),
              buildDialogRadioContainer(context, mq, kLastMonth),
              buildDialogRadioContainer(context, mq, kThisYear),
              buildDialogRadioContainer(context, mq, kLastYear),
              buildDialogRadioContainer(context, mq, kLast12Month),
            ],
          ),
        ));
      },
    );
  }

  void modalStatementBottomDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
      ),
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildTopBarContainer(context),
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    kDownloadStatement,
                    style: TextStyle(fontSize: 18, color: kBaseColor, fontFamily: 'Poppins', fontWeight: FontWeight.w800),
                  ),
                ),
                (file!.path.isEmpty)
                    ? const Center(child: CircularProgressIndicator())
                    : Container(
                        padding: const EdgeInsets.all(20.0),
                        child: SizedBox(
                          height: 400.0,
                          child: PDFView(
                            filePath: file!.path,
                            enableSwipe: true,
                            swipeHorizontal: true,
                            autoSpacing: true,
                            pageFling: true,
                          ),
                        )),
                Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10, left: 40, right: 40),
                    child: RaisedButton(
                      onPressed: () {
                        share();
                      },
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                      padding: const EdgeInsets.all(0.0),
                      child: Ink(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[kBaseLightColor, kBaseColor],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: Container(
                          constraints: const BoxConstraints(minWidth: 50.0, minHeight: 50.0),
                          // min sizes for Material buttons
                          alignment: Alignment.center,
                          child: const Text(
                            kShare,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18, color: Colors.white, fontFamily: 'Inter', fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    )),
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10, left: 40, right: 40),
                  child: RaisedButton(
                    onPressed: () async {
                      showCenterLoader(context, MediaQuery.of(context).size, kPleaseWait);

                      Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
                            Navigator.of(context).pop();
                            Fluttertoast.showToast(
                                msg: "Statement download in your download folder",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: kBaseLightColor,
                                textColor: Colors.white);

                            // PDFDocument doc = await PDFDocument.fromFile(statement);
                          }));
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                    padding: const EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[kBaseLightColor, kBaseColor],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: Container(
                        constraints: const BoxConstraints(minWidth: 50.0, minHeight: 50.0),
                        // min sizes for Material buttons
                        alignment: Alignment.center,
                        child: const Text(
                          kDownloadStatement,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18, color: Colors.white, fontFamily: 'Inter', fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void modalRequestExtraFundBottomDialog(String clientId, String accId, BuildContext context, Size mq, int maxAmount) {
    _fundText.text = SharedPrefs().getInitValue().toString();

    if (maxAmount > 10) {
      ExtraFundsDialog.show(context, mq, _fundText, _requestText, maxAmount, SharedPrefs().getInitValue()! + .0, clientId, accId);
    } else {
      const CustomAlertDialog().errorDialog("", "Your funds are low to request", context);
    }
  }

  Widget buildTopBarContainer(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 20, right: 20, left: 10),
          child: Align(
            alignment: Alignment.centerRight,
            child: Material(
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset('assets/single_account/filled_close_icon.png', scale: 3),
                ),
              ),
              //child: Image.asset('assets/home/profile_circle.png', scale:3),),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDialogRadioContainer(BuildContext context, Size mq, String title) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RadioListTile<String>(
            value: title,
            groupValue: _selectedType,
            onChanged: (value) {
              Navigator.of(context).pop();
              _selectedType = value!;
              showCenterLoader(context, MediaQuery.of(context).size, kPleaseWait);
              if (_selectedType == kThisMonth) {
                _selectedType = "thismonth";
              } else if (_selectedType == kLastMonth) {
                _selectedType = "lastmonth";
              } else if (_selectedType == kThisYear) {
                _selectedType = "thisyear";
              } else if (_selectedType == kLastYear) {
                _selectedType = "lastyear";
              } else if (_selectedType == kLast12Month) {
                _selectedType = "last12month";
              }
              _getData(_selectedType);
            },
            title: Text(
              title,
              style: const TextStyle(fontSize: 18.0, fontFamily: 'Poppins', fontWeight: FontWeight.w600, color: kBaseColor),
            ),
            activeColor: kBaseColor,
            controlAffinity: ListTileControlAffinity.trailing,
          ),
          const Divider(
            height: 10,
            color: kBaseColor,
          ),
        ],
      ),
      // child: buildText()
    );
  }

  Future<File> getPdf(Uint8List pdf) async {
    Directory output = await getTemporaryDirectory();
    File file = File(output.path + "/statement${DateTime.now().millisecondsSinceEpoch}.pdf");
    await file.writeAsBytes(pdf);
    return file;
  }

  void share() async {
    if (!await file!.exists()) {
      await file?.create(recursive: true);
      file?.writeAsStringSync(kShareStatement);
    }
    ShareExtend.share(file!.path, "file");
  }
}
