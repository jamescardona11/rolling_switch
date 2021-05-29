import 'package:tools_tkmonkey/tools_tkmonkey_flutter.dart';

/// {@template rolling_controller}
///
/// Using `TKMController` to create a custom Controller for the drawer
///
/// The controller use: Open, Close, Start and GetPosition `mixin` from `TKMController`
/// https://github.com/TKMonkey/tools_tkmonkey_flutter
///
/// {@endtemplate}

class RollingController extends TKMController
    with StartFunction, GetPositionFunction {
  void start() => startFunction();

  double get drawerPosition => getPositionFunction;
}
