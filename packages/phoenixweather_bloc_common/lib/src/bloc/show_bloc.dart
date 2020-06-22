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
  CurrentData data;
  ShowBloc({this.data});

  @override
  Stream<ShowState> mapEventToState(
    ShowEvent event,
  ) async* {
    if (event is ShowDayEvent) {
      if (event.innerEvent == false)
        data= event.data;
      yield ShowStateDay(day: event.day, items: event.items);
    }
    else if (event is ShowItemEvent)
      yield ShowStateItem(item: event.item);
  }

  @override
  ShowState get initialState => ShowStateLoading();
}
