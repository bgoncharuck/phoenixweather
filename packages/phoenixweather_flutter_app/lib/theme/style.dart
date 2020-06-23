import 'package:flutter/material.dart';

abstract class IDefaultTheme {
  Color background;
  Color onBackground;
  Color mainColor;
  Color onMainColor;
  Color label;
  Color accent;
  Color onAccent;
  Color weatherDayBackground;
  Color weatherNightBackground;
  Color weatherDayText;
  Color weatherNightText;
}

class IndigoOrangeTheme implements IDefaultTheme {
  Color background = Colors.white;
  Color onBackground = Colors.black;
  Color mainColor = Colors.indigo[900];
  Color onMainColor = Colors.white;
  Color label = Colors.grey[500];
  Color accent = Colors.deepOrange;
  Color onAccent = Colors.white;
  Color weatherDayBackground= Colors.white;
  Color weatherNightBackground= Colors.indigo[400] ;
  Color weatherDayText= Colors.indigo[900];
  Color weatherNightText= Colors.white;
}

ThemeData lightThemeData(IDefaultTheme defaultTheme) => ThemeData(
  colorScheme: ColorScheme(
    background: defaultTheme.background,
    onBackground: defaultTheme.onBackground,
    brightness: Brightness.light,
    primary: defaultTheme.mainColor,
    primaryVariant: defaultTheme.mainColor,
    onPrimary: defaultTheme.onMainColor,
    secondary: defaultTheme.accent,
    secondaryVariant: defaultTheme.mainColor,
    onSecondary: defaultTheme.onAccent,
    surface: defaultTheme.background,
    onSurface: defaultTheme.onBackground,
    error: Colors.red,
    onError: Colors.yellow,
  ),
  hintColor: defaultTheme.onBackground,
  cursorColor: defaultTheme.accent,
  focusColor: defaultTheme.accent,
  accentColor: defaultTheme.accent,
  accentColorBrightness: Brightness.dark,
  accentIconTheme: IconThemeData(
    color: defaultTheme.onMainColor,
  ),
  buttonColor: defaultTheme.accent,
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
  ),
  scaffoldBackgroundColor: defaultTheme.background,
  sliderTheme: SliderThemeData(
    thumbShape: RoundSliderThumbShape(
      disabledThumbRadius: 8.0,
      enabledThumbRadius: 8.0,
    ),
    trackHeight: 8.0,
  ),
  inputDecorationTheme: InputDecorationTheme(
    disabledBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[500])),
    enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: defaultTheme.onBackground)),
    focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: defaultTheme.mainColor)),
    errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: defaultTheme.accent)),
    focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: defaultTheme.accent)),
    labelStyle: TextStyle(color: defaultTheme.label),
    focusColor: defaultTheme.accent,
  ),
  appBarTheme: AppBarTheme(
    color: defaultTheme.mainColor,
  ),
);