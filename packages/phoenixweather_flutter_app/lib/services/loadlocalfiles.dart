import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:phoenixweather_database_common/phoenixweather_database_common.dart';
import 'package:storage_access_flutter/storage_access_flutter.dart' as storage;
import 'package:phoenixweather_flutter_app/constants.dart';

// old implementation without visitor, but it just works.

Future<bool> loadFiles({
  @required RuntimeDatabase database,
  @required bool noInternet
}) async {
  if (noInternet)
    await loadNetworkJson(database);
  return await loadStorageJson(database);
}


RuntimeDatabase _database;
String _weather;
String _location;


Future<bool> _loadLocalStorageFile ({
  @required RuntimeDatabase database,
  @required String fileName,
  @required bool isNetworkJson,
  @required Future<bool> Function () functionRead,
  @required Future Function () functionWrite,
}) async {

  _database= database;

  await readOrCreate(read: functionRead, write: functionWrite);

  print("PhoenixWeather: Local file $fileName was readed or created");

  if (isNetworkJson)
    if (_location != null ) {
      if (_location != 'init') 
          _database.fromNetworkJson(json.decode(_location));
      return true;
    }
  else 
    if (_weather != null ) {
      if (_weather != 'init') 
          _database.fromStorageJson(json.decode(_weather));
      return true;
    }

  return false;
}

// locations load, if needed (if no internet)
Future<bool> loadNetworkJson(RuntimeDatabase database) async =>
await  _loadLocalStorageFile(
  database: database, 
  fileName: locationsStorageFile, 
  isNetworkJson: true, 
  functionRead: readLocation, 
  functionWrite: createLocation,
);

Future<bool> loadStorageJson(RuntimeDatabase database) async =>
await  _loadLocalStorageFile(
  database: database, 
  fileName: weatherStorageFile, 
  isNetworkJson: false, 
  functionRead: readWeather, 
  functionWrite: createWeather,
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