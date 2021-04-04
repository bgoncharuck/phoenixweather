part of '../main.dart';

Future<OpenWeatherModel> weatherForOneLocation(
    {@required LatLonApiModel location}) async {
  OpenWeatherAPIClient openWeather = OpenWeather();

  return await openWeather.getByLocation(location: location);
}
