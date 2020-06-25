import 'package:flutter/material.dart';
import 'package:phoenixweather_flutter_app/constants.dart';

class LoginFacebookButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme= context.watch<IDefaultTheme>();
    return  FlatButton(
      child: Column(
        children: [
          Icon(
            Icons.account_circle,
            color: theme.mainColor,
            size: 64,
          ), 
          SizedBox(height: 32),
          Text(
            "Facebook",
            style: TextStyle(
              fontSize: 22
            ),
          ),
        ],
      ),
    onPressed: () {
      
    }
    );
  }
}