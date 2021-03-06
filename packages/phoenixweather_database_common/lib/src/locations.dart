part of '../phoenixweather_database_common.dart';

abstract class ILocations {
  Map<String, ILatLonApiModel> byName= {};
  Map<String, dynamic> toJson() ;
  void fromJson(Map<String, dynamic> json);
}

class Locations implements ILocations {
  Map<String, ILatLonApiModel> byName= {};
  @override
  Map<String, dynamic> toJson() => {
    'names': byName.keys.toList(),
    'models': byName.values.toList()
  };
  @override
  void fromJson(Map<String, dynamic> json) {
    List<String> names= List
      .from(json['names']
      .map((name) => name.toString())
      .toList());

    List<ILatLonApiModel> models= List
      .from(json['models']
      .map((model) => DefaultLatLonApiModel.fromJson(model))
      .toList());

    byName= {};
    for(int index=0; index< names.length; index++) {
      byName[names[index]]= models[index];
    }
  }
}
