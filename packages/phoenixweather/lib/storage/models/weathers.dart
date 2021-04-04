part of '../storage.dart';

abstract class IWeathers {
  Map<String, DateWeathers> byLocationFrom;
  Map<String, dynamic> toJson();
  void fromJson(Map<String, dynamic> json);
}

class Weathers implements IWeathers {
  Map<String, DateWeathers> byLocationFrom = {};
  @override
  Map<String, dynamic> toJson() => {
        'models': byLocationFrom.keys.toList(),
        'datas': byLocationFrom.values.toList()
      };
  @override
  void fromJson(Map<String, dynamic> json) {
    List<String> models =
        List.from(json['models'].map((model) => model.toString()).toList());

    List<DateWeathers> datas = List.from(
        json['datas'].map((data) => DateWeathers.fromJson(data)).toList());

    byLocationFrom = {};
    for (int index = 0; index < models.length; index++) {
      byLocationFrom[models[index]] = datas[index];
    }
  }
}

class DateWeathers {
  Map<int, CurrentData> dataByDate = {};
  Map<String, dynamic> toJson() =>
      {'dates': dataByDate.keys.toList(), 'datas': dataByDate.values.toList()};
  DateWeathers(CurrentData firstData) {
    dataByDate[firstData.dt] = firstData;
  }
  DateWeathers.fromJson(Map<String, dynamic> json) {
    List<int> dates =
        List.from(json['dates'].map((date) => date.toInt()).toList());

    List<CurrentData> datas = List.from(
        json['datas'].map((data) => CurrentData.fromJson(data)).toList());

    dataByDate = {};
    for (int index = 0; index < dates.length; index++) {
      dataByDate[dates[index]] = datas[index];
    }
  }
}
