import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_carer/constant/constant.dart';
import 'package:money_carer/widgets/NoteField.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../constant/constant.dart';
import '../data/api/ApiService.dart';
import '../utils/toast.dart';
import '../widgets/TopContainer.dart';

class SendVideoScreen extends StatefulWidget {
  final String? clientId;

  const SendVideoScreen({Key? key, this.clientId}) : super(key: key);

  @override
  _SendVideoScreenState createState() => _SendVideoScreenState();
}

class _SendVideoScreenState extends State<SendVideoScreen> {
  List<Widget> videos = <Widget>[];
  dynamic photoResponse = "";
  File? videosFile;
  final _noteText = TextEditingController();
  List<PickedFile> videoUri = <PickedFile>[];

  @override
  void initState() {
    super.initState();
    videos.add(
      Material(
        child: InkWell(
          onTap: () {
            _showChoiceDialog(context);
            setState(() {});
          },
          child: ClipRRect(
            child: AspectRatio(
              aspectRatio: 15.0 / 13.0,
              child: Image.asset(
                'assets/scan/camera_icon.png',
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ),
      ),
    );

    videos = videos;
    setState(() {
      videos = videos;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: mq.height,
          ),
          child: Stack(
            children: [
              TopContainer(
                mq: mq,
                screen: "sendVideo",
              ),
              buildTextTopViewContainer(context, mq),
              buildGridViewContainer(context, mq),
              buildTextBottomViewContainer(context, mq),
              buildNoteContainer(context, mq),
              buildButtonContainer(mq, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextTopViewContainer(BuildContext context, Size mq) {
    return Column(
      children: [
        SizedBox(
          height: mq.height * 0.4,
          child: Center(
            child: Container(
              padding: const EdgeInsets.only(top: 60, right: 100, left: 100),
              child: Column(
                children: const [
                  Text("Please take a video of your issue to send to us.",
                      textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: kBaseColor, fontFamily: 'Poppins', fontWeight: FontWeight.w600))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTextBottomViewContainer(BuildContext context, Size mq) {
    return Positioned(
      left: mq.width * 0.00,
      right: mq.width * 0.00,
      top: mq.height * 0.55,
      child: Column(
        children: [
          SizedBox(
            height: mq.height * 0.4,
            child: Center(
              child: Container(
                padding: const EdgeInsets.only(right: 80, left: 80),
                child: Column(
                  children: const [
                    Text("Please fill out the detail of your video below.",
                        textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: kBaseColor, fontFamily: 'Poppins', fontWeight: FontWeight.w600))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGridViewContainer(BuildContext context, Size mq) {
    return Column(
      children: [
        SizedBox(
          height: mq.height * 0.8,
          child: Center(
            child: Container(
              padding: const EdgeInsets.only(top: 120, right: 30, left: 30, bottom: 120),
              child: Column(
                children: [ImagesGrid()],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildNoteContainer(BuildContext context, Size mq) {
    return Positioned(
      left: mq.width * 0.00,
      right: mq.width * 0.00,
      top: mq.height * 0.6,
      child: Column(
        children: [
          SizedBox(
            height: mq.height * 0.2,
            child: Container(
                margin: const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    child: NoteField(
                      controller: _noteText,
                      hintText: kNote,
                    ),
                    decoration: kInnerDecoration,
                  ),
                ),
                decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/scan/note_bg.png"), fit: BoxFit.fill, scale: 1))),
          ),
        ],
      ),
    );
  }

  Widget ImagesGrid() {
    return Expanded(
      child: videos.isEmpty
          ? Material(
              child: InkWell(
                onTap: () {
                  // _openCamera(context);
                  _showChoiceDialog(context);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset('assets/scan/camera_icon.png', scale: 3),
                ),
              ),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: videos.length,
              itemBuilder: (BuildContext context, int index) {
                return buildGridImages(index);
              }),
    );
  }

  Widget buildGridImages(int index) {
    return SizedBox(
      height: 80,
      child: ClipRRect(
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: videos[index],
              ),
            ),
            (index == 0)
                ? const Text("")
                : Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/scan/play_icon.png',
                      scale: 12,
                    ),
                  ),
            (index == 0)
                ? const Text("")
                : Positioned(
                    right: 0,
                    top: 0,
                    child: Material(
                      child: InkWell(
                        onTap: () {
                          videos.removeAt(index);
                          setState(() {});
                        },
                        child: ClipRRect(
                          child: Image.asset(
                            'assets/scan/close_btn.png',
                            scale: 5,
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget buildText(BuildContext context, Size mq) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(top: 50.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
        SizedBox(
          width: 200,
          height: 50.0,
          child: ElevatedButton(
            onPressed: () {
              if (videoUri.isEmpty) {
                toast('Please Add video', false);
              } else if (_noteText.text.toString().isEmpty) {
                toast('Please enter note', false);
              } else {
                dialog(mq);
              }
            },
            child: const Text(kSendReceipt, style: TextStyle(fontSize: 14, fontFamily: 'Inter', fontWeight: FontWeight.w600)),
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: kBaseColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // <-- Radius
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future dialog(Size mq) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text(kVideoSendInfo),
        actions: [
          FlatButton(
            child: const Text(
              kCancel,
              style: TextStyle(fontSize: 18, fontFamily: 'Inter', fontWeight: FontWeight.w700, color: kBaseColor),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: const Text(
              kSend,
              style: TextStyle(fontSize: 18, fontFamily: 'Inter', fontWeight: FontWeight.w700, color: kBaseColor),
            ),
            onPressed: () {
              photoResponse = ApiService().getPostVideos(widget.clientId!, _noteText.text.toString(), videoUri, context);
            },
          ),
        ],
      ),
    );
  }

  Widget buildButtonContainer(Size mq, BuildContext context) {
    return Positioned(
      left: mq.width * 0.00,
      right: mq.width * 0.00,
      top: mq.height * 0.8,
      child: Column(
        children: [
          Container(height: mq.height * 0.8, decoration: boxOTPBg(), padding: const EdgeInsets.only(right: 50, left: 50), child: buildText(context, mq)),
        ],
      ),
    );
  }

  Future<void> _openGallery(BuildContext context) async {
    // final picker = ImagePicker();
    PickedFile? pickedFile = await ImagePicker().getVideo(
      source: ImageSource.gallery,
    );

    final uint8list = await VideoThumbnail.thumbnailFile(
      video: pickedFile!.path,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 512,
      // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
      quality: 100,
    );
    setState(() {
      double fileSize = getFileSize(pickedFile.path);
      if (fileSize > 50) {
        toast(kVideoSizeInfo, false);
      } else {
        videoUri.add(pickedFile);

        videosFile = File(uint8list!);
        videoUri.add(pickedFile);
        videos.add(
          AspectRatio(
            aspectRatio: 15.0 / 13.0,
            child: Image.file(
              videosFile!,
              fit: BoxFit.cover,
            ),
          ),
        );
      }
    });

    Navigator.pop(context);
  }

  double getFileSize(String filepath) {
    var file = File(filepath);
    int sizeInBytes = file.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    return sizeInMb;
  }

  Future<void> _openCamera(BuildContext context) async {
    PickedFile? pickedFile = await ImagePicker().getVideo(
      source: ImageSource.camera,
    );
    final uint8list = await VideoThumbnail.thumbnailFile(
      video: pickedFile!.path,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 512,
      // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
      quality: 100,
    );
    // imageFile = pickedFile!;
    setState(() {
      double fileSize = getFileSize(pickedFile.path);
      if (fileSize > 50) {
        toast('your video size should be less than 50MB', false);
      } else {
        videosFile = File(uint8list!);
        videoUri.add(pickedFile);

        videos.add(
          AspectRatio(
            aspectRatio: 15.0 / 13.0,
            child: Image.file(
              videosFile!,
              fit: BoxFit.cover,
            ),
          ),
        );
      }
    });

    Navigator.pop(context);
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Choose option",
              style: TextStyle(fontSize: 16, fontFamily: 'Inter', fontWeight: FontWeight.w500, color: kBaseColor),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  const Divider(
                    height: 1,
                    color: kBaseColor,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pop();
                      _openGallery(context);
                    },
                    title: const Text("Gallery", style: TextStyle(fontSize: 16, fontFamily: 'Inter', fontWeight: FontWeight.w500, color: kBaseColor)),
                    leading: const Icon(
                      Icons.account_box,
                      color: kBaseColor,
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: kBaseColor,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pop();
                      _openCamera(context);
                    },
                    title: const Text("Camera", style: TextStyle(fontSize: 16, fontFamily: 'Inter', fontWeight: FontWeight.w500, color: kBaseColor)),
                    leading: const Icon(
                      Icons.camera,
                      color: kBaseColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
