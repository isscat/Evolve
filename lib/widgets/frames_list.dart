import 'package:flutter/material.dart';

class FramesList extends StatelessWidget {
  Function changeFrame;
  FramesList({this.changeFrame});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
          color: Colors.pink[200],
          icon: Icon(
            Icons.filter_frames,
            size: 40,
          ),
          onPressed: () {
            showBottomSheet(
                context: context,
                builder: (_) {
                  return Container(
                    width: 250,
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: () => changeFrame("$index"),
                            child: Image.asset(
                              "assets/$index.png",
                              width: 100,
                              height: 100,
                            ),
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            // color: Colors.pink,
                            borderRadius: BorderRadiusDirectional.all(
                                Radius.circular(10.0)),
                          ),
                        );
                      },
                    ),
                  );
                });
          }),
    );
  }
}
