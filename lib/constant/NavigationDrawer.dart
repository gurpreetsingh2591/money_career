import 'package:flutter/material.dart';
import 'package:money_carer/screens/ChangePasswordScreen.dart';
import 'package:money_carer/screens/DeleteAccountScreen.dart';
import 'package:money_carer/screens/FaqScreen.dart';
import 'package:money_carer/screens/HomeScreen.dart';
import 'package:money_carer/screens/LogoutScreen.dart';
import 'package:money_carer/screens/NewsAndUpdate.dart';
import 'package:money_carer/utils/shared_preferences/shared_prefs.dart';

import 'constant.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  _NavigationDrawer createState() => _NavigationDrawer();
}

class _NavigationDrawer extends State<NavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Drawer(
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          buildTopContainer(context, mq),
          buildDetailContainer(context, mq),
          buildListContainer(mq, context),
        ],
      ),
    );
  }

  Widget buildTopContainer(BuildContext context, Size mq) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.only(right: 20),
          height: mq.height * 0.1,
          child: Align(
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset('assets/home/close_icon_black.png', scale: 3),
              ),
            ),
            alignment: Alignment.centerRight,
            //child: Image.asset('assets/home/close_icon_black.png', scale: 3),
          ),
        ),
      ],
    );
  }

  Widget buildDetailContainer(BuildContext context, Size mq) {
    String name = "";
    if (SharedPrefs().isUserRegister() == true) {
      name = SharedPrefs().getUserFullName().toString();
    } else {
      name = "user name";
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: mq.height * 0.2,
          child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      child: Image.asset('assets/home/profile_circle.png', scale: 2),
                    ),
                    Text(
                      name,
                      maxLines: 1,
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 14, color: kBaseColor, fontFamily: 'Poppins', fontWeight: FontWeight.w800),
                    ),
                    const Text(
                      kMoneyAccount,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 14, color: kBaseColor, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              )),
        ),
      ],
    );
  }

  Widget buildListContainer(Size mq, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
            height: mq.height,
            decoration: boxDrawer(),
            padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
            child: buildDrawerListContainer(mq, context)),
      ],
    );
  }

  Widget buildDrawerListContainer(Size mq, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: mq.width * 0.00, right: mq.width * 0.05, top: mq.height * 0.05, bottom: mq.height * 0.01),
      child: Form(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                  child: const Text(
                    kHome,
                    style: TextStyle(color: Colors.white, fontSize: 16.0, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                  ),
                  onPressed: () => {
                        Navigator.pop(context),
                        _navigateToHomeScreen(context),
                      }),
            ),
            const Divider(
              height: 20,
              color: Colors.white,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                  child: const Text(
                    kNewsUpdate,
                    style: TextStyle(color: Colors.white, fontSize: 16.0, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                  ),
                  onPressed: () => {
                        Navigator.pop(context),
                        _navigateToNewsUpdateScreen(context),
                      }),
            ),
            const Divider(
              height: 20,
              color: Colors.white,
            ),
            Align(
              heightFactor: 1,
              alignment: Alignment.centerLeft,
              child: TextButton(
                child: const Text(
                  kFAQ,
                  style: TextStyle(color: Colors.white, fontSize: 16.0, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                ),
                onPressed: () => {
                  Navigator.pop(context),
                  _navigateToFaqScreen(context),
                },
              ),
            ),
            const Divider(
              height: 20,
              color: Colors.white,
            ),
            Align(
              heightFactor: 1,
              alignment: Alignment.centerLeft,
              child: TextButton(
                child: const Text(
                  kChangePassword,
                  style: TextStyle(color: Colors.white, fontSize: 16.0, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                ),
                onPressed: () => {
                  Navigator.pop(context),
                  _navigateToChangePasswordScreen(context),
                },
              ),
            ),
            const Divider(
              height: 20,
              color: Colors.white,
            ),
            Align(
              heightFactor: 1,
              alignment: Alignment.centerLeft,
              child: TextButton(
                child: const Text(
                  kDeleteAccountTitle,
                  style: TextStyle(color: Colors.white, fontSize: 16.0, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                ),
                onPressed: () => {
                  Navigator.pop(context),
                  _navigateToDeleteScreen(context),
                },
              ),
            ),
            const Divider(
              height: 20,
              color: Colors.white,
            ),
            Align(
              heightFactor: 1,
              alignment: Alignment.centerLeft,
              child: TextButton(
                child: const Text(
                  kLogout,
                  style: TextStyle(color: Colors.white, fontSize: 16.0, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                ),
                onPressed: () => {
                  Navigator.pop(context),
                  _navigateToLogoutScreen(context),
                },
              ),
            ),
            const Divider(
              height: 20,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToChangePasswordScreen(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => const ChangePasswordScreen(),
        transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  void _navigateToFaqScreen(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => const FaqScreen(),
        transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  void _navigateToDeleteScreen(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => const DeleteAccountScreen(),
        transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  void _navigateToLogoutScreen(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => const LogoutScreen(),
        transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  void _navigateToNewsUpdateScreen(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => const NewsAndUpdateScreen(),
        transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  void _navigateToHomeScreen(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const HomeScreen()), (Route<dynamic> route) => false);
  }
}
