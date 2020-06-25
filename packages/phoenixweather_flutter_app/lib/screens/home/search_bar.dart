import 'package:flutter/material.dart';
import 'package:phoenixweather_database_common/phoenixweather_database_common.dart';
import 'package:phoenixweather_flutter_app/constants.dart';

class SearchBar extends StatefulWidget {
  SearchBar({Key key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  RuntimeDatabase _database;
  SearchBloc _searchBloc;
  IDefaultTheme _theme;
  TextEditingController _textController;

  @override
  void initState() {
    super.initState();

    _database= context.read<RuntimeDatabase>();
    _searchBloc= context.bloc<SearchBloc>();
    _theme= context.read<IDefaultTheme>();

    if (_database.user.home != null) {
      _searchBloc.previousLocation= _database.searchLocation(_database.user.home);
    }

    if (_database.user.lastUpdate != null && _database.user.home != null) {
      final result= _database.searchWeather(
        location: _database.user.home,
        date: _database.user.lastUpdate
      );

      if (result != null)
        _searchBloc.previousData= result;
    }

    _textController = TextEditingController(
      text: (_database.user.home != null) ?
      _database.user.home: ''
    );
  }

@override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textController,
      autocorrect: false,
      onTap: () {
        _textController.text= '';
      },
      onEditingComplete: () {
        _searchBloc.add(
          SearchEventLocationEdited(text: _textController.text),
        );
        FocusScope.of(context).unfocus();
      },
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      style: TextStyle(
        color: _theme.onMainColor,
        decoration: TextDecoration.none,
      ),
    );
  }
}