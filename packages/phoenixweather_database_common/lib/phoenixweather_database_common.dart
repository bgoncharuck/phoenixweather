import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:phoenixweather_common/phoenixweather_common.dart';
import 'package:phoenixweather_bloc_common/phoenixweather_bloc_common.dart';

part 'src/user.dart';
part 'src/locations.dart';
part 'src/weathers.dart';

// Must be edited manually outside of base
// It exists here because for local save/load purpose
User user= null;

ILocations locations= Locations();
IWeathers weathers= Weathers();

Future<ILatLonApiModel> searchLocation(String location) async 
=> locations.byName[location];


Future<bool> addLocation(ILatLonApiModel locationModel) async {
  if(locations.byName.containsKey(locationModel.data)) return true;
  locations.byName[locationModel.data]= locationModel;
  if(locations.byName.containsKey(locationModel.data)) return true;
  return false;
}

Future<CurrentData> searchWeather({
  @required String location,
  @required int date
}) async => (weathers
  .byLatLonFrom[locations.byName[location]]
).dataByDate[date];


Future<bool> addWeather({
  @required ILatLonApiModel location, 
  @required CurrentData data
}) async {
  // if this location already exist, add newer date:data
  if (weathers.byLatLonFrom[location] != null)
    (weathers.byLatLonFrom[location]).dataByDate[data.dt]= data;
  // else create new
  else 
    weathers.byLatLonFrom[location]= DateWeathers(data);
  return true;
}

// @TODO
// cleans all but the newest weather data for every local location:weather
Future<bool> cleanOldWeather() async {

}

//------------------------------------------------------------------------------------------------------
// Network JSON sync only locations between all users, for faster work
void fromNetworkJson(Map<String, dynamic> json) {
  locations.fromJson(json['locations']);
}

Map<String, dynamic> toNetworkJson() => {
  'locations': locations.toJson()
};

// Used to save/load local data
void fromStorageJson(Map<String, dynamic> json) {
  locations.fromJson(json['locations']);
  weathers.fromJson(json['weathers']);
  user= (json['user'] != null) ?
  User.fromJson(json['user']): user;
}

Map<String, dynamic> toStorageJson()  { 
  if (user != null) return {
    'user': user.toJson(),
    'locations': locations.toJson(),
    'weathers': weathers.toJson()
  };
  return {
    'locations': locations.toJson(),
    'weathers': weathers.toJson()
  };
}
  