import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:phoenixweather_flutter_app/services/firebase_user.dart';
import 'package:phoenixweather_flutter_app/services/loadlocalfiles.dart';
import 'package:phoenixweather_flutter_app/services/firebase_load.dart';
import 'package:phoenixweather_database_common/phoenixweather_database_common.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'loading_event.dart';
part 'loading_state.dart';

Future syncFiles(
    {@required RuntimeDatabase database, @required LoadingBloc bloc}) async {
  bool noInternet = await checkIfNoInternetConection();

  // load locations from internet
  if (noInternet == false)
    database.acceptAsyncNoWaiting(LoadLocationsFromFirebase());

  // initial user
  database.user = User(
    id: "local",
    home: null,
    lastUpdate: null,
  );

  // load local files
  await loadFiles(
    database: database,
    noInternet: noInternet,
  );

  if (noInternet == false && database.user.id != "local")
    database.user.home = await firebaseGetHomeById(database.user.id);

  // clean old weather
  await database.cleanOldWeather();

  bloc.add(LoadingSuccessEvent());
}

class LoadingBloc extends Bloc<LoadingEvent, LoadingState> {
  LoadingBloc(LoadingState initialState) : super(initialState);

  @override
  LoadingState get initialState => LoadingInitial();

  @override
  Stream<LoadingState> mapEventToState(
    LoadingEvent event,
  ) async* {
    if (event is LoadingSuccessEvent)
      yield LoadingSuccess();
    else if (event is LoadingErrorEvent)
      yield LoadingError();
    else if (event is LoadingUpdateEvent) yield LoadingUpdate();
  }
}

Future<bool> checkIfNoInternetConection() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return false;
    }
  } catch (_) {}
  return true;
}
