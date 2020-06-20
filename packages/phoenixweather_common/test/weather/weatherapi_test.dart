part of '../main.dart';

Future<OpenWeatherModel> weatherForOneLocation({@required ILatLonApiModel location}) async {
  IOpenWeatherAPIClient openWeather= OpenWeather();

  return await openWeather.getByLocation(location: location);
}