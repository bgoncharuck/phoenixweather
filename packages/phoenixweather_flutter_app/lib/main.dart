import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:phoenixweather_flutter_app/constants.dart';
import 'package:phoenixweather_flutter_app/bloc/loading_bloc.dart';
import 'package:phoenixweather_flutter_app/routes.dart';

void main() => runApp(PhoenixWeatherApp());

class _PhoenixWeatherAppState extends State<PhoenixWeatherApp> {
  final loadingBloc = LoadingBloc(LoadingInitial());
  final runtimeDatabase = RuntimeDatabase();

  @override
  void initState() {
    super.initState();
    syncFiles(bloc: loadingBloc, database: runtimeDatabase);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchBloc>(
          create: (BuildContext context) => SearchBloc(),
        ),
        BlocProvider<ShowBloc>(
          create: (BuildContext context) => ShowBloc(),
        ),
        BlocProvider<LoadingBloc>(
          create: (BuildContext context) => loadingBloc,
        ),
      ],
      child: MultiProvider(
        providers: [
          Provider<RuntimeDatabase>(create: (database) => runtimeDatabase),
          Provider<IDefaultTheme>(create: (theme) => IndigoOrangeTheme()),
          Provider<ILanguageSetting>(create: (language) => systemLanguage),
          Provider<FirebaseAuth>(create: (auth) => FirebaseAuth.instance),
          Provider<GoogleSignIn>(create: (googleSignIn) => GoogleSignIn()),
        ],
        child: BlocBuilder<LoadingBloc, LoadingState>(
          builder: (BuildContext context, LoadingState state) {
            if (state is LoadingError) return AppError();
            if (state is LoadingSuccess) return AppWorking();
            if (state is LoadingUpdate) return AppBuild();

            return AppLoading();
          },
        ),
      ),
    );
  }
}

class PhoenixWeatherApp extends StatefulWidget {
  @override
  _PhoenixWeatherAppState createState() => _PhoenixWeatherAppState();
}
