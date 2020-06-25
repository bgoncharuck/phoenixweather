import 'package:flutter/material.dart';
import 'package:phoenixweather_flutter_app/constants.dart';

class UpdateButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme= context.watch<IDefaultTheme>();
    final searchBloc= context.bloc<SearchBloc>();
    
    return FlatButton(
      child: Icon(
        Icons.refresh,
          size: 32,
          color: theme.onMainColor
        ),
      // Update
      onPressed: () {
        searchBloc.add(SearchEventUpdate());
      }, 
    );
  }
}