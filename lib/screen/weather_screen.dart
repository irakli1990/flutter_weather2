import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:sunshine/backend/city/bloc.dart';
import 'package:sunshine/backend/theme_bloc.dart';
import 'package:sunshine/backend/weather/bloc.dart';
import 'package:sunshine/backend/weather/weather_bloc.dart';
import 'package:sunshine/models/favorite_city.dart';
import 'package:sunshine/models/weather.dart';
import 'package:sunshine/models/weather_forecast.dart';
import 'package:sunshine/widgets/combine_temperature.dart';
import 'package:sunshine/widgets/gradient_container.dart';
import 'package:sunshine/widgets/location_widget.dart';
import 'package:sunshine/widgets/main_text.dart';
import 'package:sunshine/widgets/world_spiner.dart';

import '../widgets/city_selection.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final Geolocator geoLocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  Placemark _place;
  String _currentCity;
  Completer<void> _refreshCompleter;


  //init notification and refresh plugins
  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = new IOSInitializationSettings();
    var initSettings = new InitializationSettings(android, iOS);
    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: onSelectNotification);
    _refreshCompleter = Completer<void>();
  }

  // Method returning localisation and getting localisation weather after clicking every
  // day notification.
  Future onSelectNotification(String payload) {
    return _getLocalisation();
  }

  // getting localisation
  _getLocalisation() async {
    _currentPosition = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    try {
      List<Placemark> p = await geoLocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      _place = p[0];

      setState(() {
        _currentCity = "${_place.locality}";
      });
    } catch (e) {
      print(e);
    }
    // getting weather for city
    if (_currentCity != null) {
      BlocProvider.of<WeatherBloc>(context)
          .add(GetWeatherEvent(city: _currentCity));
    }
  }

  // formatting datetime for notification
  _formatDateTime() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MM-dd-yyyy hh:mm').format(now);
    return formattedDate;
  }

  // showing notification every day at 6 o'clock
  showNotification() async {
    var time = new Time(6, 0, 0);
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'repeatDailyAtTime channel id',
        'repeatDailyAtTime channel name',
        'repeatDailyAtTime description',
        priority: Priority.High,
        importance: Importance.Max);
    var iOS = new IOSNotificationDetails();
    var platform =
        new NotificationDetails(androidPlatformChannelSpecifics, iOS);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        0,
        'Check weather today',
        'Every day weather in your city ${_formatDateTime()}',
        time,
        platform);
  }

  @override
  Widget build(BuildContext context) {
    showNotification();
    return Scaffold(
      appBar: AppBar(
        title: Text('SunShine'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final city = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CitySelection(),
                ),
              );
              if (city != null) {
                BlocProvider.of<WeatherBloc>(context)
                    .add(GetWeatherEvent(city: city));
              }
            },
          )
        ],
      ),
      body: Center(
        child: BlocListener<WeatherBloc, WeatherState>(
          listener: (context, state) {
            if (state is WeatherLoadedState) {
              state.weather.weather.map((e) {
                descriptionValues.reverse.forEach((k, v) {
                  if (e.description == v) {
                    print(k);
                    BlocProvider.of<ThemeBloc>(context).add(
                      WeatherChanged(condition: k),
                    );
                  }
                });
              }).toList();
            }
          },
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherLoadingErrorState) {
                return Center(child: Text('Please Select a Location'));
              }
              if (state is WeatherLoadingState) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is WeatherLoadedState) {
                final WeatherModel weather = state.weather;
                print(weather);
                return BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, themeState) {
                    return GradientContainer(
                      color: themeState.color,
                      child: RefreshIndicator(
                        onRefresh: () {
                          BlocProvider.of<WeatherBloc>(context).add(
                            RefreshWeather(city: weather.name),
                          );
                          BlocProvider.of<CityBloc>(context).add(AddCity(
                              FavoriteCity.withId(
                                  id: weather.id, cityName: weather.name)));
                          return _refreshCompleter.future;
                        },
                        child: ListView(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 100.0),
                              child: Center(
                                child: Location(location: weather.name),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 50.0),
                              child: Center(
                                child: CombinedWeatherTemperature(
                                  weather: weather,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: MainText(),
                  ),
                  WorldSinner(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
