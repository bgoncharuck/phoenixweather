import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:phoenixweather_common/phoenixweather_common.dart';
import '../lib/src/models/weather.dart';
import '../lib/src/models/currentdata.dart';

part 'model/model_test.dart';

void main() {
  testAll();
}

Future testAll() async {
  await phoenixWeatherModuleTest();
  String city= "London";

  // WeatherModel test
  final cityWeatherTomorrow= await 
  weatherModelFromMorningOfFirstDayTest(location: city);
  if (cityWeatherTomorrow != null)
    print("Temperature in $city is ${cityWeatherTomorrow.temperature} K");

  // CurrentData test
  final currentData= await currentDataJsonTests(location: "Одеса");
  print(currentData.location);
}

Future phoenixWeatherModuleTest() async {
  final weatherInParis= await   whatIsTheWeatherIn(location: "Paris");

  // handle error
  if (weatherInParis == null) {
      if (locationModel != null) 
      // print error
      print(locationModel.data);
  } else print("Temperature in ${locationModel.data} is ${weatherInParis.hourly[0].temp} K");
}