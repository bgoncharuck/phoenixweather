import 'package:flutter/material.dart';
import 'package:phoenixweather_flutter_app/screens/home.dart';
import 'package:phoenixweather_flutter_app/screens/login.dart';


final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => PhoenixWeatherHome(),
  "/login": (BuildContext context) =>  PhoenixWeatherLoginScreen(),
};