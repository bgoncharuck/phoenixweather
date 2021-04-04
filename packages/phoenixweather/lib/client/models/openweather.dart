import 'package:meta/meta.dart';

import 'latlonapi.dart';

class OpenWeatherModel {
  LatLonApiModel location;
  int timeZoneOffset;
  int dt;

  /// will be fully copied from OpenWeather response.results> hourly:, daily:
  List<OpenWeatherHour> hourly;
  List<OpenWeatherDay> daily;

  OpenWeatherModel(
      {@required this.location,
      @required this.timeZoneOffset,
      @required this.dt,
      @required this.hourly,
      @required this.daily});

  OpenWeatherModel.fromJson(dynamic json, {LatLonApiModel latlonmodel})
      : location = (latlonmodel == null)
            ? DefaultLatLonApiModel.fromJson(json['location'])
            : latlonmodel,
        timeZoneOffset = json['timezone_offset'].toInt(),
        dt = (json['dt'] != null)
            ? json['dt'].toInt()
            : (json['current'])['dt'].toInt(),
        hourly = List.from(json['hourly']
            .map((json_tag_hourly) => OpenWeatherHour.fromJson(json_tag_hourly))
            .toList()),
        daily = List.from(json['daily']
            .map((json_tag_daily) => OpenWeatherDay.fromJson(json_tag_daily))
            .toList());

  Map<String, dynamic> toJson() => {
        'location': location,
        'timezone_offset': timeZoneOffset,
        'dt': dt,
        'hourly': hourly,
        'daily': daily
      };
}

class OpenWeatherHour {
  int dt;
  double temp;
  double feels_like;
  int pressure;
  int humidity;
  double dew_point;
  int clouds;
  double wind_speed;
  int wind_deg;
  List<OWWeather> weather = [];
  OWRain rain;

  OpenWeatherHour({
    @required this.dt,
    @required this.temp,
    @required this.feels_like,
    @required this.pressure,
    @required this.humidity,
    @required this.dew_point,
    @required this.clouds,
    @required this.wind_speed,
    @required this.wind_deg,
    @required OWWeather weather,
    @required this.rain,
  }) {
    this.weather.add(weather);
  }

  OpenWeatherHour.fromJson(dynamic json)
      : dt = json['dt'].toInt(),
        temp = json['temp'].toDouble(),
        feels_like = json['feels_like'].toDouble(),
        pressure = json['pressure'].toInt(),
        humidity = json['humidity'].toInt(),
        dew_point = json['dew_point'].toDouble(),
        clouds = json['clouds'].toInt(),
        rain = (json['rain'] == null)
            ? OWRain(oneh: 0.0)
            : OWRain.fromJson(json['rain']),
        wind_speed = json['wind_speed'].toDouble(),
        wind_deg = json['wind_deg'].toInt() {
    this.weather.add(OWWeather.fromJson((json['weather'])[0]));
  }

  Map<String, dynamic> toJson() => {
        'dt': dt,
        'temp': temp,
        'feels_like': feels_like,
        'pressure': pressure,
        'humidity': humidity,
        'dew_point': dew_point,
        'clouds': clouds,
        'wind_speed': wind_speed,
        'wind_deg': wind_deg,
        'weather': weather,
        'rain': rain
      };
}

class OpenWeatherDay {
  int dt;
  int sunrise;
  int sunset;
  OWDayTemperature temp;
  OWDayFeelsLike feels_like;
  int pressure;
  int humidity;
  double dew_point;
  double wind_speed;
  int wind_deg;
  List<OWWeather> weather = [];
  int clouds;
  double rain;
  double uvi;

  OpenWeatherDay(
      {@required this.dt,
      @required this.sunrise,
      @required this.sunset,
      @required this.temp,
      @required this.feels_like,
      @required this.pressure,
      @required this.humidity,
      @required this.dew_point,
      @required this.wind_speed,
      @required this.wind_deg,
      @required OWWeather weather,
      @required this.clouds,
      @required this.rain,
      @required this.uvi}) {
    this.weather.add(weather);
  }

  OpenWeatherDay.fromJson(dynamic json)
      : dt = json['dt'].toInt(),
        sunrise = json['sunrise'].toInt(),
        sunset = json['sunset'].toInt(),
        temp = OWDayTemperature.fromJson(json['temp']),
        feels_like = OWDayFeelsLike.fromJson(json['feels_like']),
        pressure = json['pressure'].toInt(),
        humidity = json['humidity'].toInt(),
        dew_point = json['dew_point'].toDouble(),
        wind_speed = json['wind_speed'].toDouble(),
        wind_deg = json['wind_deg'].toInt(),
        clouds = json['clouds'].toInt(),
        rain = (json['rain'] == null) ? 0.0 : json['rain'].toDouble(),
        uvi = json['uvi'].toDouble() {
    this.weather.add(OWWeather.fromJson((json['weather'])[0]));
  }

  Map<String, dynamic> toJson() => {
        'dt': dt,
        'sunrise': sunrise,
        'sunset': sunset,
        'temp': temp,
        'feels_like': feels_like,
        'pressure': pressure,
        'humidity': humidity,
        'dew_point': dew_point,
        'wind_speed': wind_speed,
        'wind_deg': wind_deg,
        'weather': weather,
        'clouds': clouds,
        'uvi': uvi
      };
}

class OWDayTemperature {
  double day;
  double min;
  double max;
  double night;
  double eve;
  double morn;

  OWDayTemperature(
      {@required this.day,
      @required this.min,
      @required this.max,
      @required this.night,
      @required this.eve,
      @required this.morn});

  OWDayTemperature.fromJson(dynamic json)
      : day = json['day'].toDouble(),
        min = json['min'].toDouble(),
        max = json['max'].toDouble(),
        night = json['night'].toDouble(),
        eve = json['eve'].toDouble(),
        morn = json['morn'].toDouble();

  Map<String, dynamic> toJson() => {
        'day': day,
        'min': min,
        'max': max,
        'night': night,
        'eve': eve,
        'morn': morn
      };
}

class OWDayFeelsLike {
  double day;
  double night;
  double eve;
  double morn;

  OWDayFeelsLike(
      {@required this.day,
      @required this.night,
      @required this.eve,
      @required this.morn});

  OWDayFeelsLike.fromJson(dynamic json)
      : day = json['day'].toDouble(),
        night = json['night'].toDouble(),
        eve = json['eve'].toDouble(),
        morn = json['morn'].toDouble();

  Map<String, dynamic> toJson() =>
      {'day': day, 'night': night, 'eve': eve, 'morn': morn};
}

class OWWeather {
  int id;
  String main;
  String description;
  String icon;

  OWWeather(
      {@required this.id,
      @required this.main,
      @required this.description,
      @required this.icon});

  OWWeather.fromJson(dynamic json)
      : id = json['id'].toInt(),
        main = json['main'].toString(),
        description = json['description'].toString(),
        icon = json['icon'].toString();

  Map<String, dynamic> toJson() =>
      {'id': id, 'main': main, 'description': description, 'icon': icon};
}

class OWRain {
  double oneh;

  OWRain({@required this.oneh});

  OWRain.fromJson(dynamic json) : oneh = json['1h'].toDouble();

  Map<String, dynamic> toJson() => {'1h': oneh};
}
