import 'package:flutter/material.dart';

class AccountHolderNameContainer extends StatelessWidget {
  final dynamic accDetail;

  const AccountHolderNameContainer({Key? key, required this.accDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Column(
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
                  (accDetail['allowanceLeft'].toString() == "0")
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
                      : const Text("")
                ]),
                const Divider(
                  height: 20,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
