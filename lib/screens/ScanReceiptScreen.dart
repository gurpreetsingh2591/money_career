import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_carer/constant/constant.dart';
import 'package:money_carer/data/api/ApiService.dart';
import 'package:money_carer/widgets/NoteField.dart';
import 'package:money_carer/widgets/TopContainer.dart';

import '../constant/constant.dart';
import '../utils/toast.dart';

class ScanReceiptScreen extends StatefulWidget {
  final String? clientId;
  const ScanReceiptScreen({Key? key, this.clientId}) : super(key: key);

  @override
  _ScanReceiptScreenState createState() => _ScanReceiptScreenState();
}

class _ScanReceiptScreenState extends State<ScanReceiptScreen> {
  final _requestText = TextEditingController();
  dynamic photoResponse = "";
  List<Widget> cardsList = [];
  List<Widget> images = <Widget>[];
  List<File> imagesUri = <File>[];
  File? imageFile;

  @override
  void initState() {
    super.initState();
    images.add(
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

    images = images;
    setState(() {
      images = images;
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
              TopContainer(mq: mq, screen: "scanReceipt"),
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

  Widget buildGridViewContainer(BuildContext context, Size mq) {
    return Column(
      children: [
        SizedBox(
          height: mq.height * 0.6,
          child: Center(
            child: Container(
              padding: const EdgeInsets.only(top: 120, right: 30, left: 30, bottom: 50),
              child: Column(
                children: [imagesGrid()],
              ),
            ),
          ),
        ),
      ],
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
                  Text("Please take a photo of your receipt to send to us",
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
                    Text("Please fill out the details of your receipt or invoice below.",
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

  Widget buildNoteContainer(BuildContext context, Size mq) {
    return Positioned(
      left: mq.width * 0.00,
      right: mq.width * 0.00,
      top: mq.height * 0.6,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: mq.height * 0.2,
            child: Container(
                margin: const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    child: NoteField(controller: _requestText, hintText: kNote),
                    decoration: kInnerDecoration,
                  ),
                ),
                decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/scan/note_bg.png"), fit: BoxFit.fill, scale: 1))),
          ),
        ],
      ),
    );
  }

  Widget imagesGrid() {
    return Expanded(
      child: images.isEmpty
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
              itemCount: images.length,
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
                child: images[index],
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
                          images.removeAt(index);
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

  Widget buildText(Size mq, BuildContext context) {
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
              dialog(mq);
            },
            child: const Text('Send Receipt or Invoice', style: TextStyle(fontSize: 14, fontFamily: 'Inter', fontWeight: FontWeight.w600)),
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: kBaseColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15), // <-- Radius
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildButtonContainer(Size mq, BuildContext context) {
    return Positioned(
      left: mq.width * 0.00,
      right: mq.width * 0.00,
      top: mq.height * 0.8,
      child: Column(
        children: [
          Container(height: mq.height * 0.8, decoration: boxOTPBg(), padding: const EdgeInsets.only(right: 50, left: 50), child: buildText(mq, context)),
        ],
      ),
    );
  }

  Future<void> _openGallery(BuildContext context) async {
    // final picker = ImagePicker();
    PickedFile? pickedFile = await ImagePicker().getImage(source: ImageSource.gallery, maxWidth: 1024, maxHeight: 800, imageQuality: 90);
    setState(() {
      double fileSize = getFileSize(pickedFile!.path);
      if (fileSize > 5) {
        toast("your image size should be less than 5MB", false);
      } else {
        imageFile = File(pickedFile.path);
        imagesUri.add(imageFile!);

        images.add(
          AspectRatio(
            aspectRatio: 15.0 / 13.0,
            child: Image.file(
              imageFile!,
              fit: BoxFit.cover,
            ),
          ),
        );
      }
    });
    Navigator.pop(context);
  }

  Future<void> _openCamera(BuildContext context) async {
    //final picker = ImagePicker();
    PickedFile? pickedFile = await ImagePicker().getImage(source: ImageSource.camera, maxWidth: 1024, maxHeight: 800, imageQuality: 90);
    setState(() {
      double fileSize = getFileSize(pickedFile!.path);
      if (fileSize > 5) {
        toast('your image size should be less than 5MB', false);
      } else {
        imageFile = File(pickedFile.path);
        imagesUri.add(imageFile!);
        images.add(
          AspectRatio(
            aspectRatio: 15.0 / 13.0,
            child: Image.file(
              imageFile!,
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

  double getFileSize(String filepath) {
    var file = File(filepath);
    int sizeInBytes = file.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    return sizeInMb;
  }

  Future dialog(Size mq) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text("Do you want to send these receipts to the Money Carer admin?"),
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
              //  Navigator.of(context).pop();

              photoResponse = ApiService().getPostImages(widget.clientId!, _requestText.text.toString(), imagesUri, context);
            },
          ),
        ],
      ),
    );
  }
}
