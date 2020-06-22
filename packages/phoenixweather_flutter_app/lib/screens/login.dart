import 'package:flutter/material.dart';
import 'package:phoenixweather_flutter_app/constants.dart';
import 'package:phoenixweather_flutter_app/components/login_facebook.dart';
import 'package:phoenixweather_flutter_app/components/login_google.dart';

class PhoenixWeatherLoginScreen extends StatelessWidget {
  const PhoenixWeatherLoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme= context.watch<IDefaultTheme>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    LoginFacebookButton(key: UniqueKey()),
                    Text(
                      "Facebook",
                      style: TextStyle(
                        fontSize: 22
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    LoginGoogleButton(key: UniqueKey()),
                    Text(
                      "Google",
                      style: TextStyle(
                        fontSize: 22
                      ),
                    ),
                  ],
                ),
              ],
            )


          ],
        ),
      ),
    );
  }
}