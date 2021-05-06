import 'package:flutter/material.dart';

class RollingSwitch extends StatelessWidget {
  const RollingSwitch({
    Key? key,
    this.initialState = false,
    required this.onChanged,
    this.width = 130,
    this.height = 50,
  }) : super(key: key);

  final bool initialState;
  final Function(bool) onChanged;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Hello'),
      ),
    );
  }
}
