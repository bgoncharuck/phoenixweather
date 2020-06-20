import 'dart:async';
import 'package:meta/meta.dart';
import 'package:phoenixweather_common/phoenixweather_common.dart';

import '../client/client.dart';
import '../models/latlonapi.dart';

import '../private/key.dart';
/* 
this file was git ignored

use your own key here: 
- it must have name privateGoogleApiKey
- it need Google Geocoding feature to be enabled
example:
  const String privateGoogleApiKey = "aKeY";
*/
const wrongGoogleApiKeyError= "Wrong Google API Key.";
const wrongLocationName= "Wrong Location Name.";


abstract class ILatLonApiClient {

  IGetRequestByApiKey client;
  Future<ILatLonApiModel> Function(String location) searchInDatabase;
  Future<bool> Function(ILatLonApiModel locationModel) addToDatabase;

  Future<ILatLonApiModel> getByCityName ({@required String city});
  /*
    IN: city or location name
    OUT: model

    Model:
    ILatLonApiModel {
      error text on error
      String get city;

      0.0 on error
      double get lat;

      0.0 on error
      double get lon;
    }
  */
}

class GoogleGeocoding implements ILatLonApiClient {

  IGetRequestByApiKey client= DefaultGetRequestByApiKey(
    apiKey: privateGoogleApiKey, 
    baseUrl: "https://maps.googleapis.com/maps/api/geocode/json",
  );
  Future<ILatLonApiModel> Function(String location) searchInDatabase= null;
  Future<bool> Function(ILatLonApiModel locationModel) addToDatabase= null;

  ErrorLatLonApiModel onError({@required text}) {
    // @DEBUG
    // print("Error: $text");
    return ErrorLatLonApiModel(error: text);
  }

  Future<ILatLonApiModel> getByCityName ({@required String city}) async {

    // If location is already saved
    if (searchInDatabase != null) {
      final ILatLonApiModel fromDatabase= await searchInDatabase(city);
      if(fromDatabase != null) return fromDatabase;
    }

    final  results= await client.request(
      terms: "address=$city", 
    );

    // Most errors will be catched here
    final error= results['error_message'] as String;
    if (error != null) {
      if (RegExp(r'This API project is not authorized',caseSensitive: false).hasMatch(error)) 
        return onError(text: wrongGoogleApiKeyError);
      return onError(text: error);
    }
    // Index errors mean that user gives incorect location name
    // And google was shocked by it, responding with some messy text
    // So shocked, that tag 'error_message' was missed.
    Map<String,dynamic> location;
    try {
      location = results['results'][0]['geometry']['location'];
    } catch(indexError) {
      return onError(text: wrongLocationName);
    }

    final locationModel= DefaultLatLonApiModel(city: city, lat: location['lat'], lon: location['lng']);
    if (addToDatabase != null) addToDatabase(locationModel);
    return locationModel;
  }
}