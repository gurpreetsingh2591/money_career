import 'package:flutter/material.dart';

import '../constant/constant.dart';

class SingleTransactionContainer extends StatelessWidget {
  final String date;
  final String amount;
  final String name;

  const SingleTransactionContainer({Key? key, required this.date, required this.name, required this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String sign = "";
    String amounts = "";
    if (amount.contains(kMinus)) {
      sign = kMinus;
      amounts = amount.split(kMinus).last.toString() + "";
    } else {
      sign = kPlus;
      amounts = amount + "";
    }

    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            Container(
              width: 70,
              alignment: Alignment.topLeft,
              child: Text(
                date,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 11,
                  color: kBaseColor,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Container(
                width: 150,
                alignment: Alignment.topLeft,
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 11,
                    color: kBaseColor,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                )),
          ]),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Text(
                  "£" + amounts,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 10,
                    color: kBaseColor,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  sign,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 20,
                    color: kBaseColor,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
