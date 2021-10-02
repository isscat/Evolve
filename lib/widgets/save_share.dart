import 'package:flutter/material.dart';

class SaveShare extends StatelessWidget {
  Function onSaveGallery, onShare;
  SaveShare({this.onSaveGallery, this.onShare});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
          color: Colors.pink[200],
          icon: Icon(
            Icons.done,
            size: 40,
          ),
          onPressed: () {
            showBottomSheet(
                context: context,
                builder: (_) {
                  return Container(
                    width: 250,
                    height: 100,
                    child: Center(
                        child: Row(
                      children: [
                        IconButton(
                          tooltip: "gallery",
                          icon: Icon(
                            Icons.save,
                            size: 40,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            onSaveGallery();
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.share,
                            size: 40,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            onShare();
                          },
                        )
                      ],
                    )),
                  );
                });
          }),
    );
  }
}
