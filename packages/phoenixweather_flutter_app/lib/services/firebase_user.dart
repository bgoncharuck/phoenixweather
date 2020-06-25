import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:phoenixweather_flutter_app/constants.dart';
import 'writelocalfiles.dart';

class ChangeUser implements AsyncRuntimeDatabaseVisitor {
  final String id;
  ChangeUser({@required this.id});
  @override
  Future<bool> visit(RuntimeDatabase database) async {
    
    if (database.user.id != "local") {
       // save current user id:home
       await firebaseSetHomeById(
        id: database.user.id, 
        home: database.user.home,
      );
    }


    String home= await firebaseGetHomeById(id);
    print("User home is: $home");

    if (home == null && database.user.home != null) {

      await firebaseSetHomeById(id: id, home: database.user.home);

      database.user= User(
        id: id, 
        home: database.user.home, 
        lastUpdate: database.user.lastUpdate
      );
      
    } else if (home != null) {
      database.user= User(id: id, home: home, lastUpdate: database.user.lastUpdate);
    } else {
      database.user= User(id: id, home: null, lastUpdate: null);
    }

    return await recordUser(database);
  }
}

Future<String> firebaseGetHomeById (String id) async {
  if (await checkInternetConection()) 
  return await Firestore.instance
  .collection('users')
  .document('ol4nj3ULCNsu47dF8tUm')
  .get()
  .then((DocumentSnapshot ds) {
    return ds.data[id].toString();
  });
  return null;
}

Future firebaseSetHomeById ({
  @required String id, 
  @required String home,
}) async {
  if (await checkInternetConection()) 
  await Firestore.instance
  .collection('users')
  .document('ol4nj3ULCNsu47dF8tUm')
  .updateData({
    id:home
  });
}

Future<bool> checkInternetConection() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  } catch (_) {}
  return false;
}