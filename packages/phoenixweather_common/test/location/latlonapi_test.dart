part of '../main.dart';

Future<List<String>> threeCitiesAndWrongLocationAsJsonList() async {
  LatLonApiClient googleGeocoding = GoogleGeocoding();
  List<String> locationJsonList = [];

  locationJsonList
      .add(jsonEncode(await googleGeocoding.getByCityName(city: "Вінниця")));
  locationJsonList
      .add(jsonEncode(await googleGeocoding.getByCityName(city: "Lviv")));
  locationJsonList
      .add(jsonEncode(await googleGeocoding.getByCityName(city: "Киев")));
  locationJsonList.add(
      jsonEncode(await googleGeocoding.getByCityName(city: "Лол Кек Чебурек")));

  return locationJsonList;
}
