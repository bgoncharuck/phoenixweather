import 'package:flutter/material.dart';
import 'package:phoenixweather_flutter_app/constants.dart';
import 'package:phoenixweather_flutter_app/components/weather_item_widgets.dart';
import 'package:phoenixweather_flutter_app/components/show_item_small.dart';

class ShowItems extends StatelessWidget {
  final List<WeatherModel> items;
  final List<int> days;

  @override
  Widget build(BuildContext context) {
    final IDefaultTheme theme= context.watch<IDefaultTheme>();
    final ShowBloc showBloc=  context.bloc<ShowBloc>();
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        // days
      SizedBox(
          height: 48,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 7,
            itemBuilder: (BuildContext context, int index) =>
            GestureDetector(
              // switch days
              onTap: () {
                showBloc.add(
                  ShowDayEvent(
                    data: showBloc.data, 
                    day: index+1,
                    innerEvent: true
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  " ${days[index+1]} ",
                  style: TextStyle(
                  // days[0] store a day that needs to be highlighted
                  color: (days[0] == index+1) ?
                  theme.accent: theme.mainColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
                ),
              ),
            ),
          ),
        ),
        Flexible(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: items.length,
            // list by hour or day time
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  showBloc.add(
                    ShowItemEvent(
                      item: items[index],
                      day: days[0],
                      index: index,
                    ),
                  );
                },
                child: ShowItemSmall(
                  item: items[index], 
                  // days[0] store a day that need to be shown 
                  day: days[0],
                  // if not hourly (day > 2), then show night,morn,day,even
                  daytime: indexToDateString(index),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

//--------------------------------------------------------------------------------------------------------------------
  ShowItems({@required this.days, @required this.items});
}

