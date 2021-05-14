import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rolling_switch/src/transform/transform_text.dart';

import 'info/rolling_info.dart';
import 'transform/transform_icon.dart';
import 'utils/drag_utils.dart';
import 'widget/circular_container.dart';

/// {@template rolling_switch_widget}
///
/// The main widget to show a rolling widget
/// Customable and attractive Switch button.
///
/// ```dart
/// RollingSwitch.icon(
///   onChanged: (bool state) {
///     print('turned ${(state) ? 'on' : 'off'}');
///   },
///   rollingInfoRight: const RollingIconInfo(
///     icon: Icons.flag,
///     text: Text('Flag'),
///   ),
///   rollingInfoLeft: const RollingIconInfo(
///     icon: Icons.check,
///     backgroundColor: Colors.grey,
///     text: Text('Check'),
///   ),
/// )
/// ```
///
/// The only required value is:
/// * [onChanged] is called when the user toggles the switch left or right
///
/// Available constructors:
/// * RollingSwitch.icon: Create a Rolling with flutter icons
/// * RollingSwitch.widget: Create a Rolling with custom widget
///
/// {@endtemplate}

class RollingSwitch extends StatefulWidget {
  const RollingSwitch.icon({
    Key? key,
    required this.onChanged,
    RollingIconInfo rollingInfoRight = const RollingIconInfo(
      icon: Icons.flag,
    ),
    RollingIconInfo rollingInfoLeft = const RollingIconInfo(
      icon: Icons.check,
      backgroundColor: Colors.grey,
    ),
    this.initialState = false,
    this.width = 130,
    this.height = 50,
    this.innerSize = 40,
    this.circularColor = Colors.white,
    this.enableDrag = false,
    this.animationDuration = const Duration(milliseconds: 400),
    this.onTap,
  })  : assert(height >= 50.0 && innerSize >= 40.0),
        rollingInfoLeft = rollingInfoLeft,
        rollingInfoRight = rollingInfoRight,
        super(key: key);

  const RollingSwitch.widget({
    Key? key,
    required this.onChanged,
    RollingWidgetInfo rollingInfoRight = const RollingWidgetInfo(),
    RollingWidgetInfo rollingInfoLeft = const RollingWidgetInfo(
      backgroundColor: Colors.grey,
    ),
    this.initialState = false,
    this.width = 130,
    this.height = 50,
    this.innerSize = 40,
    this.circularColor = Colors.white,
    this.enableDrag = false,
    this.animationDuration = const Duration(milliseconds: 400),
    this.onTap,
  })  : assert(height >= 50.0 && innerSize >= 40.0),
        rollingInfoLeft = rollingInfoLeft,
        rollingInfoRight = rollingInfoRight,
        super(key: key);

  /// [onChanged] is called when the user toggles the switch left or right
  final Function(bool) onChanged;

  /// [rollingInfoLeft] configure the infor for the when icon is in left
  final RollingInfo rollingInfoLeft;

  /// [rollingInfoRight] configure the infor for the when icon is in right
  final RollingInfo rollingInfoRight;

  /// [initialState] determines whether this switch is left or right
  final bool initialState;

  /// [width] width size
  final double width;

  /// [height] height size
  final double height;

  /// [innerSize] helper to change size of icon and elements into the rolling switch
  final double innerSize;

  /// [circularColor] color for the circular icon wrapper
  final Color circularColor;

  /// [enableDrag] enable the drag event, for the moment only can use drag or tap
  final bool enableDrag;

  /// [animationDuration] animation duration
  final Duration animationDuration;

  /// [onTap] function callback when tap is called
  final Function? onTap;

  @override
  _RollingSwitchState createState() => _RollingSwitchState();
}

class _RollingSwitchState extends State<RollingSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  late Animation<double> animationOpacityLeft;
  late Animation<double> animationOpacityRight;
  late Animation<Color?> animationColor;

  final double margin = 10.0;
  double value = 0.0;

  late DragUtils dragUtils;

  bool turnState = true;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    initAllAnimation();

    dragUtils = DragUtils(
        animationController: animationController,
        maxSlide: widget.width - widget.innerSize - margin);

    turnState = widget.initialState;
    if (turnState) {
      animationController.value = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.enableDrag
          ? null
          : () {
              widget.onTap?.call();
              action();
            },
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) => Container(
          padding: const EdgeInsets.all(5),
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: animationColor.value,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: Stack(
              children: [
                TransformRightTextWidget(
                  margin: margin,
                  animationValue: animationController.value,
                  animationOpacity: animationOpacityRight,
                  text: widget.rollingInfoRight.text,
                ),
                TransformLeftTextWidget(
                  margin: margin,
                  innerSize: widget.innerSize,
                  animationValue: animationController.value,
                  animationOpacity: animationOpacityLeft,
                  text: widget.rollingInfoLeft.text,
                ),
                GestureDetector(
                  onHorizontalDragStart: dragUtils.onDragStart,
                  onHorizontalDragUpdate: dragUtils.onDragUpdate,
                  onHorizontalDragEnd: dragUtils.onDragEnd,
                  child: AnimatedBuilder(
                    animation: animationController,
                    builder: (_, child) => Transform.translate(
                      offset: Offset(dragUtils.maxSlide * animationController.value, 0),
                      child: child,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Transform.rotate(
                        angle: lerpDouble(0, 2 * math.pi, animationController.value)!,
                        child: CircularContainer(
                          size: widget.innerSize,
                          color: widget.circularColor,
                          child: TransforRollingWidget(
                            animationOpacityLeft: animationOpacityLeft,
                            animationOpacityRight: animationOpacityRight,
                            innerSize: widget.innerSize,
                            rollingInfoLeft: widget.rollingInfoLeft,
                            rollingInfoRight: widget.rollingInfoRight,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void initAllAnimation() {
    animationOpacityLeft = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
      ),
    );

    animationOpacityRight = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.45, 1.0, curve: Curves.easeInOut),
      ),
    );

    animationColor = ColorTween(
            begin: widget.rollingInfoLeft.backgroundColor,
            end: widget.rollingInfoRight.backgroundColor)
        .animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 1.0, curve: Curves.easeInOut),
      ),
    );
  }

  void action() {
    turnState = !turnState;
    turnState ? animationController.forward() : animationController.reverse();
    widget.onChanged(turnState);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
