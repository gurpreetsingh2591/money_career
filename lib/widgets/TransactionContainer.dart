import 'package:flutter/material.dart';

import '../constant/constant.dart';

class TransactionContainer extends StatelessWidget {
  final String date;
  final String amount;
  final String name;

  const TransactionContainer({Key? key, required this.date, required this.name, required this.amount}) : super(key: key);

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

    return Row(
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
                color: Colors.white,
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
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              )),
        ]),
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 5),
              child: Text(
                kPound + amounts,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Text(
              sign,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ],
    );
  }
}
