import 'package:flutter/material.dart';
import 'package:phoenixweather_flutter_app/theme/language.dart';
final ILanguageSetting _language= systemLanguage;

Widget weatherToIcon({@required String weather, @required bool isNight}) {
  if (isNight) {
    if (weather == "Thunderstorm")
      return Image(image: AssetImage('assets/weather/thunderstorm_night.png'));
    else if (weather == "Drizzle")
      return Image(image: AssetImage('assets/weather/shower_rain_night.png'));
    else if (weather == "Rain")
      return Image(image: AssetImage('assets/weather/rain_night.png'));
    else if (weather == "Snow")
      return Image(image: AssetImage('assets/weather/snow_night.png'));
    else if (weather == "Atmosphere")
      return Image(image: AssetImage('assets/weather/mist_night.png'));
    else if (weather == "Clear")
      return Image(image: AssetImage('assets/weather/clear_night.png'));
    else if (weather == "Clouds")
      return Image(image: AssetImage('assets/weather/broken_clouds_night.png'));
  } else {
    if (weather == "Thunderstorm")
      return Image(image: AssetImage('assets/weather/thunderstorm.png'));
    else if (weather == "Drizzle")
      return Image(image: AssetImage('assets/weather/shower_rain.png'));
    else if (weather == "Rain")
      return Image(image: AssetImage('assets/weather/rain.png'));
    else if (weather == "Snow")
      return Image(image: AssetImage('assets/weather/snow.png'));
    else if (weather == "Atmosphere")
      return Image(image: AssetImage('assets/weather/mist.png'));
    else if (weather == "Clear")
      return Image(image: AssetImage('assets/weather/clear.png'));
    else if (weather == "Clouds")
      return Image(image: AssetImage('assets/weather/broken_clouds.png'));
  }
  return Image(image: AssetImage('assets/weather/scattered_clouds.png'));
}

String weatherLocalized(String weatherEnglish) {
  if (weatherEnglish == "Thunderstorm")
    return _language.thunderstorm;
  else if (weatherEnglish == "Drizzle")
    return _language.drizzle;
  else if (weatherEnglish == "Rain")
    return _language.rain;
  else if (weatherEnglish == "Snow")
    return _language.snow;
  else if (weatherEnglish == "Atmosphere")
    return _language.mist;
  else if (weatherEnglish == "Clouds")
    return _language.clouds;
  return _language.clear;
}

String indexToDateString(int index) {
  if (index == 0) 
    return _language.night;
  else if (index == 1)
    return _language.morning;
  else if (index == 3)
    return _language.evening;
  return _language.day;
}