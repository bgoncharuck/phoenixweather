import 'dart:async';
import 'package:meta/meta.dart';

import '../client/client.dart';
import '../models/latlonapi.dart';
import '../models/openweather.dart';

/* 
this file was git ignored

use your own key here: 
- it must have name privateOpenWeatherApiKey
- it need OpenWeather API to be enabled
example:
  const String privateOpenWeatherApiKey = "aKeY";
*/
import '../private/key.dart';

///  IN: location model
///  OUT: model
///
///  Model:
///   - ILatLonApiModel location;
///   - int timeZoneOffset;
///
///    will be fully copied from OpenWeather response.results> hourly:, daily:
///    - List of OpenWeatherHour hourly;
///    - List of OpenWeatherDay daily;
abstract class OpenWeatherAPIClient {
  GetRequestByApiKey client;
  Future<OpenWeatherModel> getByLocation({@required LatLonApiModel location});
}

class OpenWeather implements OpenWeatherAPIClient {
  /// singleton
  OpenWeather._();
  static OpenWeather _openWeather;
  factory OpenWeather() {
    if (_openWeather == null) _openWeather = OpenWeather._();
    return _openWeather;
  }
  //

  GetRequestByApiKey client = DefaultGetRequestByApiKey(
      apiKey: privateOpenWeatherApiKey,
      baseUrl: "https://api.openweathermap.org/data/2.5/onecall",
      termKey: "appid");

  Future<OpenWeatherModel> getByLocation(
      {@required LatLonApiModel location}) async {
    Map<String, dynamic> results = await client.request(
      terms: "lat=${location.lat}&lon=${location.lon}&exclude=minutely",
    );

    return OpenWeatherModel.fromJson(results, latlonmodel: location);
  }
}
