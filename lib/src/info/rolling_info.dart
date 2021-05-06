import 'package:flutter/material.dart';

abstract class RollingInfo<T> {
  final Text? text;
  final Color backgroundColor;
  final T icon;

  RollingInfo(this.text, this.backgroundColor, this.icon);
}

class IconInfoOn extends RollingInfo<IconData> {
  IconInfoOn({
    Text? text,
    Color backgroundColor = Colors.lightBlueAccent,
    IconData icon = Icons.check,
    this.colorIconActive,
    this.colorIconInactive,
  }) : super(text, backgroundColor, icon);

  final Color? colorIconActive;
  final Color? colorIconInactive;
}

class IconInfoOff extends RollingInfo<IconData> {
  IconInfoOff({
    Text? text,
    Color backgroundColor = Colors.grey,
    IconData icon = Icons.flag,
    this.colorIconActive,
    this.colorIconInactive,
  }) : super(text, backgroundColor, icon);

  final Color? colorIconActive;
  final Color? colorIconInactive;
}

class WidgetInfoOn extends RollingInfo<Widget> {
  WidgetInfoOn(Text? text, Color backgroundColor, Widget icon)
      : super(text, backgroundColor, icon);
}

class WidgetInfoOff extends RollingInfo<Widget> {
  WidgetInfoOff(Text? text, Color backgroundColor, Widget icon)
      : super(text, backgroundColor, icon);
}
