import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:phoenixweather_database_common/phoenixweather_database_common.dart';
import 'package:storage_access_flutter/storage_access_flutter.dart' as storage;
import 'package:phoenixweather_flutter_app/constants.dart';


Future<bool> loadFiles(RuntimeDatabase database) async {
  _database= database;

  await readOrCreate(read: readWeather, write: createWeather);
  await readOrCreate(read: readLocation, write: createLocation);
  print("PhoenixWeather: Local files was readed or created");

  if (_location != null && _weather != null) {
    if (_location != 'init') {
      _database.fromNetworkJson(json.decode(_location));
    }
    if(_weather != 'init') {
      _database.fromStorageJson(json.decode(_weather));
    }
    return true;
  }

  return false;
}

RuntimeDatabase _database;
String _weather;
String _location;


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