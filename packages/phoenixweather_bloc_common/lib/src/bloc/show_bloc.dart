import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:phoenixweather_bloc_common/phoenixweather_bloc_common.dart';
import '../models/weather.dart';
import '../models/currentdata.dart';

part 'show_event.dart';
part 'show_state.dart';

class ShowBloc extends Bloc<ShowEvent, ShowState> {
  // days used to store day number of month
  // days[0] used to store chosen day number
  List<int> days = [-1, 0, 0, 0, 0, 0, 0, 0];

  CurrentData data;
  ShowBloc({this.data}) : super(null);

  @override
  Stream<ShowState> mapEventToState(
    ShowEvent event,
  ) async* {
    if (event is ShowDayEvent) {
      if (event.innerEvent == false) data = event.data;
      // store day to highlight it
      days[0] = event.day;
      // store items to show it
      yield ShowStateDay(days: days, items: event.items);
    } else if (event is ShowItemEvent)
      yield ShowStateItem(
        item: event.item,
        day: event.day,
        index: event.index,
      );
  }

  @override
  ShowState get initialState => ShowStateLoading();

  void calculateDaysOfMonth() {
    // today
    days[1] = (DateTime.fromMillisecondsSinceEpoch(data.dt * 1000)).day;
    // tomorrow
    days[2] =
        (DateTime.fromMillisecondsSinceEpoch(data.hourly[30].dt * 1000)).day;
    // other
    days[3] =
        (DateTime.fromMillisecondsSinceEpoch(data.daily[2].day.dt * 1000)).day;
    days[4] =
        (DateTime.fromMillisecondsSinceEpoch(data.daily[3].day.dt * 1000)).day;
    days[5] =
        (DateTime.fromMillisecondsSinceEpoch(data.daily[4].day.dt * 1000)).day;
    days[6] =
        (DateTime.fromMillisecondsSinceEpoch(data.daily[5].day.dt * 1000)).day;
    days[7] =
        (DateTime.fromMillisecondsSinceEpoch(data.daily[6].day.dt * 1000)).day;
  }
}
