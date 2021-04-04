import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:phoenixweather/client/client.dart';

part 'currentdata/currentdata.dart';
part 'location/latlonapi_test.dart';
part 'weather/weatherapi_test.dart';

void main() {
  clientTest();
  currentDataTest();
}

Future clientTest() async {
  // location
  final locations = await threeCitiesAndWrongLocationAsJsonList();
  print(locations);
  print("\n--------\n\n");

  // weather
  final weatherModel = await weatherForOneLocation(
      location: DefaultLatLonApiModel.fromJson(jsonDecode(locations[0])));
  print(weatherModel.hourly[0].dt);
  print("\n--------\n\n");

  // weatherHandle
  OpenWeatherModel weather = await whatIsTheWeatherIn(location: "Berlin");
  if (weather == null) {
    // print errror
    if (locationModel != null)
      print(locationModel.data);
    else
      print("Error: internal language error");
  } else
    print(
        "Temperature in ${locationModel.data} is ${weather.hourly[0].temp} K");
  print("\n--------\n\n");

  // json test
  final jsonTest = json.decode(json.encode(weather.toJson()));
  assert(
      OpenWeatherModel.fromJson(jsonTest).location.data ==
          weather.location.data,
      "JSON test failed");
}

Future currentDataTest() async {
  await phoenixWeatherModuleTest();
  String city = "London";

  // WeatherModel test
  final cityWeatherTomorrow =
      await weatherModelFromMorningOfFirstDayTest(location: city);
  if (cityWeatherTomorrow != null)
    print("Temperature in $city is ${cityWeatherTomorrow.temperature} K");

  // CurrentData test
  final currentData = await currentDataJsonTests(location: "Одеса");
  print(currentData.location);
}

Future phoenixWeatherModuleTest() async {
  final weatherInParis = await whatIsTheWeatherIn(location: "Paris");

  // handle error
  if (weatherInParis == null) {
    if (locationModel != null)
      // print error
      print(locationModel.data);
  } else
    print(
        "Temperature in ${locationModel.data} is ${weatherInParis.hourly[0].temp} K");
}
