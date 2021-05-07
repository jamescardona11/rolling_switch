import 'package:flutter/material.dart';

/// {@template rolling_info}
///
/// Base class to create a rolling information
/// This class its a helper to customizing the Rolling Switch
///
/// {@endtemplate}
abstract class RollingInfo<T> {
  final Text? text;
  final Color backgroundColor;
  final T icon;

  const RollingInfo(this.text, this.backgroundColor, this.icon);
}

/// {@template rolling_icon_info}
///
/// This class is for customizing rolling switch when `icon` constructor it's use
///
/// {@endtemplate}
class RollingIconInfo extends RollingInfo<IconData> {
  const RollingIconInfo({
    Text? text,
    Color backgroundColor = Colors.lightBlueAccent,
    IconData icon = Icons.check,
    this.iconColor,
  }) : super(text, backgroundColor, icon);

  final Color? iconColor;
}

/// {@template rolling_widget_info}
///
/// This class is for customizing rolling switch when `widget` constructor it's use
///
/// {@endtemplate}
class RollingWidgetInfo extends RollingInfo<Widget> {
  const RollingWidgetInfo({
    Text? text,
    Color backgroundColor = Colors.lightBlueAccent,
    Widget icon = const SizedBox(),
  }) : super(text, backgroundColor, icon);
}
