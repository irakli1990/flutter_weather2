import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:sunshine/backend/city/bloc.dart';
import 'package:sunshine/data/database.dart';
import 'package:sunshine/models/favorite_city.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  DatabaseHelper _databaseHelper = DatabaseHelper();
  List<FavoriteCity> cities;

  @override
  CityState get initialState => CityLoading();

  @override
  Stream<CityState> mapEventToState(CityEvent event) async* {
    if (event is LoadCities) {
      yield CityLoading();
      await for (final response
          in this._databaseHelper.getCityList().asStream()) {
        yield CityLoaded(response);
      }
    } else if (event is AddCity) {
      _save(event);
      yield CityLoaded(cities.map((e) {}).toList());
    } else if (event is DeleteCity) {
      this._databaseHelper.deleteCity(event.city);
      yield CityLoading();
      await for (final response
          in this._databaseHelper.getCityList().asStream()) {
        yield CityLoaded(response);
      }
    }
  }

  void _save(AddCity event) async {
    FavoriteCity city =
        FavoriteCity.withId(cityName: event.city.cityName, id: event.city.id);
    int result = await _databaseHelper.saveCity(city);
    result != 0 ? print('OK') : print('ERROR');
  }
}
