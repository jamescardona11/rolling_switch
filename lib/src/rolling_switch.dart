import 'package:flutter/material.dart';

import 'info/rolling_info.dart';
import 'widget/circular_container.dart';
import 'widget/transform_rolling_info.dart';

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
    this.onTap,
    this.onSwipe,
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
    this.onTap,
    this.onSwipe,
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
  final Function? onTap;
  final Function? onSwipe;

  @override
  _RollingSwitchState createState() => _RollingSwitchState();
}

class _RollingSwitchState extends State<RollingSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  late Animation<double> animationOpacityLeft;
  late Animation<double> animationOpacityRight;
  late Animation<Color?> animationColor;

  final double margin = 10.0;
  double value = 0.0;

  late double maxSlide;
  late double minDragStartEdge;
  late double maxDragStartEdge;

  bool turnState = true;
  bool canBeDragged = false;

  @override
  void initState() {
    super.initState();

    maxSlide = widget.width - widget.innerSize - margin;
    minDragStartEdge = 40;
    maxDragStartEdge = maxSlide - 16;

    animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    initAllAnimation();

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
        child: GestureDetector(
          onHorizontalDragStart: onDragStart,
          onHorizontalDragUpdate: onDragUpdate,
          onHorizontalDragEnd: onDragEnd,
          child: AnimatedBuilder(
            animation: animationController,
            builder: (_, child) {
              final double animValue = animationController.value;
              final slideAmount = maxSlide * animValue;
              return Transform.translate(
                offset: Offset(slideAmount, 0),
                // transform: Matrix4.identity()..translate(slideAmount),
                // alignment: Alignment.centerLeft,
                child: child,
              );
            },
            child: Align(
              alignment: Alignment.centerLeft,
              child: CircularContainer(
                size: widget.innerSize,
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
    );
  }

  void onDragStart(DragStartDetails details) {
    final bool isDragOpenFromLeft =
        animationController.isDismissed && details.localPosition.dx < minDragStartEdge;
    final bool isDragCloseFromRight =
        animationController.isCompleted && details.localPosition.dx > maxDragStartEdge;

    canBeDragged = isDragCloseFromRight || isDragOpenFromLeft;
  }

  void onDragUpdate(DragUpdateDetails details) {
    if (canBeDragged) {
      final double delta = (details.primaryDelta ?? 0) / maxSlide;
      animationController.value += delta;
    }
  }

  void onDragEnd(DragEndDetails details) {
    if (animationController.isCompleted || animationController.isDismissed) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= 365) {
      final double visualVelocity =
          details.velocity.pixelsPerSecond.dx / MediaQuery.of(context).size.width;
      animationController.fling(velocity: visualVelocity);
    } else if (animationController.value < 0.5) {
      close();
    } else {
      open();
    }
  }

  void action() {
    turnState = !turnState;
    turnState ? animationController.forward() : animationController.reverse();
    widget.onChanged(turnState);
  }

  void close() => animationController.reverse();

  void open() => animationController.forward();

  void initAllAnimation() {
    animation = CurvedAnimation(parent: animationController, curve: Curves.easeInOut);

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
