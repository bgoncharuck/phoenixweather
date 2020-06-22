import 'package:flutter/material.dart';
import 'login_facebook.dart';
import 'login_google.dart';

class PhoenixWeatherLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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