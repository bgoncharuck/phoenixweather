import 'package:flutter/material.dart';
import 'package:phoenixweather_flutter_app/constants.dart';

class UpdateButton extends StatefulWidget {
  UpdateButton({Key key}) : super(key: key);

  @override
  _UpdateButtonState createState() => _UpdateButtonState();
}

class _UpdateButtonState extends State<UpdateButton> {
  @override
  Widget build(BuildContext context) {
    final theme= context.watch<IDefaultTheme>();
    return FlatButton(
      child: Icon(
        Icons.refresh,
          size: 32,
          color: theme.onMainColor
        ),
            // Update
      onPressed: () {

      }, 
    );
  }
}