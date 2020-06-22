import 'package:flutter/material.dart';
import 'package:phoenixweather_flutter_app/constants.dart';

import 'search_bar.dart';
import 'update_button.dart';
import 'login_button.dart';
import 'essential.dart';

class PhoenixWeatherHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme= context.watch<IDefaultTheme>();
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.search,
          size: 32,
          color: theme.onMainColor
        ),
        title: SearchBar(key: UniqueKey()),
        actions: <Widget>[
          UpdateButton(key: UniqueKey()),
          LoginButton(key: UniqueKey()),
        ],
      ),
      body: SafeArea(

      // essential app part
       child: Essential(),
       
       ), 
    );
  }
}