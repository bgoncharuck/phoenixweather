import 'package:flutter/material.dart';
import 'login_facebook.dart';
import 'login_google.dart';

class PhoenixWeatherLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(child: LoginFacebookButton()),
                Expanded(child: LoginGoogleButton()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}