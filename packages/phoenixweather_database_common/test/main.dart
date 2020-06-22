import 'dart:convert';

import 'package:phoenixweather_database_common/phoenixweather_database_common.dart';
import 'package:phoenixweather_common/phoenixweather_common.dart';
import 'package:phoenixweather_bloc_common/phoenixweather_bloc_common.dart';

void main() {
  testAll();
}

Future testAll() async {
  final runtimeDatabase= RuntimeDatabase();
  final location= await locationClient.getByCityName(city: "Lviv");
  final weather= CurrentData.fromOW(await weatherClient.getByLocation(location: location));

  runtimeDatabase.addLocation(location);
  runtimeDatabase.addWeather(location: location, data: weather);

  final initJson= runtimeDatabase.toNetworkJson();
  runtimeDatabase.fromNetworkJson(json.decode(json.encode(initJson)));
  final decodedJson= runtimeDatabase.toNetworkJson();
  
  final fromInit=((initJson['locations'])['names'])[0].toString() ;
  final fromDecoded=((decodedJson['locations'])['names'])[0].toString();
  assert(fromInit == fromDecoded, "$fromInit|$fromDecoded");
  print("$fromInit|$fromDecoded");
}