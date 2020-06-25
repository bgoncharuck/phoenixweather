import 'package:flutter/material.dart';
import 'package:phoenixweather_flutter_app/constants.dart';
import 'weather_item_widgets.dart';
import 'package:phoenixweather_flutter_app/theme/language.dart';
final ILanguageSetting _language= systemLanguage;

class ShowItemSmall extends StatelessWidget {

  bool isNight= false;
  String time;
  final WeatherModel item;

  ShowItemSmall({
    @required this.item, 
    @required int day, 
    @required String daytime
  }) {
    // not very DRY, but here we go again,
    // but, hey, it fast.

    if (day < 3) {

      // fast, except this convertation here..
      int hour= (DateTime.fromMillisecondsSinceEpoch(item.dt*1000)).hour;
      time= " $hour:00 ";

      if (hour < 6 || hour > 18)
        isNight= true;

    }

    else {

      time= daytime;

      if (daytime ==  _language.night || daytime == _language.evening)
        isNight= true;

    }
  }

  @override
  Widget build(BuildContext context) {
    final IDefaultTheme theme= context.watch<IDefaultTheme>();

    return Container(

      color: (isNight) ?
      theme.weatherNightBackground :
      theme.weatherDayBackground,

      child: SizedBox(
        height: 96,

        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  SizedBox(
                    width: 16,
                  ),

                  // Time
                  Expanded(
                    child: Text(
                      time,
                      style: TextStyle(
                        fontSize: 18,
                        color: (isNight) ?
                        theme.weatherNightText :
                        theme.weatherDayText,
                      ),
                    ),
                  ),

                  // weather
                  weatherToIcon(
                    weather: item.weather_name,
                    isNight: isNight
                  ),
                  Expanded(
                    child: Text(
                      "${weatherLocalized(item.weather_name)}",
                      style: TextStyle(
                        fontSize: 20,
                        color: (isNight) ?
                        theme.weatherNightText :
                        theme.weatherDayText,
                      ),
                    ),
                  ),

                  // temperature
                  Expanded(
                    child: Text(
                      "${(item.temperature-273.15).toStringAsFixed(2)} °C",
                      style: TextStyle(
                        fontSize: 20,
                        color: (isNight) ?
                        theme.weatherNightText :
                        theme.weatherDayText,
                      ),
                    ),
                  ),

                  SizedBox(
                    width: 8,
                  ),
                ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}