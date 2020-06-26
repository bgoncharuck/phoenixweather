import 'package:flutter/material.dart';
import 'package:phoenixweather_flutter_app/constants.dart';
import 'package:phoenixweather_flutter_app/screens/error.dart';
import 'package:phoenixweather_flutter_app/screens/loading.dart';
import 'package:phoenixweather_flutter_app/components/weather_item_widgets.dart';
import 'package:phoenixweather_flutter_app/components/show_item_full.dart';
import 'package:phoenixweather_flutter_app/services/firebase_user.dart';
import 'show_items.dart';

class HomeBody extends StatelessWidget {
 @override
  Widget build(BuildContext context) {
    final database= context.watch<RuntimeDatabase>();
    final SearchBloc searchBloc= context.bloc<SearchBloc>();
    final language= context.watch<ILanguageSetting>();

    searchBloc.add(
      SearchEventLocationEdited(
        text: (database.user.home != null) ?
         database.user.home : ""
      ),
    );

    return BlocBuilder(
      bloc: searchBloc,
      builder: (BuildContext context, SearchState locationSearch) {

        if (locationSearch is SearchStateSuccess || locationSearch is SearchStatePrevious) {

          if (locationSearch is SearchStateSuccess && database.user.id != "local") {
            // save current user id:home
            firebaseSetHomeById(
              id: database.user.id, 
              home: database.user.home,
            );
          }

          return PhoenixWeatherShow(data: locationSearch.data);
        }

        else if (locationSearch is SearchStateLoading)
          return PhoenixWeatherLoading();
        else if (locationSearch is SearchStateWrongGoogleCodingApiKey)
          return ErrorMessage(language.errorWrongLocation, "");
        else if (locationSearch is SearchStateEmpty)
          return Center(child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(language.emptyPage),
          ));
        else if (locationSearch is SearchStateNoInternet)
          return Center(child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(language.noInternet),
          ));
        else if (locationSearch is SearchStateError)
          return ErrorMessage(locationSearch.errorText, "");
        
         return ErrorMessage(language.errorWrongLocation, "");
      },
    );
  }
}


class PhoenixWeatherShow extends StatelessWidget {
  final CurrentData data;
  PhoenixWeatherShow({this.data});
  @override
  Widget build(BuildContext context) {
    final ShowBloc showBloc=  context.bloc<ShowBloc>();

    // correct day of month
    showBloc.data= data;
    showBloc.calculateDaysOfMonth();

    showBloc.add(
    ShowDayEvent(
      data: data, 
      day: 1,
      innerEvent: true
      )
    );

    return BlocBuilder(
      bloc: showBloc,
      builder: (BuildContext context, ShowState show) {
        if (show is ShowStateDay)
          return ShowItems(days: show.days, items: show.items);
        if (show is ShowStateItem)
          return ShowItemFull(
            item: show.item, 
            day: show.day, 
            daytime: indexToDateString(show.index),
          );

        return PhoenixWeatherLoading();
      }
    );
  }
}