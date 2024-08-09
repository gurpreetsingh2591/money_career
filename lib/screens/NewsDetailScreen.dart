import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:money_carer/constant/constant.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../ItemListAdapter/NewsList.dart';
import '../constant/constant.dart';

class NewsDetailScreen extends StatelessWidget {
  NewsDetailScreen({Key? key, this.items, this.newsList}) : super(key: key);
  final dynamic items;
  final List<dynamic>? newsList;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    String? videoID = "";
    try {
      videoID = YoutubePlayer.convertUrlToId(items['youTubeUrl']);
      if (kDebugMode) {
        print(videoID);
      }
    } on Exception catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }

    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: YoutubePlayerController(
            initialVideoId: videoID!, //Add videoID.
            flags: const YoutubePlayerFlags(hideControls: false, controlsVisibleAtStart: true, autoPlay: false, mute: false, hideThumbnail: false),
          ),
          showVideoProgressIndicator: true,
          progressIndicatorColor: kBaseColor,
        ),
        builder: (context, player) {
          return _normalView(context);
        });
  }

  Widget _normalView(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [kBaseLightColor, kBaseColor],
                  stops: [0.5, 1.5],
                ),
              ),
            ),
          ),
        ),
        key: _scaffoldKey,
        body: items == null || items!.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Colors.white,
                  ),
                  constraints: BoxConstraints(
                    maxHeight: mq.height,
                  ),
                  child: ListView(
                    primary: false,
                    shrinkWrap: true,
                    children: [buildBackContainer(context, mq), buildNewsContainer(mq), buildNewsListingContainer(mq)],
                  ),
                ),
              ));
  }

  Widget buildBackContainer(BuildContext context, Size mq) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
              image: NetworkImage(items['heroImage']['url']),
            ),
          ),
          height: 400,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, bottom: 100),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      items['title'],
                      style: const TextStyle(fontSize: 22, color: Colors.white, fontFamily: 'Poppins', fontWeight: FontWeight.w700),
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

  Widget buildNewsContainer(Size mq) {
    return Column(
      children: [
        Container(
          transform: Matrix4.translationValues(0.0, -100.0, 0.0),
          decoration: boxWaveWhite(),
          padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
          child: buildNewsDetailContainer(),
        ),
      ],
    );
  }

  Widget buildNewsDetailContainer() {
    String? videoID = "";
    try {
      if (items['youTubeUrl'].toString().contains("youtu.be")) {
        videoID = YoutubePlayer.convertUrlToId(items['youTubeUrl']);
      } else {
        videoID = "";
      }
      if (kDebugMode) {
        print(videoID);
      }
    } on Exception catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }

    var url = "";
    bool _midImageVisible;
    if (items['midContentImage'] == null) {
      url = "";
      _midImageVisible = false;
    } else {
      _midImageVisible = true;
      url = items['midContentImage']['url'];
    }
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 15),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "First heading",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 18, color: kBaseColor, fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  child: Markdown(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    data: items['preImageContent'],
                    styleSheet: MarkdownStyleSheet.fromTheme(ThemeData(
                        textTheme: const TextTheme(bodyText2: TextStyle(fontSize: 12.0, color: kBaseColor, fontFamily: 'Inter', fontWeight: FontWeight.w600)))),
                  )),
              _midImageVisible
                  ? Container(
                      height: 300,
                      margin: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(url),
                            ),
                          ),
                        ),
                      ),
                    )
                  : const Text(""),
              Container(
                  padding: const EdgeInsets.only(top: 10),
                  alignment: Alignment.centerLeft,
                  child: Markdown(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    data: items['postImageContent'],
                    styleSheet: MarkdownStyleSheet.fromTheme(ThemeData(
                        textTheme: const TextTheme(bodyText2: TextStyle(fontSize: 12.0, color: kBaseColor, fontFamily: 'Inter', fontWeight: FontWeight.w600)))),
                  )),
              (videoID != null)
                  ? Container(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      alignment: Alignment.centerLeft,
                      child: _YTPlayer(videoID),
                    )
                  : const Text(""),
            ],
          ),
        ),
      ],
    );
  }

  Widget _YTPlayer(String videoID) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: YoutubePlayerController(
          initialVideoId: videoID, //Add videoID.
          flags: const YoutubePlayerFlags(hideControls: false, controlsVisibleAtStart: true, autoPlay: false, mute: false, hideThumbnail: false),
        ),
        showVideoProgressIndicator: true,
        progressIndicatorColor: kBaseColor,
      ),
      builder: (context, player) {
        return player;
      },
    );
  }

  Widget buildNewsListingContainer(Size mq) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Image.asset('assets/otp/ellipse_bottom.png', width: mq.width, height: mq.height * 0.8, fit: BoxFit.fitHeight),
              ),
              Container(child: buildNewsList(mq)
                  // child: buildText()
                  ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildNewsList(Size mq) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 60, left: 30),
          alignment: Alignment.centerLeft,
          child: const Text('Related News', textAlign: TextAlign.left, style: TextStyle(fontSize: 18, color: Colors.white)),
        ),
        Container(
          height: mq.height * 0.7,
          padding: const EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 20),
          child: NewListScreen(items: newsList!),
          // child: buildText()
        ),
      ],
    );
  }
}
