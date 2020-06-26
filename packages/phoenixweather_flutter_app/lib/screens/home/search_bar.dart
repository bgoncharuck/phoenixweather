import 'package:flutter/material.dart';
import 'package:phoenixweather_database_common/phoenixweather_database_common.dart';
import 'package:phoenixweather_flutter_app/constants.dart';
import 'label.dart';

class SearchBar extends StatefulWidget {
  String label;
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

    _textController = TextEditingController();

    widget.label= (_database.user.home != null) ? _database.user.home : '';
  }

@override
  Widget build(BuildContext context) {

    return Row(
      children: <Widget>[
        Expanded(child: CurrentHomeLabel(
          label: widget.label, 
          color: _theme.onMainColor, 
          fontSize: 12,
        )),
        Expanded(
          child: TextField(
            controller: _textController,
            autocorrect: false,
            onEditingComplete: () {
              final savedSearch= _textController.text;
              setState(() {
                widget.label= savedSearch;
                _textController.text= '';               
              });
              FocusScope.of(context).unfocus();
              _searchBloc.add(
                SearchEventLocationEdited(text: savedSearch),
              );
            },
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
            style: TextStyle(
              color: _theme.onMainColor,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ],
    );
  }
}