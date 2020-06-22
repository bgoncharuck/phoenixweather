# Phoenixweather Runtime Database Common Dart Package

### > What is it all about?
- It is about save some data to not search it twice. 
- Also transfer it between storage and server.

```
import 'package:phoenixweather_database_common/phoenixweather_database_common.dart';
// returns singleton
final runtimeDatabase= RuntimeDatabase();

runtimeDatabase.cleanOldWeather();
runtimeDatabase.addLocation(location);

await storage.write(
    data: json.encode(
            runtimeDatabase
            .toStorageJson()),

    asFile: "phoenixweather_local.json"
);
```

### > Is it really helps make app faster?
- Nope.
- But it helps to save/load/transfer data correctly.
- Also, now location models can be shared between all users. And **this** *can* make app faster. If two users searched one location and it was synced between devices.

### Methods
-  `ILatLonApiModel` searchLocation(`String` location)  
-  `bool` addLocation(`ILatLonApiModel `locationModel)
-  `CurrentData` searchWeather({@required `String `location, @required `int` date}
-   `bool `addWeather({@required `ILatLonApiModel `location, @required `CurrentData` data})
- `Future<bool>` cleanOldWeather() 
### JSON
- to/fromNetworkJson => {"locations": `Locations`}
- to/fromStorageJson => {"user": `User` or `null`, "weathers": `Weathers`}
### Models
#### Locations
- `Map<String, ILatLonApiModel> `byName= {};
- `Map<String, dynamic>` toJson() ;
- `void `fromJson(`Map<String, dynamic>` json);
#### Weathers
- `Map<ILatLonApiModel, DateWeathers>` byLatLonFrom;
- `Map<String, dynamic>` toJson();
- `void` fromJson(`Map<String, dynamic>` json);
#### DateWeathers
- `Map<int, CurrentData>` dataByDate;
- `Map<String, dynamic>` toJson()
- DateWeathers.fromJson(`Map<String, dynamic>` json)
#### User
- `String get `id;
- `String` home;
- `int` lastUpdate;
- User.fromJson(`dynamic` json)
- `Map<String, dynamic>` toJson()