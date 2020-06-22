import 'package:flutter/material.dart';
import 'package:phoenixweather_flutter_app/constants.dart';
import 'package:phoenixweather_flutter_app/components/search_bar.dart';
import 'package:phoenixweather_flutter_app/components/update_button.dart';
import 'package:phoenixweather_flutter_app/components/login_button.dart';

class PhoenixWeatherHome extends StatelessWidget {
  const PhoenixWeatherHome({Key key}) : super(key: key);

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

       child: SizedBox(),

       ), 
    );
  }
}