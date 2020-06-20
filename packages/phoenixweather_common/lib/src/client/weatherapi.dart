import 'dart:async';
import 'package:meta/meta.dart';

import '../client/client.dart';
import '../models/latlonapi.dart';
import '../models/openweather.dart';

import '../private/key.dart';
/* 
this file was git ignored

use your own key here: 
- it must have name privateOpenWeatherApiKey
- it need OpenWeather API to be enabled
example:
  const String privateOpenWeatherApiKey = "aKeY";
*/

abstract class IOpenWeatherAPIClient {

  IGetRequestByApiKey client;

  Future<OpenWeatherModel> getByLocation ({@required ILatLonApiModel location});
  /*
    IN: location model
    OUT: model

    Model:
      ILatLonApiModel location;
      int timeZoneOffset;

      will be fully copied from OpenWeather response.results> hourly:, daily:
      List<OpenWeatherHour> hourly;
      List<OpenWeatherDay> daily;
  */
}

class OpenWeather implements IOpenWeatherAPIClient {

  IGetRequestByApiKey client= DefaultGetRequestByApiKey(
    apiKey: privateOpenWeatherApiKey, 
    baseUrl: "https://api.openweathermap.org/data/2.5/onecall",
    termKey: "appid"
  );

  Future<OpenWeatherModel> getByLocation ({@required ILatLonApiModel location}) async {

    Map<String,dynamic>  results= await client.request(
      terms: "lat=${location.lat}&lon=${location.lon}&exclude=minutely", 
    );

    return OpenWeatherModel.fromJson(
      results,
      latlonmodel: location
    );
  }
}