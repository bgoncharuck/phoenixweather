import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:storage_access_flutter/storage_access_flutter.dart' as storage;
import 'package:phoenixweather_flutter_app/constants.dart';

// I wrote it before using visitor, but it just works.

Future<bool> loadFiles({
  @required RuntimeDatabase database,
  @required bool noInternet
}) async {
  if (noInternet)
    await loadNetworkJson(database);
  await loadUserJson(database);
  return await loadWeatherJson(database);
}


RuntimeDatabase _database;
String _weather;
String _location;
String _user;


Future<bool> _loadLocalStorageFile ({
  @required RuntimeDatabase database,
  @required String fileName,
  @required String jsonType,
  @required Future<bool> Function () functionRead,
  @required Future Function () functionWrite,
}) async {

  _database= database;

  await readOrCreate(read: functionRead, write: functionWrite);

  print("PhoenixWeather: Local file $fileName was readed or created");

  if (jsonType == "network") {
    if (_location != null && _location != 'init') 
      _database.fromNetworkJson(json.decode(_location));
    return true;
  }
  else if (jsonType == "weather") {
    if (_weather != null && _weather != 'init') 
      _database.fromWeatherJson(json.decode(_weather));
    return true;
  }
  else if (jsonType == "user") {
    if (_user != null && _user != 'init') 
        _database.fromUserJson(json.decode(_user));
    print("User is ${(_database.user).id}");
    return true;
  }
    
  return false;
}

// locations load, if needed (if no internet)
Future<bool> loadNetworkJson(RuntimeDatabase database) async =>
await  _loadLocalStorageFile(
  database: database, 
  fileName: locationsStorageFile, 
  jsonType: "network", 
  functionRead: readLocation, 
  functionWrite: createLocation,
);

Future<bool> loadWeatherJson(RuntimeDatabase database) async =>
await  _loadLocalStorageFile(
  database: database, 
  fileName: weatherStorageFile, 
  jsonType: "weather", 
  functionRead: readWeather, 
  functionWrite: createWeather,
);

Future<bool> loadUserJson(RuntimeDatabase database) async =>
await  _loadLocalStorageFile(
  database: database, 
  fileName: userStorageFile, 
  jsonType: "user", 
  functionRead: readLocalUser, 
  functionWrite: createLocalUser,
);

  // load or create local file
Future readOrCreate({
  @required Future<bool> Function () read,
  @required Future Function () write,
}) async {
  bool isNotNull = true;
  try {
    isNotNull = await read();
  } catch (fileNotExistError) {} finally {
    if (!isNotNull) await write();
  }
}

Future<bool> readWeather() async {
  _weather= await storage.read(fromFile: weatherStorageFile);
  return (_weather == null) ? false : true;
}

Future createWeather() async {
  await storage.write(
    data: 'init',
    asFile: weatherStorageFile
  );
}

Future<bool> readLocation() async {
  _location= await storage.read(fromFile: locationsStorageFile);
  return (_location == null) ? false : true;
}

Future createLocation() async {
  await storage.write(
    data: 'init',
    asFile: locationsStorageFile
  );
}

Future<bool> readLocalUser() async {
  _user= await storage.read(fromFile: userStorageFile);
  return (_user == null) ? false : true;
}

Future createLocalUser() async {
  await storage.write(
    data: 'init',
    asFile: userStorageFile
  );
}