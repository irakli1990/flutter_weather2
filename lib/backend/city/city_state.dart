import 'package:equatable/equatable.dart';
import 'package:sunshine/models/favorite_city.dart';

abstract class CityState extends Equatable {
  const CityState();

  @override
  List<Object> get props => [];
}

class CityLoading extends CityState {}

class CityLoaded extends CityState {
  final List<FavoriteCity> cities;

  const CityLoaded([this.cities = const []]);

  @override
  List<Object> get props => [cities];

  @override
  String toString() => 'CityLoaded { todos: $cities }';
}

class CityNotLoaded extends CityState {}
