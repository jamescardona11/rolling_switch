import 'package:flutter/material.dart';
import 'package:rolling_switch/src/widget/text_indicator.dart';

/// {@template transform_text}
///
/// This class transform the rollingInfo in a right_text
///
/// {@endtemplate}
class TransformRightTextWidget extends StatelessWidget {
  const TransformRightTextWidget({
    Key? key,
    required this.margin,
    required this.animationValue,
    required this.animationOpacity,
    this.text,
  }) : super(key: key);

  final double margin;
  final double animationValue;
  final Animation<double> animationOpacity;
  final Text? text;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(margin * animationValue, 0), //original
      child: FadeTransition(
        opacity: animationOpacity,
        child: TextIndicatorWidget.right(
          margin: margin,
          text: text ?? const Text(''),
        ),
      ),
    );
  }
}

/// {@template transform_text}
///
/// This class transform the rollingInfo in a left_text
///
/// {@endtemplate}
class TransformLeftTextWidget extends StatelessWidget {
  const TransformLeftTextWidget({
    Key? key,
    required this.margin,
    required this.innerSize,
    required this.animationValue,
    required this.animationOpacity,
    this.text,
  }) : super(key: key);

  final double margin;
  final double innerSize;
  final double animationValue;
  final Animation<double> animationOpacity;
  final Text? text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: innerSize),
      child: Transform.translate(
        offset: Offset(margin * (1 - animationValue), 0), //original
        child: FadeTransition(
          opacity: animationOpacity,
          child: TextIndicatorWidget.left(
            margin: margin,
            text: text ?? const Text(''),
          ),
        ),
      ),
    );
  }
}
