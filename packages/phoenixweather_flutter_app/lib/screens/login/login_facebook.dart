import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:phoenixweather_flutter_app/constants.dart';
import 'package:phoenixweather_flutter_app/services/firebase_auth.dart';

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
      loginAction(
        context: context, 
        serviceLogin: FacebookLogin,
      );      
    }
    );
  }
}

Future<String> FacebookLogin(BuildContext context) async {

}