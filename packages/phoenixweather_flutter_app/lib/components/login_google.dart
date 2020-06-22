import 'package:flutter/material.dart';
import 'package:phoenixweather_flutter_app/constants.dart';

class LoginGoogleButton extends StatefulWidget {
  LoginGoogleButton({Key key}) : super(key: key);

  @override
  _LoginGoogleButtonState createState() => _LoginGoogleButtonState();
}

class _LoginGoogleButtonState extends State<LoginGoogleButton> {
  @override
  Widget build(BuildContext context) {
    final theme= context.watch<IDefaultTheme>();
    return  Icon(
      Icons.account_circle,
      color: theme.accent,
      size: 64,
    );
  }
}