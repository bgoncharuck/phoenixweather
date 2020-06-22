import 'package:flutter/material.dart';
import 'package:phoenixweather_flutter_app/constants.dart';

class LoginButton extends StatefulWidget {
  LoginButton({Key key}) : super(key: key);

  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    final theme= context.watch<IDefaultTheme>();
    return FlatButton(
      child: Icon(
        Icons.account_circle,
          size: 32,
          color: theme.onMainColor
      ),
      onPressed: () {
        Navigator.of(context).pushNamed("/login");
      }, 
    );
  }
}