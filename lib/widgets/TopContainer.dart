import 'package:flutter/material.dart';

import '../constant/constant.dart';

class TopContainer extends StatelessWidget {
  final Size mq;
  final String screen;

  const TopContainer({Key? key, required this.mq, required this.screen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.only(right: 10, left: 10),
          height: mq.height * 0.1,
          child: Align(
            alignment: Alignment.centerLeft,
            child: _getChild(context),
          ),
        ),
      ],
    );
  }

  Widget _getChild(BuildContext context) {
    if (screen == "bio" || screen == "OTP") {
      return const SizedBox();
    }
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios, color: kBaseColor),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
