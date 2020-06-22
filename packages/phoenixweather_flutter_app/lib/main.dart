import 'package:flutter/material.dart';
import 'package:phoenixweather_database_common/phoenixweather_database_common.dart';

import 'package:phoenixweather_flutter_app/constants.dart';
import 'package:phoenixweather_flutter_app/routes.dart';
import 'package:phoenixweather_flutter_app/bloc/loading_bloc.dart';
import 'package:phoenixweather_flutter_app/screens/error.dart';
import 'package:phoenixweather_flutter_app/screens/loading.dart';


void main() {
  runApp(PhoenixWeatherApp());
}

class PhoenixWeatherApp extends StatefulWidget {
  PhoenixWeatherApp({Key key}) : super(key: key);

  @override
  _PhoenixWeatherAppState createState() => _PhoenixWeatherAppState();
}

class _PhoenixWeatherAppState extends State<PhoenixWeatherApp> {
  final loadingBloc= LoadingBloc();
  final runtimeDatabase= RuntimeDatabase();  

  @override
  void initState() {
    super.initState();
    loadingFiles(
      bloc: loadingBloc,
      database:  runtimeDatabase
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:[
        BlocProvider<SearchBloc>(
          create: (BuildContext context) => SearchBloc(),
        ),
        BlocProvider<ShowBloc>(
          create: (BuildContext context) => ShowBloc(),
        ),
      ],
      child: MultiProvider(
        providers: [
          Provider<RuntimeDatabase>(create: (database) => runtimeDatabase),
          Provider<IDefaultTheme>(create: (theme) => IndigoOrangeTheme()),
          Provider<ILanguageSetting>(create: (language) => systemLanguage),
        ],
        child: BlocBuilder(
          bloc: loadingBloc,
          builder: (BuildContext context, LoadingState state) {
            if (state is LoadingInitial)
              return _MaterialLoading();
            if (state is LoadingError)
              return _MaterialError();
            if (state is LoadingSuccess)
              return _MaterialApp();
          },
        ),
      ),
    );
  }
}

class _MaterialApp extends StatelessWidget {
  const _MaterialApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    MaterialApp(
        title: 'ExampleApp',
        theme: lightThemeData(context.watch<IDefaultTheme>()),
        initialRoute: '/home',
        routes: routes,
    );
}

class _MaterialError extends StatelessWidget {
  const _MaterialError({Key key}) : super(key: key);

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

class _MaterialLoading extends StatelessWidget {
  const _MaterialLoading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    MaterialApp(
        title: 'ExampleApp',
        theme: lightThemeData(context.watch<IDefaultTheme>()),
        home: PhoenixWeatherLoadingScreen(),
    );
}