part of '../main.dart';

Future<WeatherModel> weatherModelFromMorningOfFirstDayTest(
    {String location = "Rome"}) async {
  final weatherInRome = await whatIsTheWeatherIn(location: location);
  if (weatherInRome == null) return null;

  return WeatherModel.fromOWHour(weatherInRome.hourly[30]);
}

Future<CurrentData> currentDataJsonTests({@required String location}) async {
  final openWeather = await whatIsTheWeatherIn(location: location);
  if (openWeather == null) return null;

  final initData = CurrentData.fromOW(openWeather);

  final toJson = initData.toJson();
  final encoded = json.encode(toJson);
  final decoded = json.decode(encoded);
  final lastData = CurrentData.fromJson(decoded);

  return lastData;
}
