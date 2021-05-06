import 'package:flutter/material.dart';

class TextIndicatorWidget extends StatelessWidget {
  TextIndicatorWidget.left({
    Key? key,
    double margin = 0,
    required this.text,
  })   : align = Alignment.centerLeft,
        margin = EdgeInsets.only(left: margin),
        super(key: key);

  TextIndicatorWidget.right({
    Key? key,
    double margin = 0,
    required this.text,
  })   : align = Alignment.centerRight,
        margin = EdgeInsets.only(right: margin),
        super(key: key);

  final EdgeInsets margin;
  final AlignmentGeometry align;
  final Text text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: margin,
      alignment: Alignment.centerLeft,
      child: text,
    );
  }
}
