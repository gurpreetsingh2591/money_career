import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../constant/constant.dart';
import '../screens/NewsDetailScreen.dart';
import 'ItemDetailsPage.dart';

class NewsListPageState extends State<ItemDetailsPage> {
//Hard-coded list of [ItemModel] to be displayed on our page.
  NewsListPageState(this.items);

  final List<dynamic> items;

  @override
  Widget build(BuildContext context) {
    final List<dynamic> newitems = [];
    for (var i = 0; i < items.length; i++) {
      newitems.addAll(items);
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: items.length, // Number of widget to be created.

        itemBuilder: (context, itemIndex) => // Builder function for every item with index.
            ItemWidget(
          items[itemIndex],
          itemIndex,
          () {
            _onItemTap(context, itemIndex);
          },
        ),
      ),
    );
  }

  // Method which uses BuildContext to push (open) new MaterialPageRoute (representation of the screen in Flutter navigation model) with ItemDetailsPage (StateFullWidget with UI for page) in builder.
  _onItemTap(BuildContext context, int itemIndex) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NewsDetailScreen(
          items: items[itemIndex],
          newsList: items,
        ),
      ),
    );
  }
}

// StatelessWidget with UI for our ItemModel-s in ListView.
class ItemWidget extends StatelessWidget {
  const ItemWidget(this.model, this.index, this.onItemTap, {Key? key}) : super(key: key);

  final dynamic model;
  final int index;
  final Function onItemTap;

  @override
  Widget build(BuildContext context) {
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
              onItemTap();
              //Go to the next screen with Navigator.push
            },
            contentPadding: const EdgeInsets.all(15),
            // Useful s tandard widget for displaying something in ListView.
            title: Padding(
              padding: const EdgeInsets.only(bottom: 15.0, right: 70),
              child: Text(
                model['title'],
                style: const TextStyle(
                  fontSize: 14.0,
                  color: kBaseColor,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            subtitle: ReadMoreText(model['postImageContent'],
                trimLines: 5,
                colorClickableText: Colors.red,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'Show more',
                trimExpandedText: 'Show less',
                moreStyle: const TextStyle(fontSize: 14, color: kBaseColor, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                style: const TextStyle(
                  fontSize: 12.0,
                  color: kBaseColor,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                )),
          ),
        ),
      ),
    );
  }
}
// ExpandableText(
//                   model['postImageContent'],
//                    trimLines: 4,

//                 ),
