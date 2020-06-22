import 'package:flutter/material.dart';
import 'package:phoenixweather_flutter_app/constants.dart';

class LoginFacebookButton extends StatefulWidget {
  LoginFacebookButton({Key key}) : super(key: key);

  @override
  _LoginFacebookButtonState createState() => _LoginFacebookButtonState();
}

class _LoginFacebookButtonState extends State<LoginFacebookButton> {
  @override
  Widget build(BuildContext context) {
    final theme= context.watch<IDefaultTheme>();
    return  Icon(
      Icons.account_circle,
      color: theme.mainColor,
      size: 64,
    );
  }
}