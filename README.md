# lite_rolling_switch

Full customable rolling switch widget for flutter apps based on Pedro Massango's 'crazy-switch' widget https://github.com/pedromassango/crazy-switch

## About 

Custom Switch button with attractive animation,
made to allow you to customize colors, icons and other cosmetic content. Manage the widget states in the same way you do with the classical material's switch widget.

> **NOTE UPDATE**: 
- Currently, you can directly change the widget width and height properties.
- TextOn and TextOff are TextWidget.

## Previews

![Image preview](https://media.giphy.com/media/hTx1jlMxasyVejHa6U/giphy.gif)

![Image preview 2](https://media.giphy.com/media/TKSIVzM5RUDxnjucTf/giphy.gif)

## Basic Implementation

``` dart
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

LiteRollingSwitch(
    initialState: true,
    textOn: Text('active'),
    textOff: Text('inactive'),
    colorOn: Colors.deepOrange,
    colorOff: Colors.blueGrey,
    iconOn: Icons.lightbulb_outline,
    iconOff: Icons.power_settings_new,
    onChanged: (bool state) {
        print('turned ${(state) ? 'on' : 'off'}');
    },
)

```
