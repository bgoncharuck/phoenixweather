import 'package:flutter/material.dart';
import 'package:phoenixweather_common/phoenixweather_common.dart';
import 'package:phoenixweather_database_common/phoenixweather_database_common.dart';
import 'package:phoenixweather_flutter_app/constants.dart';

class SearchBar extends StatefulWidget {
  SearchBar({Key key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _textController = TextEditingController();

  RuntimeDatabase _database;
  SearchBloc _searchBloc;
  IDefaultTheme theme;

@override
  void initState() {
    super.initState();
    _database= context.read<RuntimeDatabase>();
    _searchBloc= context.bloc<SearchBloc>();
    theme= context.read<IDefaultTheme>();

    if (_database.user != null && _database.user.home != null) {
      _searchBloc.previousLocation= _database.searchLocation(_database.user.home);
    }

    if (_database.user != null && _database.user.lastUpdate != null && _database.user.home != null) {
      final result= _database.searchWeather(
        location: _database.user.home,
        date: _database.user.lastUpdate
      );

      if (result != null)
      _searchBloc.previousData= result;
    }
  }

 @override
  Widget build(BuildContext context) {

    return TextField(
      controller: _textController,
      autocorrect: false,
      onChanged: (text) {
        _searchBloc.add(
          SearchEventLocationEdited(text: text),
        );
      },
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: (_searchBloc.previousLocation != null) ?
        _searchBloc.previousLocation.data: '',
      ),
      style: TextStyle(
        color: theme.onMainColor,
      ),
    );
  }
}