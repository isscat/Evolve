import 'dart:io';

import 'package:Evolve/screens/edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadScreen extends StatefulWidget {
  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  File imageFile;
  final imagePicker = ImagePicker();

  Future getImage() async {
    final image = await imagePicker.getImage(source: ImageSource.gallery);
    print(image.path);

    setState(() {
      imageFile = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildBackgroundImage(),
          buildIconButton(context),
        ],
      ),
    );
  }

  Widget buildBackgroundImage() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Image(
        image: AssetImage(
          "assets/background.jpg",
        ),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget buildIconButton(BuildContext context) {
    return Center(
      child: IconButton(
        splashColor: Colors.cyan,
        icon: Icon(Icons.add_a_photo),
        onPressed: () async {
          await getImage();
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => EditScreen(
                    image: imageFile,
                  )));
        },
        iconSize: 80,
        color: Colors.white,
        splashRadius: 10.0,
      ),
    );
  }
}
