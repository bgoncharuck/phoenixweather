import 'dart:convert';

import 'package:phoenixweather_flutter_app/constants.dart';
import 'package:storage_access/storage_access.dart' as storage;

class SaveLocalFiles implements AsyncRuntimeDatabaseVisitor {
  @override
  Future<bool> visit(RuntimeDatabase database) async {
    bool weatherWasRecordedSuccessfully = await recordWeather(database);
    bool locationsWasRecordedSuccessfully = await recordLocation(database);
    bool userWasRecordedSuccessfully = await recordUser(database);

    if (weatherWasRecordedSuccessfully &&
        locationsWasRecordedSuccessfully &&
        userWasRecordedSuccessfully) return true;
    return false;
  }
}

Future<bool> recordWeather(RuntimeDatabase database) async {
  String weather = json.encode(database.toWeatherJson());
  return await storage.write(
    data: weather,
    asFile: weatherStorageFile,
  );
}

Future<bool> recordLocation(RuntimeDatabase database) async {
  String locations = json.encode(database.toNetworkJson());
  return await storage.write(
    data: locations,
    asFile: locationsStorageFile,
  );
}

Future<bool> recordUser(RuntimeDatabase database) async {
  String user = json.encode(database.toUserJson());
  return await storage.write(
    data: user,
    asFile: userStorageFile,
  );
}
