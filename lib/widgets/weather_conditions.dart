import 'package:flutter/material.dart';
import 'package:sunshine/models/weather.dart';

class WeatherCondition extends StatelessWidget {
  final WeatherModel weather;

  WeatherCondition(this.weather);

  getIcon(final icon) {
    Image image;
    var weatherPicture;
    switch (icon) {
      case '01d':
        weatherPicture = 'assets/01d.png';
        image = Image.asset(weatherPicture);
        break;
      case '01n':
        weatherPicture = 'assets/01n.png';
        image = Image.asset(weatherPicture);
        break;
      case '02d':
        weatherPicture = 'assets/02d.png';
        image = Image.asset(weatherPicture);
        break;
      case '02n':
        weatherPicture = 'assets/02n.png';
        image = Image.asset(weatherPicture);
        break;
      case '03d':
        weatherPicture = 'assets/03d.png';
        image = Image.asset(weatherPicture);
        break;
      case '03n':
        weatherPicture = 'assets/03n.png';
        image = Image.asset(weatherPicture);
        break;
      case '04d':
        weatherPicture = 'assets/04d.png';
        image = Image.asset(weatherPicture);
        break;
      case '04n':
        weatherPicture = 'assets/04n.png';
        image = Image.asset(weatherPicture);
        break;
      case '09d':
        weatherPicture = 'assets/09d.png';
        image = Image.asset(weatherPicture);
        break;
      case '09n':
        weatherPicture = 'assets/09n.png';
        image = Image.asset(weatherPicture);
        break;
      case '10d':
        weatherPicture = 'assets/10d.png';
        image = Image.asset(weatherPicture);
        break;
      case '10n':
        weatherPicture = 'assets/10n.png';
        image = Image.asset(weatherPicture);
        break;
      case '11d':
        weatherPicture = 'assets/11d.png';
        image = Image.asset(weatherPicture);
        break;
      case '11n':
        weatherPicture = 'assets/11n.png';
        image = Image.asset(weatherPicture);
        break;
      case '13d':
        weatherPicture = 'assets/13d.png';
        break;
      case '13n':
        weatherPicture = 'assets/13n.png';
        image = Image.asset(weatherPicture);
        break;
      case '50d':
        weatherPicture = 'assets/50d.png';
        image = Image.asset(weatherPicture);
        break;
      case '50n':
        weatherPicture = 'assets/50n.png';
        image = Image.asset(weatherPicture);
        break;
    }
    return image;
  }

  @override
  Widget build(BuildContext context) {
    var icon;
    weather.weather.map((e) {
      icon = e.icon;
    }).toList();
    return getIcon(icon);
  }
}
