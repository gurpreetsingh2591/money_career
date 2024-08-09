import 'package:flutter/material.dart';

class BalanceContainer extends StatelessWidget {
  final dynamic accDetail;

  const BalanceContainer({Key? key, required this.accDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          child: Container(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (accDetail['allowanceLeft'].toString() != "0")
                    ? Row(
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "£" + accDetail['allowanceLeft'].toString(),
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const Text(
                                    "Agreed \nExtra Funds  ",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      )
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                accDetail['clientName'].toString(),
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
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
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                (accDetail['access']['showBalance'] == true)
                    ? SizedBox(
                        child: Column(
                          children: [
                            Text(
                              "£" + accDetail['balance'].toString(),
                              style: const TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      )
                    : const Text(""),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
