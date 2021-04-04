import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'openweather.dart';

enum DayTime { night, morning, day, evening }

class WeatherModel extends Equatable {
  final int dt;
  final double temperature;
  final double feels_like;
  final String weather_name;
  final int pressure;
  final int humidity;
  final double wind_speed;
  // @TODO
  // wind_direction;
  final double rain;

  WeatherModel(
      {@required this.dt,
      @required this.temperature,
      @required this.feels_like,
      @required this.weather_name,
      @required this.pressure,
      @required this.humidity,
      @required this.wind_speed,
      @required this.rain});

  WeatherModel.fromJson(dynamic json)
      : dt = json['dt'].toInt(),
        temperature = json['temperature'].toDouble(),
        feels_like = json['feels_like'].toDouble(),
        weather_name = json['weather_name'].toString(),
        pressure = json['pressure'].toInt(),
        humidity = json['humidity'].toInt(),
        wind_speed = json['wind_speed'].toDouble(),
        rain = json['rain'].toDouble();

  Map<String, dynamic> toJson() => {
        'dt': dt,
        'temperature': temperature,
        'feels_like': feels_like,
        'weather_name': weather_name,
        'pressure': pressure,
        'humidity': humidity,
        'wind_speed': wind_speed,
        'rain': rain
      };

  WeatherModel.fromOWHour(OpenWeatherHour owh)
      : dt = owh.dt,
        temperature = owh.temp,
        feels_like = owh.feels_like,
        weather_name = owh.weather[0].main,
        pressure = owh.pressure,
        humidity = owh.humidity,
        wind_speed = owh.wind_speed,
        rain = owh.rain.oneh;

  @override
  List<Object> get props => [
        dt,
        temperature,
        feels_like,
        weather_name,
        pressure,
        humidity,
        wind_speed,
        rain
      ];
  @override
  bool get stringify => true;
}

class DailyWeatherModel {
  final WeatherModel night;
  final WeatherModel morning;
  final WeatherModel day;
  final WeatherModel evening;

  DailyWeatherModel({
    @required this.night,
    @required this.morning,
    @required this.day,
    @required this.evening,
  });

  DailyWeatherModel.fromOWDay(OpenWeatherDay owd)
      : night = WeatherModel(
            dt: owd.dt,
            temperature: owd.temp.night,
            feels_like: owd.feels_like.night,
            weather_name: owd.weather[0].main,
            pressure: owd.pressure,
            humidity: owd.humidity,
            wind_speed: owd.wind_speed,
            rain: owd.rain),
        morning = WeatherModel(
            dt: owd.dt,
            temperature: owd.temp.morn,
            feels_like: owd.feels_like.morn,
            weather_name: owd.weather[0].main,
            pressure: owd.pressure,
            humidity: owd.humidity,
            wind_speed: owd.wind_speed,
            rain: owd.rain),
        day = WeatherModel(
            dt: owd.dt,
            temperature: owd.temp.day,
            feels_like: owd.feels_like.day,
            weather_name: owd.weather[0].main,
            pressure: owd.pressure,
            humidity: owd.humidity,
            wind_speed: owd.wind_speed,
            rain: owd.rain),
        evening = WeatherModel(
            dt: owd.dt,
            temperature: owd.temp.eve,
            feels_like: owd.feels_like.eve,
            weather_name: owd.weather[0].main,
            pressure: owd.pressure,
            humidity: owd.humidity,
            wind_speed: owd.wind_speed,
            rain: owd.rain);

  DailyWeatherModel.fromJson(dynamic json)
      : night = WeatherModel.fromJson(json['night']),
        morning = WeatherModel.fromJson(json['morning']),
        day = WeatherModel.fromJson(json['day']),
        evening = WeatherModel.fromJson(json['evening']);

  Map<String, dynamic> toJson() =>
      {'night': night, 'morning': morning, 'day': day, 'evening': evening};
}
