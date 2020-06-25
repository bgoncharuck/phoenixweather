import 'package:meta/meta.dart';
import 'package:phoenixweather_common/phoenixweather_common.dart';
import 'package:phoenixweather_bloc_common/phoenixweather_bloc_common.dart';

part 'src/user.dart';
part 'src/locations.dart';
part 'src/weathers.dart';

abstract class RuntimeDatabaseVisitor {
  bool visit(RuntimeDatabase database);
}
abstract class AsyncRuntimeDatabaseVisitor {
  Future<bool> visit(RuntimeDatabase database);
}

class MultiRuntimeDatabaseVisitor implements RuntimeDatabaseVisitor {
  List<RuntimeDatabaseVisitor> visitors;
  @override
  bool visit(RuntimeDatabase database) {
    final results= visitors.map((visitor) => visitor.visit(database));
    return results.any((result) => false) ? false : true;
  }
}

class MultiAsyncRuntimeDatabaseVisitor implements AsyncRuntimeDatabaseVisitor {
  List<AsyncRuntimeDatabaseVisitor> visitors;
  @override
  Future<bool> visit(RuntimeDatabase database) async {
    final results= await visitors.map((visitor) async => await visitor.visit(database));
    return results.any((result) => false) ? false : true;
  }
}

class RuntimeDatabase {

  // singleton
  // I fear to have two instances of runtime database
  static final RuntimeDatabase _singleton = RuntimeDatabase._internal();
  factory RuntimeDatabase() {
    return _singleton;
  }
  RuntimeDatabase._internal() {
    user= null;
    locations= Locations();
    weathers= Weathers();
  }

  bool accept(RuntimeDatabaseVisitor visitor) => visitor.visit(this);
  Future<bool> acceptAsync(AsyncRuntimeDatabaseVisitor visitor) async => await visitor.visit(this);
  Future<bool> acceptAsyncNoWaiting(AsyncRuntimeDatabaseVisitor visitor) async => visitor.visit(this);

  // Must be edited manually outside of base
  // It exists here for local save/load purpose
  User user;

  ILocations locations;
  IWeathers weathers;

  ILatLonApiModel searchLocation(String location)  
  => locations.byName[location];


  bool addLocation(ILatLonApiModel locationModel) {
    if(locations.byName.containsKey(locationModel.data)) return true;
    locations.byName[locationModel.data]= locationModel;
    if(locations.byName.containsKey(locationModel.data)) return true;
    return false;
  }

  CurrentData searchWeather({
    @required String location,
    @required int date,
  })  {
    
    CurrentData data= null;

    try {
        data=  (weathers
          .byLatLonFrom[locations.byName[location]]
        ).dataByDate[date]; 
    } catch(error) {} 

    return data;
 }

  bool addWeather({
    @required ILatLonApiModel location, 
    @required CurrentData data
  }) {
    // if this location already exist, add newer date:data
    if (weathers.byLatLonFrom[location] != null)
      (weathers.byLatLonFrom[location]).dataByDate[data.dt]= data;
    // else create new
    else 
      weathers.byLatLonFrom[location]= DateWeathers(data);
    return true;
  }

  CurrentData anyWeather() {
    if (weathers.byLatLonFrom.isEmpty) return null;
    return weathers.byLatLonFrom.values.elementAt(0).dataByDate.values.elementAt(0);
  }

  ILatLonApiModel anyLocation() {
    if (locations.byName.isEmpty) return null;
    return locations.byName.values.elementAt(0);
  }

  // cleans all but the newest weather data for every local location:weather
  Future<bool> cleanOldWeather() async {
    try {
      if (weathers.byLatLonFrom.values.length> 0) {
          for (var dateWeather in weathers.byLatLonFrom.values) {
          if (dateWeather.dataByDate.values.length > 1) {

            int newestDate= dateWeather.dataByDate.values.reduce(
              (curr, next) => curr.dt >= next.dt ? curr: next
            ).dt;

            for (var data in dateWeather.dataByDate.values) {
              if (data.dt < newestDate) 
                dateWeather.dataByDate.remove(data.dt);
            }
          }
        }
        return true;
      }
    } catch(nullException) {
      print("Nothing to clean.");
    }

    return false;
  }

  //------------------------------------------------------------------------------------------------------
  // Network JSON sync only locations between all users, for faster work
  void fromNetworkJson(Map<String, dynamic> json) {
    locations.fromJson(json['locations']);
  }

  Map<String, dynamic> toNetworkJson() => {
    'locations': locations.toJson()
  };


  void fromWeatherJson(Map<String, dynamic> json) {
    weathers.fromJson(json['weathers']);
  }

  Map<String, dynamic> toWeatherJson() => { 
    'weathers': weathers.toJson(),
  };

  void fromUserJson(Map<String, dynamic> json) {
    user= User.fromJson(json['user']);
  }

  Map<String, dynamic> toUserJson()  => {
    'user': user.toJson(),
  };

}