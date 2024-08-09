import 'package:flutter/material.dart';

import '../constant/constant.dart';

class UserNameContainer extends StatelessWidget {
  final dynamic accDetail;
  const UserNameContainer({Key? key, required this.accDetail}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    accDetail['clientName'].toString(),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 14,
                      color: kBaseColor,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    accDetail['name'].toString(),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 14,
                      color: kBaseColor,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
