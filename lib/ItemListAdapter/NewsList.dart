import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../constant/constant.dart';
import '../screens/NewsDetailScreen.dart';

class NewListScreen extends StatefulWidget {
  const NewListScreen({Key? key, required this.items}) : super(key: key);
  final List<dynamic> items;

  @override
  _NewListScreen createState() => _NewListScreen();
}

class _NewListScreen extends State<NewListScreen> {
  List<bool> flag = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<dynamic> newitems = [];
    for (var i = 0; i < widget.items.length; i++) {
      newitems.addAll(widget.items);
    }
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: widget.items.length, // Number of widget to be created.

            itemBuilder: (BuildContext context, int index) {
              return buildNewsItem(widget.items[index]['title'].toString(), widget.items[index]['postImageContent'].toString(), index);
            }) // Builder function for every item with index.

        );
  }

  _onItemTap(BuildContext context, int itemIndex) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NewsDetailScreen(
          items: widget.items[itemIndex],
          newsList: widget.items,
        ),
      ),
    );
  }

  Widget buildNewsItem(String title, String description, int pos) {
    flag.add(true);
    int length = description.length;
    length = min(100, length);
    return Material(
        color: Colors.transparent,
        child: InkWell(
          // Enables taps for child and add ripple effect when child widget is long pressed
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Colors.white,
            child: ListTile(
              onTap: () {
                _onItemTap(context, pos);
                //Go to the next screen with Navigator.push
              },
              contentPadding: const EdgeInsets.only(top: 15, left: 15, right: 10, bottom: 15),
              // Useful s tandard widget for displaying something in ListView.
              title: Padding(
                padding: const EdgeInsets.only(right: 70),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: kBaseColor,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              subtitle: Column(
                children: <Widget>[
                  Markdown(
                    padding: const EdgeInsets.only(bottom: 5, top: 5),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    data: flag[pos]
                        ? (description.substring(0, length) + "...")
                        : (description.substring(0, length) + description.substring(length, description.length)),
                    styleSheet: MarkdownStyleSheet.fromTheme(ThemeData(
                        textTheme: const TextTheme(bodyText2: TextStyle(fontSize: 12.0, color: kBaseColor, fontFamily: 'Inter', fontWeight: FontWeight.w600)))),
                  ),
                  InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(flag[pos] ? "show more" : "show less",
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: kBaseColor,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w800,
                            )),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        flag[pos] = !flag[pos];
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
