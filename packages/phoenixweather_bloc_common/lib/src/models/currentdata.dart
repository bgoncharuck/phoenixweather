import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:phoenixweather_common/src/models/openweather.dart';

import 'weather.dart';

class CurrentData extends Equatable  {
  final String location;
  final int dt;
  final List<WeatherModel> hourly;
  final List<DailyWeatherModel> daily;

  CurrentData({
    @required this.location,
    @required this.dt,
    @required this.hourly,
    @required this.daily
  });

  CurrentData.fromOW(OpenWeatherModel owm) 
  : location= owm.location.data,
    dt= owm.dt,

    hourly= List
      .from(owm.hourly
      .map((hour) => WeatherModel.fromOWHour(hour))
      .toList()
    ),

    daily= List
      .from(owm.daily
      .map((day) => DailyWeatherModel.fromOWDay(day))
      .toList()
    );


  CurrentData.fromJson(dynamic json)
  : dt= json['dt'].toInt(),
    location= json['location'].toString() ,

    hourly=List
      .from(json['hourly']
      .map((json_tag_hourly) => WeatherModel.fromJson(json_tag_hourly))
      .toList()
    ),

    daily= List
      .from(json['daily']
      .map((json_tag_daily) => DailyWeatherModel.fromJson(json_tag_daily))
      .toList()
    );


  Map<String,dynamic> toJson() => {
    'location': location,
    'dt': dt,
    'hourly': hourly,
    'daily': daily
  };

  @override
  List<Object> get props => 
  [location, dt, hourly, daily];
  @override
  bool get stringify => true;
}
