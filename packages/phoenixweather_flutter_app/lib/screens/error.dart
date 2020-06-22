import 'package:flutter/material.dart';
import 'package:phoenixweather_flutter_app/constants.dart';


class ErrorMessageScreen extends StatelessWidget {
  final String description;
  final String details;
  ErrorMessageScreen(this.description, this.details);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ErrorMessage(
          description,
          details
        ),
      ),
    );
  }
}

class ErrorMessage extends StatelessWidget {
  final String description;
  final String details;
  ErrorMessage(this.description, this.details);
  @override
  Widget build(BuildContext context) {
    final language= context.watch<ILanguageSetting>();
    final theme= context.watch<IDefaultTheme>();
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                language.errorLabel,
                style: TextStyle(
                  fontSize: 32,
                  color: theme.accent,
                ),
              ),
              Text(
                description,
                style: TextStyle(fontSize: 22),
              ),
              Text(
                details,
                style: TextStyle(
                  fontSize: 22,
                  color: theme.accent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}