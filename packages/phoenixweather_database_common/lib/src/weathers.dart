part of '../phoenixweather_database_common.dart';

abstract class IWeathers {
  Map<ILatLonApiModel, DateWeathers> byLatLonFrom;
  Map<String, dynamic> toJson();
   void fromJson(Map<String, dynamic> json);
}

class Weathers implements IWeathers {
  Map<ILatLonApiModel, DateWeathers> byLatLonFrom= {};
  @override
  Map<String, dynamic> toJson() => {
    'models': byLatLonFrom.keys.toList(),
    'datas': byLatLonFrom.values.toList()
  };
  @override
  void fromJson(Map<String, dynamic> json) {
    List<ILatLonApiModel> models= List
      .from(json['models']
      .map((model) => DefaultLatLonApiModel.fromJson(model))
      .toList());

    List<DateWeathers> datas= List
      .from(json['datas']
      .map((data) => DateWeathers.fromJson(data))
      .toList());

    byLatLonFrom= {};
    for(int index=0; index< models.length; index++) {
      byLatLonFrom[models[index]]= datas[index];
    }
  }
}

class DateWeathers {
  Map<int, CurrentData> dataByDate= {};
  Map<String, dynamic> toJson() => {
    'dates': dataByDate.keys.toList(),
    'datas': dataByDate.values.toList()
  };
  DateWeathers(CurrentData firstData) {
    dataByDate[firstData.dt]= firstData;
  }
  DateWeathers.fromJson(Map<String, dynamic> json) {
    List<int> dates= List
      .from(json['dates']
      .map((date) => date.toInt())
      .toList());

    List<CurrentData> datas= List
      .from(json['datas']
      .map((data) => CurrentData.fromJson(data))
      .toList());

    dataByDate= {};
    for(int index=0; index< dates.length; index++) {
      dataByDate[dates[index]]= datas[index];
    }
  }
}