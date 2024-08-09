import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:money_carer/constant/constant.dart';

showCenterLoader(BuildContext context, Size mq, String text) {
  showDialog(context: context, builder: (ctx) => buildContainer(mq, text));
}

Widget buildContainer(Size mq, String text) {
  return AlertDialog(
    content: Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      height: mq.height * 0.18,
      decoration: BoxDecoration(color: kBaseLightColor, borderRadius: BorderRadius.circular(5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          const SpinKitHourGlass(
            color: Colors.white,
          ),
          const Spacer(),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(
            height: 15,
          )
        ],
      ),
    ),
  );
}
