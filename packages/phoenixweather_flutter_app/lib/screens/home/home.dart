import 'package:flutter/material.dart';

import 'search_bar.dart';
import 'update_button.dart';
import 'login_button.dart';
import 'home_body.dart';

class PhoenixWeatherHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
