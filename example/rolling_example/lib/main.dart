import 'package:flutter/material.dart';
import 'package:rolling_switch/rolling_switch.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final controller = RollingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rolling Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Icon Constructor:'),
            const SizedBox(height: 10),
            RollingSwitch.icon(
              onChanged: (bool state) {
                print('turned ${(state) ? 'on' : 'off'}');
              },
              rollingInfoRight: const RollingIconInfo(
                icon: Icons.flag,
                text: Text('Flag'),
              ),
              rollingInfoLeft: const RollingIconInfo(
                icon: Icons.check,
                backgroundColor: Colors.grey,
                text: Text('Check'),
              ),
            ),
            const SizedBox(height: 50),
            Text('Custom widget Constructor:'),
            const SizedBox(height: 10),
            RollingSwitch.widget(
              onChanged: (bool state) {
                print('turned ${(state) ? 'on' : 'off'}');
              },
              rollingInfoRight: RollingWidgetInfo(
                icon: FlutterLogo(),
                text: Text('Flutter'),
              ),
              rollingInfoLeft: RollingWidgetInfo(
                icon: FlutterLogo(
                  style: FlutterLogoStyle.stacked,
                ),
                backgroundColor: Colors.grey,
                text: Text('Stacked'),
              ),
              controller: controller,
            ),
            const SizedBox(height: 10),
            TextButton(
                onPressed: () => controller.start(),
                child: Text('Rolling from controller'))
          ],
        ),
      ),
    );
  }
}
