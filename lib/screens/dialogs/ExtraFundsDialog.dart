import 'package:flutter/material.dart';
import 'package:money_carer/constant/constant.dart';
import 'package:money_carer/utils/shared_preferences/shared_prefs.dart';

import '../../data/api/ApiService.dart';
import '../../widgets/GradientRectSliderTrackShape.dart';
import '../../widgets/VerticalDivider.dart';
import '../HomeScreen.dart';
import '../SingleAccountScreen.dart';

Future<dynamic>? requestFundResponse;
bool isLoading = true;
bool isFund = true;

class ExtraFundsDialog extends State<SingleAccountScreen> {
  static Widget _buildTopCloseBarContainer(BuildContext context, Size mq) {
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

  static Widget _getValueSlider(TextEditingController controller, int maxAmount) {
    return StatefulBuilder(
      builder: (context, setState) {
        return SliderTheme(
          data: SliderThemeData(
            inactiveTickMarkColor: Colors.transparent,
            inactiveTrackColor: kLightGray,
            trackShape: GradientRectSliderTrackShape(gradient: gradient, darkenInactive: true),
            trackHeight: 15.0,
            thumbColor: kBaseColor,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 15),
          ),
          child: Slider(
            min: 0.0,
            max: maxAmount + 0.0,
            divisions: maxAmount ~/ 10.round(),
            value: SharedPrefs().getInitValue()! + .0,
            onChanged: (selection) {
              setState(() {
                int i = selection.toInt();
                controller.text = i.toString();
                SharedPrefs().setInitValue(i);
              });
            },
          ),
        );
      },
    );
  }

  static Widget _buildNoteField(BuildContext context, TextEditingController requestController) {
    return Container(
      color: Colors.white,
      child: TextFormField(
        maxLines: 7,
        //obscureText: true,
        style: const TextStyle(
          fontSize: 14,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
          color: kBaseColor,
        ),
        keyboardType: TextInputType.text,
        controller: requestController,
        textAlign: TextAlign.left,
        autofocus: false,
        onEditingComplete: () => FocusScope.of(context).nextFocus(),
        textInputAction: TextInputAction.done,
        decoration: const InputDecoration(
          border: InputBorder.none,
          counterText: '',
          hintStyle: TextStyle(fontSize: 14.0, color: kBaseColor),
          hintText: 'Request written here',
          contentPadding: EdgeInsets.all(10.0),
        ),
      ),
    );
  }

  static Widget _buildFundField(BuildContext context, TextEditingController controller) {
    return SizedBox(
      width: 80,
      child: TextFormField(
        maxLines: 1,
        enabled: false,
        //obscureText: true,
        style: const TextStyle(
          fontSize: 60,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
          color: kBaseColor,
        ),
        keyboardType: TextInputType.number,
        controller: controller,
        textAlign: TextAlign.left,
        onEditingComplete: () => FocusScope.of(context).nextFocus(),
        textInputAction: TextInputAction.done,
        decoration: const InputDecoration(
          border: InputBorder.none,
          counterText: '',
          hintStyle: TextStyle(fontSize: 20.0, color: kBaseColor),
          hintText: '',
        ),
      ),
    );
  }

  static Future dialog(String clientId, String accId, BuildContext contexts, TextEditingController controller) {
    return showDialog(
      context: contexts,
      builder: (context) => AlertDialog(
        content: const Text("Are you sure you want to send the request for these extra funds?"),
        actions: [
          FlatButton(
            child: const Text(
              "Cancel",
              style: TextStyle(fontSize: 18, fontFamily: 'Inter', fontWeight: FontWeight.w700, color: kBaseColor),
            ),
            onPressed: () {
              Navigator.pop(contexts);
            },
          ),
          FlatButton(
            child: const Text(
              "Send",
              style: TextStyle(fontSize: 18, fontFamily: 'Inter', fontWeight: FontWeight.w700, color: kBaseColor),
            ),
            onPressed: () {
              Navigator.pop(contexts);
              requestSendWidget(clientId, accId, controller, contexts);
            },
          )
        ],
      ),
    );
  }

  static Widget _buildSendRequestButton(String clientId, String accId, BuildContext context, TextEditingController controller) {
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
              dialog(clientId, accId, context, controller);
            },
            child: const Text('Send Request', style: TextStyle(fontSize: 16, fontFamily: 'Inter', fontWeight: FontWeight.w700)),
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

  static Widget _buildSendRequestButtonContainer(String clientId, String accId, BuildContext context, TextEditingController controller, Size mq) {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.only(top: 20),
            height: mq.height * 0.265,
            decoration: boxSendRequestBg(),
            padding: const EdgeInsets.only(right: 100, left: 100),
            child: _buildSendRequestButton(clientId, accId, context, controller)),
      ],
    );
  }

  static Widget _buildLabelContainer(int maxValue, Size mq) {
    var value = (maxValue / 10.round().toInt());
    List<Widget> textWidgetList = <Widget>[];
    for (int i = 0; i < value + 1; i++) {
      textWidgetList.add(Text("£" + (i * 10).toString(),
          textAlign: TextAlign.left, style: const TextStyle(fontSize: 8, color: kBaseColor, fontFamily: 'Poppins', fontWeight: FontWeight.w600)));
    }
    return IntrinsicHeight(child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: textWidgetList));
  }

  static Widget _buildLabelLineContainer(int maxValue, Size mq) {
    var value = (maxValue / 10.round().toInt());
    List<Widget> lineWidgetList = <Widget>[];
    for (int i = 0; i < value + 1; i++) {
      lineWidgetList.add(const VerticaDivider());
    }
    return IntrinsicHeight(child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: lineWidgetList));
  }

  static void show(BuildContext context, Size mq, TextEditingController controller, TextEditingController requestController, int maxAmount, double initValue,
      String clientId, String accId) {
    showModalBottomSheet<dynamic>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
      ),
      builder: (context) {
        return SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTopCloseBarContainer(context, mq),
            Container(
              alignment: Alignment.center,
              child: const Text(
                "Request Extra Funds",
                style: TextStyle(fontSize: 18, color: kBaseColor, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "£",
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 60, color: kBaseColor, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                            ),
                            _buildFundField(context, controller),
                            Container(
                              width: 100,
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                "Extra Funds",
                                style: TextStyle(fontSize: 20, color: kBaseColor, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: _buildLabelContainer(maxAmount, mq),
                  ),
                  Container(margin: const EdgeInsets.only(left: 25, right: 25), child: _buildLabelLineContainer(maxAmount, mq)),
                  _getValueSlider(controller, maxAmount),
                ],
              ),
            )
/*            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _getValueSlider(controller, maxAmount),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              "£",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 40,
                                  color: kBaseColor,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600),
                            ),
                            _buildFundField(context, controller),
                          ],
                        ),
                        Container(
                          width: 100,
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Extra Funds",
                            style: TextStyle(
                                fontSize: 16,
                                color: kBaseColor,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )*/
            ,
            Container(
              margin: const EdgeInsets.only(top: 30, left: 40, right: 40),
              alignment: Alignment.bottomCenter,
              child: const Text(
                "Please fill out the details of your request below",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: kBaseColor, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              child: Stack(
                children: [
                  Align(
                    child: Container(
                        margin: const EdgeInsets.only(left: 30, right: 30, top: 20),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            child: _buildNoteField(context, requestController),
                            decoration: kInnerDecoration,
                          ),
                        ),
                        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/scan/note_bg.png"), fit: BoxFit.fill, scale: 1))),
                    alignment: AlignmentDirectional.center,
                  ),
                ],
              ),
            ),
            _buildSendRequestButtonContainer(clientId, accId, context, requestController, mq)
          ],
        ));
      },
    );
  }

  static void requestSendWidget(String clientId, String accId, TextEditingController controller, BuildContext context) {
    ApiService().getRequestFunds(clientId, accId, SharedPrefs().getInitValue().toString(), controller.text.toString(), context);
    controller.text = "";
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

/*
  static FutureBuilder<dynamic> buildRequestFundBuilder() {
    return FutureBuilder<dynamic>(
      future: requestFundResponse,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          requestFundResponse=snapshot.data;
          isLoading = false;
        } else if (snapshot.hasError) {
          return const Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(kBaseColor)));
        } else {
          return const Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(kBaseColor)));
        }

        return isLoading
            ? const Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(kBaseColor)))
            :  showFundAlertDialog("",context);
      },
    );
  }
*/

  static showFundAlertDialog(String msg, BuildContext context) {
    // set up the buttons

    Widget continueButton = FlatButton(
      child: const Text(
        "Ok",
        style: TextStyle(fontSize: 18, fontFamily: 'Poppins', fontWeight: FontWeight.w800, color: kBaseColor),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const HomeScreen()), (Route<dynamic> route) => false);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text(
        msg,
        style: const TextStyle(fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w600, color: kBaseColor),
      ),
      actions: [
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
