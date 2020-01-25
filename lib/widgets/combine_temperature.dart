import 'package:flutter/material.dart';
import 'package:sunshine/models/weather.dart';
import 'package:sunshine/widgets/temperature.dart';
import 'package:sunshine/widgets/weather_conditions.dart';


// temperature  widget
class CombinedWeatherTemperature extends StatelessWidget {
  final WeatherModel weather;

  CombinedWeatherTemperature({
    Key key,
    @required this.weather,
  })  : assert(weather != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var description;
    weather.weather.map((e) {
      description = e.description;
    }).toList();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: WeatherCondition(weather),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Temperature(
                temperature: weather.main.temp,
                high: weather.main.tempMax.toDouble(),
                low: weather.main.tempMin,
              ),
            ),
          ],
        ),
        Center(
          child: Text(
            description,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w200,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
