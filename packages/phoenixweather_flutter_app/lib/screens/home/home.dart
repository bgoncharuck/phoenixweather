import 'package:flutter/material.dart';
import 'package:phoenixweather_flutter_app/constants.dart';

import 'search_bar.dart';
import 'update_button.dart';
import 'login_button.dart';
import 'home_body.dart';

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
        title: SearchBar(),
        actions: <Widget>[
          UpdateButton(),
          LoginButton(key: UniqueKey()),
        ],
      ),
      body: SafeArea(

      // essential app part
       child: HomeBody(),
       
       ), 
    );
  }
}