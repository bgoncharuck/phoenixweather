import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/weather.dart';
import '../models/currentdata.dart';

part 'show_event.dart';
part 'show_state.dart';

class ShowBloc extends Bloc<ShowEvent, ShowState> {

  @override
  Stream<ShowState> mapEventToState(
    ShowEvent event,
  ) async* {
    if (event is ShowDayEvent)
      yield ShowStateDay(day: event.day, items: event.items);
    else if (event is ShowItemEvent)
      yield ShowStateItem(item: event.item);
  }

  @override
  ShowState get initialState => ShowStateLoading();
}
