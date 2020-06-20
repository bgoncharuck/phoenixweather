import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class ILatLonApiModel extends Equatable  {
  String get data;
  double get lat;
  double get lon;

  ILatLonApiModel.fromJson (dynamic json);
  Map<String, dynamic> toJson();
}

@immutable
class DefaultLatLonApiModel implements ILatLonApiModel {
  final String data;
  final double lat;
  final double lon;

  const DefaultLatLonApiModel ({
    @required city,
    @required this.lat, 
    @required this.lon}
  ) : this.data= city;

  DefaultLatLonApiModel.fromJson (dynamic json) 
      : data = json['data'] as String,
        lat = json['lat'] as double,
        lon = json['lon'] as double;

  @override 
  Map<String, dynamic> toJson() => {
    'data': data,
    'lat': lat,
    'lon': lon
  };

  @override
  List<Object> get props => [data, lat, lon];
  @override
  bool get stringify => true;
}

@immutable
class ErrorLatLonApiModel implements ILatLonApiModel {
  final String data;
  final double lat= 0.0;
  final double lon= 0.0;

  const ErrorLatLonApiModel ({
    @required error,
    }
  ): this.data= "Error: $error";

  ErrorLatLonApiModel.fromJson (dynamic json) 
      : data = json['data'] as String;

  @override 
  Map<String, dynamic> toJson() => {
    'data': data,
    'lat': 0.0,
    'lon': 0.0
  };

  @override
  List<Object> get props => [data, lat, lon];
  @override
  bool get stringify => true;
}