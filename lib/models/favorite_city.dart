// To parse this JSON data, do
//
//     final city = cityFromJson(jsonString);

import 'dart:convert';

FavoriteCity cityFromJson(String str) => FavoriteCity.fromMap(json.decode(str));

String cityToJson(FavoriteCity data) => json.encode(data.toMap());

class FavoriteCity {
  int id;
  String cityName;

  FavoriteCity.withId({
    this.id,
    this.cityName,
  });
  FavoriteCity({
    this.cityName,
  });

  FavoriteCity copyWith({
    int id,
    String cityName,
  }) =>
      FavoriteCity.withId(
        id: id ?? this.id,
        cityName: cityName ?? this.cityName,
      );

  factory FavoriteCity.fromMap(Map<String, dynamic> json) => FavoriteCity.withId(
    id: json["id"] == null ? null : json["id"],
    cityName: json["city_name"] == null ? null : json["city_name"],
  );


  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "city_name": cityName == null ? null : cityName,
  };

  @override
  String toString() {
    return 'FavoriteCity{id: $id, cityName: $cityName}';
  }

}
