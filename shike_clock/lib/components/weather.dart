import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_clock_helper/model.dart';

class WeatherInfo extends StatelessWidget {
  final ClockModel clockModel;
  final DateTime now;
  final WeatherCondition weatherCondition;
  final Color color;

  WeatherInfo(this.clockModel, {@required this.color, @required this.now})
      : this.weatherCondition = clockModel.weatherCondition;

  String get weatherIconLocation {
    Set<String> supportWeatherSet = Set.of([
      'cloudy',
      'foggy',
      'rainy',
      'snowy',
      'sunny',
      'thunderstorm',
      'windy'
    ]);
    String weather = weatherCondition.toString().split('.').last;
    if (supportWeatherSet.contains(weather)) {
      if (weather == "sunny") {
        if (now.hour > 19 || now.hour < 5) {
          return 'assets/icons/stars_moon.svg';
        }
      }
      return 'assets/icons/$weather.svg';
    } else {
      return 'assets/icons/sunny.svg';
    }
  }

  @override
  Widget build(BuildContext context) {
    String temperature = clockModel.temperatureString;
    return new LayoutBuilder(builder: (context, constraints) {
      return Container(
          child: Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          Positioned(
              left: constraints.maxWidth * 0.6,
              top: constraints.maxHeight * 0.5,
              child: SvgPicture.asset(weatherIconLocation,
                  color: color, width: constraints.maxWidth / 10)),
          Positioned(
              left: constraints.maxWidth * 0.6,
              top: constraints.maxHeight * 0.754,
              child: Text(
                temperature,
                style: TextStyle(
                    color: color,
                    fontFamily: 'FakeHope',
                    fontSize: constraints.maxWidth * 0.07),
              )),
          SvgPicture.asset('assets/mountain.svg', color: color)
        ],
      ));
    });
  }
}
