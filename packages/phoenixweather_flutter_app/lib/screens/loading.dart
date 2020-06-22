import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:phoenixweather_flutter_app/constants.dart';

class PhoenixWeatherLoadingScreen extends StatelessWidget {
  const PhoenixWeatherLoadingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:  PhoenixWeatherLoading(),
      ),
    );
  }
}

class PhoenixWeatherLoading extends StatelessWidget {
  const PhoenixWeatherLoading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme= context.watch<IDefaultTheme>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SpinKitFoldingCube(
          color: theme.accent,
          size: 128,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Phoenix Weather is loading.",
            style: TextStyle(
              color: theme.mainColor,
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }
}