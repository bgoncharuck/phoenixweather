import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:phoenixweather_common/phoenixweather_common.dart';

Future<void> addModelToFireStore(ILatLonApiModel model) async {
  if (await checkInternetConection()) {

    // check if not added
    await Firestore.instance
      .collection('locations')
      .document('0PIFW0DUCaCyEV4G4J32')
      .get()
      .then((DocumentSnapshot ds) {
        if (ds.data['names'].contains(model.data))
          return;
    });

    Firestore.instance
    .collection('locations')
    .document('0PIFW0DUCaCyEV4G4J32')
    .updateData({
      'models':FieldValue.arrayUnion([{
        'data': model.data,
        'lat': model.lat,
        'lon': model.lon
        }
      ])
    });

    Firestore.instance
    .collection('locations')
    .document('0PIFW0DUCaCyEV4G4J32')
    .updateData({
      'names':FieldValue.arrayUnion(
        [model.data]
      )
    });
  }
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