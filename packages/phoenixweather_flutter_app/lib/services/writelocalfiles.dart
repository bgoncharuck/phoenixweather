import 'dart:convert';

import 'package:phoenixweather_database_common/phoenixweather_database_common.dart';
import 'package:storage_access_flutter/storage_access_flutter.dart' as storage;
import 'package:phoenixweather_flutter_app/constants.dart';

class SaveLocalFiles implements AsyncRuntimeDatabaseVisitor {
  @override
  Future<bool> visit(RuntimeDatabase database) async {

    String weather= json.encode(database.toStorageJson());
    bool weatherWasRecordedSuccessfully= await storage.write(
      data: weather, 
      asFile: weatherStorageFile,
    );

    String locations= json.encode(database.toNetworkJson());
    bool locationsWasRecordedSuccessfully= await storage.write(
      data: locations, 
      asFile: locationsStorageFile,
    );

    if (weatherWasRecordedSuccessfully && locationsWasRecordedSuccessfully)
      return true;
    return false;
  }
}