import 'package:flutter/material.dart';
import 'package:phoenixweather_common/phoenixweather_common.dart';
import 'package:phoenixweather_flutter_app/constants.dart';
import 'package:phoenixweather_flutter_app/screens/error.dart';
import 'package:phoenixweather_flutter_app/screens/loading.dart';
import 'package:phoenixweather_flutter_app/screens/home/home.dart';
import 'package:phoenixweather_flutter_app/screens/login/login.dart';
import 'package:phoenixweather_flutter_app/services/writelocalfiles.dart';

class AppWorking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    RuntimeDatabase database= context.watch<RuntimeDatabase>();
    SearchBloc searchBloc= context.bloc<SearchBloc>();

    // add data from local or network files
    try {
      if (database.user != null && database.user.lastUpdate != null) {
        searchBloc.previousLocation= database.searchLocation(database.user.home);
        searchBloc.previousData= database.searchWeather(
          location: database.user.home, 
          date: database.user.lastUpdate
        );
      }
      else {
        searchBloc.previousLocation= database.anyLocation();
        searchBloc.previousData= database.anyWeather();
      }
    } catch (_) {}

    // add database methods to location client
    ILatLonApiClient locationClient= GoogleGeocoding();
    locationClient.searchInDatabase= database.searchLocation;
    locationClient.addToDatabase= database.addLocation;
    // add location client to search logic
    searchBloc.localLocationClient= locationClient;

    // add database to search logic
    searchBloc.database= database;
    // add visitor to write database to local files
    searchBloc.writeRecords= SaveLocalFiles();

    return  MaterialApp(
      title: 'ExampleApp',
      theme: lightThemeData(context.watch<IDefaultTheme>()),
      initialRoute: '/home',
      routes: routes,
    );
  }
}

class AppError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final language= context.watch<ILanguageSetting>();
    return MaterialApp(
      title: 'ExampleApp',
      theme: lightThemeData(context.watch<IDefaultTheme>()),
      home: ErrorMessageScreen(
        language.errorFilesPermission, 
        "$weatherStorageFile $locationsStorageFile"
      ),
    );
  }
}

class AppLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
    MaterialApp(
        title: 'ExampleApp',
        theme: lightThemeData(context.watch<IDefaultTheme>()),
        home: PhoenixWeatherLoadingScreen(),
    );
}

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => PhoenixWeatherHome(),
  "/login": (BuildContext context) =>  PhoenixWeatherLoginScreen(),
};