import 'package:flutter/material.dart';
import 'package:phoenixweather_flutter_app/constants.dart';
import 'weather_item_widgets.dart';
import 'package:phoenixweather_flutter_app/theme/language.dart';
final ILanguageSetting _language= systemLanguage;

class ShowItemFull extends StatelessWidget {

  final int day;
  final WeatherModel item;
  bool isNight= false;
  String time;

  ShowItemFull({
    @required this.item, 
    @required this.day, 
    @required String daytime
  }) {

    if (day < 3) {

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
    final ShowBloc showBloc=  context.bloc<ShowBloc>();
    final language= context.watch<ILanguageSetting>();
    final IDefaultTheme theme= context.watch<IDefaultTheme>();

    return Container(

      color: (isNight) ?
      theme.weatherNightBackground :
      theme.weatherDayBackground,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[

          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton.icon(
                  onPressed: () {
                    // return event
                    showBloc.add(
                      ShowDayEvent(
                        data: showBloc.data, 
                        day: day,
                        innerEvent: true
                      ),
                    );
                  }, 

                  icon: Icon(
                    Icons.keyboard_return,
                    color: (isNight) ?
                      theme.weatherNightText :
                      theme.weatherDayText,
                    size: 26,
                  ), 
                  label: SizedBox(),
                ),

                // time of day
                Padding(
                  padding: const EdgeInsets.only(right: 32.0),
                  child: Text(
                    time,
                    style: TextStyle(
                      fontSize: 26,
                      color: (isNight) ?
                        theme.weatherNightText :
                        theme.weatherDayText,
                      ),
                  ),
                ),
              ],
            ),
          ),

          // weather
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                weatherToIcon(
                  weather: item.weather_name,
                  isNight: isNight
                ),
                Text(
                  "${weatherLocalized(item.weather_name)}",
                  style: TextStyle(
                  fontSize: 28,
                  color: (isNight) ?
                    theme.weatherNightText :
                    theme.weatherDayText,
                  ),
                ),
              ],
            ),
          ),


          // temperature
          Flexible(
            child: Text(
              "${(item.temperature-273.15).toStringAsFixed(2)} °C, ${language.feelsLike} ${(item.feels_like-273.15).toStringAsFixed(2)} °C",
              style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: (isNight) ?
              theme.weatherNightText :
              theme.weatherDayText,
              ),
            ),
          ),


          // pressure
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Flexible(
                  child: Icon(
                    Icons.arrow_downward,
                    color: (isNight) ?
                    theme.weatherNightText :
                    theme.weatherDayText,
                    size: 48
                  ),
                ),
                Flexible(
                  child: Text(
                    "${language.pressure} :",
                    style: TextStyle(
                    fontSize: 18,
                    color: (isNight) ?
                      theme.weatherNightText :
                      theme.weatherDayText,
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    "${item.pressure}",
                    style: TextStyle(
                    fontSize: 18,
                    color: (isNight) ?
                      theme.weatherNightText :
                      theme.weatherDayText,
                    ),
                  ),
                ),
              ],
            ),
          ),


          // humidity
           Flexible(
             child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Flexible(child: Image(image: AssetImage('assets/weather/humidity.png'))),
                Flexible(
                  child: Text(
                    "${language.humidity} :",
                    style: TextStyle(
                    fontSize: 18,
                    color: (isNight) ?
                      theme.weatherNightText :
                      theme.weatherDayText,
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    "${item.humidity}",
                    style: TextStyle(
                    fontSize: 18,
                    color: (isNight) ?
                      theme.weatherNightText :
                      theme.weatherDayText,
                    ),
                  ),
                ),
              ],
          ),
           ),

          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Flexible(child: Image(image: AssetImage('assets/weather/wind.png'))),
                Flexible(
                  child: Text(
                    "${language.windSpeed} :",
                    style: TextStyle(
                    fontSize: 18,
                    color: (isNight) ?
                      theme.weatherNightText :
                      theme.weatherDayText,
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    "${item.wind_speed}",
                    style: TextStyle(
                    fontSize: 18,
                    color: (isNight) ?
                      theme.weatherNightText :
                      theme.weatherDayText,
                    ),
                  ),
                ),
              ],
            ),
          ),


          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Flexible(child: Image(image: AssetImage('assets/weather/shower_rain.png'))),
                Flexible(
                  child: Text(
                    "${language.probabilityPrecipitation} :",
                    style: TextStyle(
                    fontSize: 18,
                    color: (isNight) ?
                      theme.weatherNightText :
                      theme.weatherDayText,
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    "${item.rain}",
                    style: TextStyle(
                    fontSize: 18,
                    color: (isNight) ?
                      theme.weatherNightText :
                      theme.weatherDayText,
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}