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
      autofocus: false,
      focusNode: FocusNode(),
      enableInteractiveSelection: false,
      initialValue: fieldText,
      decoration: InputDecoration(
          border: InputBorder.none, counterText: fieldText.length.toString()),
      maxLines: 5,
      maxLength: 20,
      style: TextStyle(
          height: fontFamily.height,
          fontFamily: fontFamily.fontFamily,
          fontSize: textSize),
      onChanged: ontextChanged,
    );
  }
}
