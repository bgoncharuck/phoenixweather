import 'package:meta/meta.dart';
import '../client/client.dart';

part 'models/user.dart';
part 'models/locations.dart';
part 'models/weathers.dart';

abstract class StorageVisitor {
  bool visit(Storage database);
}

abstract class AsyncStorageVisitor {
  Future<bool> visit(Storage database);
}

class MultiStorageVisitor implements StorageVisitor {
  List<StorageVisitor> visitors;
  @override
  bool visit(Storage database) {
    final results = visitors.map((visitor) => visitor.visit(database));
    return results.any((result) => false) ? false : true;
  }
}

class MultiAsyncStorageVisitor implements AsyncStorageVisitor {
  List<AsyncStorageVisitor> visitors;
  @override
  Future<bool> visit(Storage database) async {
    final results =
        await visitors.map((visitor) async => await visitor.visit(database));
    return results.any((result) => false) ? false : true;
  }
}

class Storage {
  /// singleton
  Storage._() {
    user = null;
    locations = Locations();
    weathers = Weathers();
  }
  static Storage _storage;
  factory Storage() {
    if (_storage == null) _storage = Storage._();
    return _storage;
  }

  bool accept(StorageVisitor visitor) => visitor.visit(this);
  Future<bool> acceptAsync(AsyncStorageVisitor visitor) async =>
      await visitor.visit(this);
  Future<bool> acceptAsyncNoWaiting(AsyncStorageVisitor visitor) async =>
      visitor.visit(this);

  /// Must be edited manually outside of base
  /// It exists here for local save/load purpose
  User user;

  ILocations locations;
  IWeathers weathers;

  LatLonApiModel searchLocation(String location) => locations.byName[location];

  bool addLocation(LatLonApiModel locationModel) {
    if (locations.byName.containsKey(locationModel.data)) return true;
    locations.byName[locationModel.data] = locationModel;
    if (locations.byName.containsKey(locationModel.data)) return true;
    return false;
  }

  CurrentData searchWeather({
    @required String location,
    @required int date,
  }) {
    final weatherByLocation = weathers.byLocationFrom[location];
    if (weatherByLocation == null) return null;
    if (date == null) return weatherByLocation.dataByDate.values.last;
    return weatherByLocation.dataByDate[date];
  }

  bool addWeather(
      {@required LatLonApiModel location, @required CurrentData data}) {
    /// if this location already exist, add newer date:data
    if (weathers.byLocationFrom[location.data] != null)
      (weathers.byLocationFrom[location.data]).dataByDate[data.dt] = data;

    /// else create new
    else
      weathers.byLocationFrom[location.data] = DateWeathers(data);
    return true;
  }

  CurrentData anyWeather() {
    if (weathers.byLocationFrom.isEmpty) return null;
    return weathers.byLocationFrom.values
        .elementAt(0)
        .dataByDate
        .values
        .elementAt(0);
  }

  LatLonApiModel anyLocation() {
    if (locations.byName.isEmpty) return null;
    return locations.byName.values.elementAt(0);
  }

  /// cleans all but the newest weather data for every local location:weather
  Future<bool> cleanOldWeather() async {
    try {
      if (weathers.byLocationFrom.values.length > 0) {
        for (var dateWeather in weathers.byLocationFrom.values) {
          if (dateWeather.dataByDate.values.length > 1) {
            int newestDate = dateWeather.dataByDate.values
                .reduce((curr, next) => curr.dt >= next.dt ? curr : next)
                .dt;

            for (var data in dateWeather.dataByDate.values) {
              if (data.dt < newestDate) dateWeather.dataByDate.remove(data.dt);
            }
          }
        }
        return true;
      }
    } catch (nullException) {
      print("Nothing to clean.");
    }

    return false;
  }

  //------------------------------------------------------------------------------------------------------
  /// Network JSON sync only locations between all users, for faster work
  void fromNetworkJson(Map<String, dynamic> json) {
    locations.fromJson(json['locations']);
  }

  Map<String, dynamic> toNetworkJson() => {'locations': locations.toJson()};

  void fromWeatherJson(Map<String, dynamic> json) {
    weathers.fromJson(json['weathers']);
  }

  Map<String, dynamic> toWeatherJson() => {
        'weathers': weathers.toJson(),
      };

  void fromUserJson(Map<String, dynamic> json) {
    user = User.fromJson(json['user']);
  }

  Map<String, dynamic> toUserJson() => {
        'user': user.toJson(),
      };
}
