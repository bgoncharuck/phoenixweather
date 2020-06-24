import 'dart:convert';

import 'package:phoenixweather_database_common/phoenixweather_database_common.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoadLocationsFromFirebase implements AsyncRuntimeDatabaseVisitor {
  @override
  Future<bool> visit(RuntimeDatabase database) async {
    await Firestore.instance
      .collection('locations')
      .document('0PIFW0DUCaCyEV4G4J32')
      .get()
      .then((DocumentSnapshot ds) {
        database.locations.fromJson(ds.data);
    });
    // @DEBUG
    // print(
    //   json.encode(database.toNetworkJson())
    // );
  }
}