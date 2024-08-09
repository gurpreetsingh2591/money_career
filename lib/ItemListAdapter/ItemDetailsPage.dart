import 'package:flutter/material.dart';

import '../model/newslist/NewsListModel.dart';

/// Widget for displaying detailed info of [ItemModel]
class ItemDetailsPage extends StatefulWidget {
  final FeedItems model;

  const ItemDetailsPage(this.model, {Key? key}) : super(key: key);

  @override
  _ItemDetailsPageState createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 16),
            const SizedBox(height: 16),
            Text(
              'Item description: ${widget.model.postImageContent}',
              style: const TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
