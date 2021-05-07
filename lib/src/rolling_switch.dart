import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

import 'info/action_info.dart';
import 'info/rolling_info.dart';
import 'transform/transform_icon.dart';
import 'transform/transform_text.dart';
import 'utils/drag_utils.dart';
import 'widget/circular_container.dart';

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
    this.showIconContainer = true,
    this.animationDuration = const Duration(milliseconds: 600),
    this.actionInfo = const ActionInfo(),
  })  : assert(height >= 50.0 && innerSize >= 40.0),
        rollingInfoLeft = rollingInfoLeft,
        rollingInfoRight = rollingInfoRight,
        super(key: key);

  const RollingSwitch.widget({
    Key? key,
    required this.onChanged,
    RollingIconInfo rollingInfoRight = const RollingIconInfo(),
    RollingIconInfo rollingInfoLeft = const RollingIconInfo(
      backgroundColor: Colors.grey,
    ),
    this.initialState = false,
    this.width = 130,
    this.height = 50,
    this.innerSize = 40,
    this.showIconContainer = true,
    this.animationDuration = const Duration(milliseconds: 600),
    this.actionInfo = const ActionInfo(),
  })  : assert(height >= 50.0 && innerSize >= 40.0),
        rollingInfoLeft = rollingInfoLeft,
        rollingInfoRight = rollingInfoRight,
        super(key: key);

  final Function(bool) onChanged;
  final RollingInfo rollingInfoLeft;
  final RollingInfo rollingInfoRight;
  final bool initialState;
  final double width;
  final double height;
  final double innerSize;
  final bool showIconContainer;
  final Duration animationDuration;
  final ActionInfo actionInfo;

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
  bool canBeDragged = false;
  bool allWidget = false;

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
      maxSlide: widget.width - widget.innerSize - margin,
    );

    allWidget = widget.actionInfo.activeInAllWidget;

    turnState = widget.initialState;
    if (turnState) {
      animationController.value = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
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
                        child: TransforIconWidget(
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
    );
  }

  void action() {
    turnState = !turnState;
    turnState ? animationController.forward() : animationController.reverse();
    widget.onChanged(turnState);
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
}
