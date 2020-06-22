import 'package:flutter/material.dart';
import 'dart:async';

import 'package:phoenixweather_flutter_app/services/permissions.dart';
import 'package:phoenixweather_flutter_app/services/loadlocalfiles.dart';
import 'package:phoenixweather_database_common/phoenixweather_database_common.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'loading_event.dart';
part 'loading_state.dart';


Future loadingFiles({
  @required RuntimeDatabase database,
  @required LoadingBloc bloc
}) async {
  
    await requestPermissions;
    if (statusOf[Permission.storage].isGranted == false) {
      bloc.add(LoadingErrorEvent());
    } else {    
      await loadFiles(database);
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
