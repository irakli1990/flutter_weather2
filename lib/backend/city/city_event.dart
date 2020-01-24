import 'package:equatable/equatable.dart';
import 'package:sunshine/models/favorite_city.dart';

abstract class CityEvent extends Equatable {
  const CityEvent();

  @override
  List<Object> get props => [];
}

class LoadCities extends CityEvent {}

class AddCity extends CityEvent {
  final FavoriteCity city;

  const AddCity(this.city);

  @override
  List<Object> get props => [city];

  @override
  String toString() => 'AddCity { city: $city}';
}

class DeleteCity extends CityEvent {
  final FavoriteCity city;

  const DeleteCity(this.city);

  @override
  List<Object> get props => [city];

  @override
  String toString() => 'DeleteCity { todo: $city }';
}
