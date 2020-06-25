import 'package:flutter/material.dart';
import 'package:phoenixweather_flutter_app/bloc/loading_bloc.dart';
import 'package:phoenixweather_flutter_app/constants.dart';
import 'firebase_user.dart';

  void loginAction({
    @required BuildContext context, 
    @required Future<String> Function(BuildContext context) serviceLogin,
  }) {
    final database= context.read<RuntimeDatabase>();
    final loadingBloc= context.bloc<LoadingBloc>();

    serviceLogin(context)
    .then((String id) async {
      if (id != "local") {
        await database.acceptAsync(ChangeUser(id: id));
        if (database.user.home != null) {
          loadingBloc.add(LoadingUpdateEvent());
        }
      }
    })
    .catchError((e) => print(e.toString()));
  }