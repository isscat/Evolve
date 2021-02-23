import 'package:flutter/material.dart';

class TextFfield extends StatelessWidget {
  final Color picked;
  final double textSize;
  final Function ontextChanged;
  final String fieldText;
  final TextStyle fontFamily;
  final bool isTextField;
  TextFfield(
      {this.fontFamily,
      this.fieldText,
      this.ontextChanged,
      this.textSize,
      this.picked,
      this.isTextField});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: fieldText,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(8.0),
          ),
          counterText: fieldText.length.toString()),
      maxLines: 100,
      maxLength: 150,
      style: TextStyle(
          height: fontFamily.height,
          fontFamily: fontFamily.fontFamily,
          fontSize: textSize),
      onChanged: ontextChanged,
    );
  }
}
