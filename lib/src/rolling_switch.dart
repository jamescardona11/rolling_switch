import 'package:flutter/material.dart';

import 'info/rolling_info.dart';
import 'widget/circular_container.dart';
import 'widget/rolling_icon_widget.dart';

class RollingSwitch extends StatefulWidget {
  const RollingSwitch.icon({
    Key? key,
    required this.onChanged,
    RollingIconInfo rollingInfoOn = const RollingIconInfo(),
    RollingIconInfo rollingInfoOff = const RollingIconInfo(),
    this.initialState = false,
    this.width = 130,
    this.height = 50,
    this.innerSize = 40,
    this.showIconContainer = true,
    this.animationDuration = const Duration(milliseconds: 600),
    this.onTap,
    this.onSwipe,
  })  : assert(height >= 50.0 && innerSize >= 40.0),
        rollingInfoOn = rollingInfoOn,
        rollingInfoOff = rollingInfoOff,
        super(key: key);

  const RollingSwitch.widget({
    Key? key,
    required this.onChanged,
    RollingWidgetInfo rollingInfoOn = const RollingWidgetInfo(),
    RollingWidgetInfo rollingInfoOff = const RollingWidgetInfo(),
    this.initialState = false,
    this.width = 130,
    this.height = 50,
    this.innerSize = 40,
    this.showIconContainer = true,
    this.animationDuration = const Duration(milliseconds: 600),
    this.onTap,
    this.onSwipe,
  })  : assert(height >= 50.0 && innerSize >= 40.0),
        rollingInfoOn = rollingInfoOn,
        rollingInfoOff = rollingInfoOff,
        super(key: key);

  final Function(bool) onChanged;
  final RollingInfo rollingInfoOn;
  final RollingInfo rollingInfoOff;
  final bool initialState;
  final double width;
  final double height;
  final double innerSize;
  final bool showIconContainer;
  final Duration animationDuration;
  final Function? onTap;
  final Function? onSwipe;

  @override
  _RollingSwitchState createState() => _RollingSwitchState();
}

class _RollingSwitchState extends State<RollingSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  late Animation<double> animationOpacityOff;
  late Animation<double> animationOpacityOn;
  late Animation<Color?> animationColor;

  final double margin = 10.0;
  double maxWidthRotation = 0.0;
  double value = 0.0;

  bool turnState = true;

  @override
  void initState() {
    super.initState();
    maxWidthRotation = widget.width - widget.innerSize - margin;

    animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    initAllAnimation();
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
              CircularContainer(
                size: widget.innerSize,
                child: Stack(
                  children: <Widget>[
                    IconWidget(
                      animationOpacity: animationOpacityOff,
                      iconData: (widget.rollingInfoOff as RollingIconInfo).icon,
                      size: widget.innerSize / 2,
                      colorValue: animationColor.value!,
                      iconColor:
                          (widget.rollingInfoOff as RollingIconInfo).colorIconActive,
                    ),
                    IconWidget(
                      animationOpacity: animationOpacityOn,
                      iconData: (widget.rollingInfoOn as RollingIconInfo).icon,
                      size: widget.innerSize / 2,
                      colorValue: animationColor.value!,
                      iconColor:
                          (widget.rollingInfoOn as RollingIconInfo).colorIconActive,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void initAllAnimation() {
    animation = CurvedAnimation(parent: animationController, curve: Curves.easeInOut);

    animationOpacityOff = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
      ),
    );

    animationOpacityOn = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.45, 1.0, curve: Curves.easeInOut),
      ),
    );

    animationColor = ColorTween(
            begin: widget.rollingInfoOff.backgroundColor,
            end: widget.rollingInfoOn.backgroundColor)
        .animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 1.0, curve: Curves.easeInOut),
      ),
    );
  }
}
