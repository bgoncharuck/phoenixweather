import 'package:flutter/material.dart';
import 'package:phoenixweather_flutter_app/constants.dart';
import 'package:phoenixweather_flutter_app/screens/error.dart';
import 'package:phoenixweather_flutter_app/screens/loading.dart';

class Essential extends StatelessWidget {
 @override
  Widget build(BuildContext context) {
    ShowBloc showBloc= context.bloc<ShowBloc>();
    SearchBloc searchBloc= context.bloc<SearchBloc>();

    searchBloc.add(
      SearchEventLocationEdited(
        text: (searchBloc.previousLocation != null) ?
        searchBloc.previousLocation.data : ""
      ),
    );
    return BlocBuilder(
      bloc: searchBloc,
      builder: (BuildContext context, SearchState locationSearch) {
        if (locationSearch is SearchStateSuccess || locationSearch is SearchStatePrevious) {
          showBloc.add(
            ShowDayEvent(
              data: locationSearch.data, 
              day: 1
            )
          );

          return PhoenixWeatherShow();
        }
        else if (locationSearch is SearchStateLoading)
          return PhoenixWeatherLoading();
        else if (locationSearch is SearchStateWrongGoogleCodingApiKey)
          return ErrorMessage("No Google Coding API key.", "");
        else if (locationSearch is SearchStateEmpty)
          return Center(child: Text(". . ."));
        else if (locationSearch is SearchStateError)
          return ErrorMessage(locationSearch.errorText, "");
        
         return ErrorMessage("Wrong city or location. No such data record", "");
      },
    );
  }
}


class PhoenixWeatherShow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // IDefaultTheme theme= context.watch<IDefaultTheme>();
    // ILanguageSetting language= context.watch<ILanguageSetting>();
    // RuntimeDatabase database= context.watch<RuntimeDatabase>();
    // ShowBloc showBlo=  context.bloc<ShowBloc>();

    return Center(child: Text("All okay"));
  }
}