import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunshine/backend/city/bloc.dart';
import 'package:sunshine/backend/weather/bloc.dart';

import 'package:sunshine/repository/weather_repo.dart';
import 'package:sunshine/screen/weather_screen.dart';

import 'backend/theme_bloc.dart';
import 'simple_bloc_delegate.dart';

void main() {
  final WeatherRepository weatherRepository = WeatherRepository();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<WeatherBloc>(
          create: (context) => WeatherBloc(weatherRepository),
        ),
        BlocProvider<CityBloc>(
          create: (context) => CityBloc(),
        ),
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(),
        ),
      ],
      child: App(weatherRepository: weatherRepository),
    ),
  );
}

class App extends StatelessWidget {
  final WeatherRepository weatherRepository;

  App({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            title: 'SunShine',
            debugShowCheckedModeBanner: false,
            theme: themeState.theme,
            color: themeState.color,
            home: BlocProvider(
              create: (context) =>
                  WeatherBloc(
                    weatherRepository,
                  ),
              child: WeatherScreen(),
            ),
          );
        });
  }
}