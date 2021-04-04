import 'dart:async';
import 'package:meta/meta.dart';

import 'client.dart';
import '../models/latlonapi.dart';

/* 
this file was git ignored

use your own key here: 
- it must have name privateGoogleApiKey
- it need Google Geocoding feature to be enabled
example:
  const String privateGoogleApiKey = "aKeY";
*/
import '../private/key.dart';

const wrongGoogleApiKeyError = "Wrong Google API Key.";
const wrongLocationName = "Wrong Location Name.";

/// IN: city or location name
/// OUT: model
///
/// Model: LatLonApiModel
abstract class LatLonApiClient {
  GetRequestByApiKey client;
  LatLonApiModel Function(String location) searchInDatabase;
  bool Function(LatLonApiModel locationModel) addToDatabase;

  Future<LatLonApiModel> getByCityName({@required String city});
}

class GoogleGeocoding implements LatLonApiClient {
  /// singleton
  GoogleGeocoding._();
  static GoogleGeocoding _googleGeocoding;
  factory GoogleGeocoding() {
    if (_googleGeocoding == null) _googleGeocoding = GoogleGeocoding._();
    return _googleGeocoding;
  }
  //

  GetRequestByApiKey client = DefaultGetRequestByApiKey(
    apiKey: privateGoogleApiKey,
    baseUrl: "https://maps.googleapis.com/maps/api/geocode/json",
  );
  LatLonApiModel Function(String location) searchInDatabase;
  bool Function(LatLonApiModel locationModel) addToDatabase;

  ErrorLatLonApiModel onError({@required text}) {
    // @DEBUG
    // print("Error: $text");
    return ErrorLatLonApiModel(error: text);
  }

  Future<LatLonApiModel> getByCityName({@required String city}) async {
    /// If location is already saved
    if (searchInDatabase != null) {
      final LatLonApiModel fromDatabase = searchInDatabase(city);
      if (fromDatabase != null) return fromDatabase;
    }

    final results = await client.request(
      terms: "address=$city",
    );

    /// Most errors will be catched here
    final error = results['error_message'] as String;
    if (error != null) {
      if (RegExp(r'This API project is not authorized', caseSensitive: false)
          .hasMatch(error)) return onError(text: wrongGoogleApiKeyError);
      return onError(text: error);
    }

    /// Index errors mean that user gives incorect location name
    /// And google was shocked by it, responding with some messy text
    /// So shocked, that tag 'error_message' was missed.
    Map<String, dynamic> location;
    try {
      location = results['results'][0]['geometry']['location'];
    } catch (indexError) {
      return onError(text: wrongLocationName);
    }

    final locationModel = DefaultLatLonApiModel(
        city: city, lat: location['lat'], lon: location['lng']);
    if (addToDatabase != null) addToDatabase(locationModel);
    return locationModel;
  }
}