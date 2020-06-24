import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:phoenixweather_flutter_app/services/permissions.dart';
import 'package:phoenixweather_flutter_app/services/loadlocalfiles.dart';
import 'package:phoenixweather_flutter_app/services/firebase_load.dart';
import 'package:phoenixweather_database_common/phoenixweather_database_common.dart';


import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'loading_event.dart';
part 'loading_state.dart';


Future syncFiles({
  @required RuntimeDatabase database,
  @required LoadingBloc bloc
}) async {
  
    await requestPermissions;
    if (statusOf[Permission.storage].isGranted == false) {
      bloc.add(LoadingErrorEvent());
    } else {    

      bool noInternet= await checkIfNoInternetConection();

      // load locations from internet
      if (noInternet == false)
        database.acceptAsyncNoWaiting(LoadLocationsFromFirebase());

      // load local files
      await loadFiles(
        database: database,
        noInternet: noInternet, 
      );

      // clean old weather
      await database.cleanOldWeather();

      bloc.add(LoadingSuccessEvent());
    }
  }

class LoadingBloc extends Bloc<LoadingEvent, LoadingState> {
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