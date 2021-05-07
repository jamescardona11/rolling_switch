import 'package:flutter/material.dart';
import 'package:rolling_switch/src/info/rolling_info.dart';
import 'package:rolling_switch/src/widget/rolling_icon_widget.dart';

/// {@template transform_icon}
///
/// This class transform the rollingInfo in a stack with [IconWidget] or [CustomIconWidget]
///
/// {@endtemplate}
class TransforRollingWidget extends StatelessWidget {
  const TransforRollingWidget({
    Key? key,
    required this.rollingInfoRight,
    required this.rollingInfoLeft,
    required this.animationOpacityRight,
    required this.animationOpacityLeft,
    required this.innerSize,
  }) : super(key: key);

  final RollingInfo rollingInfoRight;
  final RollingInfo rollingInfoLeft;
  final Animation<double> animationOpacityRight;
  final Animation<double> animationOpacityLeft;
  final double innerSize;

  @override
  Widget build(BuildContext context) {
    if (rollingInfoLeft is RollingIconInfo) {
      final rl = rollingInfoLeft as RollingIconInfo;
      final rr = rollingInfoRight as RollingIconInfo;

      return Stack(
        children: [
          IconWidget(
            animationOpacity: animationOpacityLeft,
            icon: rl.icon,
            size: innerSize / 2,
            color: rl.iconColor ?? rl.backgroundColor,
          ),
          IconWidget(
            animationOpacity: animationOpacityRight,
            icon: rr.icon,
            size: innerSize / 2,
            color: rr.iconColor ?? rr.backgroundColor,
          ),
        ],
      );
    } else {
      final rl = rollingInfoLeft as RollingWidgetInfo;
      final rr = rollingInfoRight as RollingWidgetInfo;
      return Stack(
        children: [
          CustomIconWidget(
            animationOpacity: animationOpacityLeft,
            icon: rl.icon,
          ),
          CustomIconWidget(
            animationOpacity: animationOpacityRight,
            icon: rr.icon,
          ),
        ],
      );
    }
  }
}
