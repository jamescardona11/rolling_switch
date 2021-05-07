import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  final IconData iconData;
  final double size;
  final Animation<double> animationOpacity;
  final Color color;

  const IconWidget({
    Key? key,
    required this.animationOpacity,
    required this.iconData,
    required this.size,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: animationOpacity,
        child: Icon(
          iconData,
          size: size,
          color: color,
        ),
      ),
    );
  }
}
