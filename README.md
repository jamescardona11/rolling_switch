<p align="center">
<img src="https://github.com/jamescardona11/rolling_switch/blob/main/img/logo.png?raw=true" height="250" alt="Rolling Switch Package" />
</p>

---

Full customizable rolling switch widget for flutter apps forked from this [library](https://github.com/cgustav/lite_rolling_switch)
</br>
Custom Switch button with attractive animation,
made to allow you to customize colors, icons, custom widget and other cosmetic content. 

Manage the widget states in the same way you do with the classical material's switch widget.

[![style: lint](https://img.shields.io/badge/style-lint-4BC0F5.svg)](https://pub.dev/packages/lint)   [![](https://img.shields.io/github/license/jamescardona11/rolling_switch)](https://github.com/jamescardona11/rolling_switch/blob/main/LICENSE) [![](https://img.shields.io/pub/v/rolling_switch)](https://pub.dev/packages/rolling_switch)

---
## Quick Start

Import this library into your project:

```yaml
roling_switch: ^latest_version
```



## Basic Implementation

#### Using the icon constructor
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
),
```


#### More possibilities
- Create a custom widget, use: 
    ```dart
    const RollingWidgetInfo(icon: FlutterLogo())
    ```
</br>

- Change color background between transactions left/right
    ```dart
    RollingSwitch.icon(    
      rollingInfoRight: const RollingIconInfo(
        backgroundColor: Colors.green,
      ),
      rollingInfoLeft: const RollingIconInfo(
        backgroundColor: Colors.grey,
      ),
    )
    ```
</br>

- Change Circular color
    ```dart
    RollingSwitch.icon(
      ...
      circularColor: (icon: FlutterLogo())
    )
    ```
</br>

- Create a custom text indicator
    ```dart
    RollingSwitch.icon(    
      rollingInfoRight: const RollingIconInfo(
        text: Text('Flag'),
      ),
      rollingInfoLeft: const RollingIconInfo(
        text: Text('Stack'),
      ),
    )
    ```
</br>

- Enable drag switch
    ```dart
    RollingSwitch.icon(
      ...
      enableDrag: true
    )
    ```
</br>

## Previews

![](https://github.com/jamescardona11/rolling_switch/blob/main/img/example.gif?raw=true)
