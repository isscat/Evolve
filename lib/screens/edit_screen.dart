import 'package:Evolve/widgets/fonts.dart';
import 'package:Evolve/widgets/frames_list.dart';
import 'package:Evolve/widgets/save_share.dart';
import 'package:Evolve/widgets/text_ffield.dart';

import 'package:Evolve/widgets/text_fields_dialog.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:photo_view/photo_view.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:convert';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/rendering.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:random_string/random_string.dart';

class EditScreen extends StatefulWidget {
  final File image;
  EditScreen({@required this.image});
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  //for text drag
  double top = 150;
  double left = 100;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ScreenshotController screenshotController = ScreenshotController();
  GlobalKey imageKey = GlobalKey();
  String path;
  //text input data
  String _text = "Write Something Nice!";
  TextStyle font = fonts[0];
  double textSize = 30.0;

  bool isSave = false;
  //frame data
  String imageChose = "0";
  void changeFrame(String frameChose) {
    setState(() {
      imageChose = frameChose;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: buildBottomAppBar(context),
      body: Center(
        child: RepaintBoundary(
          key: imageKey,
          child: Stack(
            children: [
              Container(
                color: Colors.white,
              ),
              PhotoView(
                imageProvider: AssetImage("assets/$imageChose.png"),
                minScale: PhotoViewComputedScale.contained * 0.7,
                maxScale: PhotoViewComputedScale.covered * 1.8,
                enableRotation: true,
                backgroundDecoration: BoxDecoration(
                    image: DecorationImage(image: FileImage(widget.image))),
              ),
              buildGestureDetector()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBottomAppBar(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SaveShare(
            onSaveGallery: onSaveGallery,
            onShare: onSave,
          ),
          FramesList(
            changeFrame: changeFrame,
          ),
          IconButton(
            color: Colors.pink[200],
            icon: Icon(Icons.text_fields),
            iconSize: 40,
            onPressed: () {
              buildText(context, onFontChanged, textSize, onTextSizeChange);
            },
          ),
        ],
      ),
    );
  }

  void onTextSizeChange(double value) {
    setState(() {
      this.textSize = value;
    });
  }

  void onFontChanged(TextStyle fontt) {
    setState(() {
      this.font = fontt;
    });
  }

  void onTextChanged(String changedText) {
    setState(() {
      this._text = changedText;
    });
  }

  void onSaveGallery() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    RenderRepaintBoundary imageObject =
        imageKey.currentContext.findRenderObject();
    final image = await imageObject.toImage(pixelRatio: 2);
    ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
    final pngBytes = await byteData.buffer.asUint8List();
    final str = randomNumeric(10);
    var file = File("/storage/emulated/0/DCIM/Camera/$str.png");
    await file.writeAsBytes(pngBytes);

    _scaffoldKey.currentState
        .showSnackBar(SnackBar(content: Text("File Saved to Gallery")));
  }

  void onSave() async {
    final str1 = randomNumeric(6);
    final str = randomAlphaNumeric(7);
    RenderRepaintBoundary imageObject =
        imageKey.currentContext.findRenderObject();
    final image = await imageObject.toImage(pixelRatio: 2);
    ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
    final pngBytes = await byteData.buffer.asUint8List();
    final base64 = base64Encode(pngBytes);
    await Share.file('share $str1.png to', '$str.png', pngBytes, 'image/png',
        text: 'My optional text.');
  }

  buildGestureDetector() {
    return GestureDetector(
      onVerticalDragUpdate: (DragUpdateDetails dd) {
        setState(() {
          top = dd.localPosition.dy;
          left = dd.localPosition.dx;
        });
      },
      child: Center(
        child: Stack(
          children: [
            Positioned(
              top: top,
              left: left,
              child: Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                child: TextFfield(
                    fieldText: _text,
                    fontFamily: font,
                    ontextChanged: onTextChanged,
                    textSize: textSize),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
