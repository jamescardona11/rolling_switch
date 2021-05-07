import 'package:flutter/material.dart';

/// {@template icon_widget}
///
/// Widget to draw a Icon
///
/// {@endtemplate}
class IconWidget extends StatelessWidget {
  final IconData icon;
  final double size;
  final Animation<double> animationOpacity;
  final Color color;

  const IconWidget({
    Key? key,
    required this.animationOpacity,
    required this.icon,
    required this.size,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: animationOpacity,
        child: Icon(
          icon,
          size: size,
          color: color,
        ),
      ),
    );
  }
}

/// {@template custom_icon_widget}
///
/// Widget to draw a custom widget
///
/// {@endtemplate}
class CustomIconWidget extends StatelessWidget {
  final Widget icon;

  final Animation<double> animationOpacity;

  const CustomIconWidget({
    Key? key,
    required this.animationOpacity,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: animationOpacity,
        child: icon,
      ),
    );
  }
}
