import 'package:flutter/material.dart';
import 'package:phoenixweather_common/phoenixweather_common.dart';
import 'package:phoenixweather_flutter_app/constants.dart';
import 'package:phoenixweather_flutter_app/screens/error.dart';
import 'package:phoenixweather_flutter_app/screens/loading.dart';
import 'package:phoenixweather_flutter_app/screens/home/home.dart';
import 'package:phoenixweather_flutter_app/screens/login/login.dart';
import 'package:phoenixweather_flutter_app/services/writelocalfiles.dart';
import 'package:phoenixweather_flutter_app/services/firebase_add.dart';

class AppWorking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    RuntimeDatabase database= context.watch<RuntimeDatabase>();
    SearchBloc searchBloc= context.bloc<SearchBloc>();

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
    // add method to load location models to server
    searchBloc.pushLocationModelToServer= addModelToFireStore;

    return AppBuild();
  }
}

class AppError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final language= context.watch<ILanguageSetting>();
    return MaterialApp(
      title: 'Wrong Permissions',
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
        title: 'Loading Phoenix Weather',
        theme: lightThemeData(context.watch<IDefaultTheme>()),
        home: PhoenixWeatherLoadingScreen(),
    );
}

class AppBuild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Phoenix Weather',
      theme: lightThemeData(context.watch<IDefaultTheme>()),
      initialRoute: '/home',
      routes: routes,
    );
  }
}

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => PhoenixWeatherHome(),
  "/login": (BuildContext context) =>  PhoenixWeatherLoginScreen(),
};