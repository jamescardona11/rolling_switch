# Basic use:


### Create a RollingSwitch Widget with Flutter Icons.
```dart

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
)
```

### Create a RollingSwitch Widget with custom Widget.
```dart
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
),
```