part of '../phoenixweather_database_common.dart';

class User {
  final String id;
  String home;
  int lastUpdate;

  User({
    @required this.id,
    @required this.home,
    @required this.lastUpdate
  });  

  User.fromJson(dynamic json)
  : id= json['id'].toString(),
    home= json['home'].toString(),
    lastUpdate= json['lastUpdate'].toInt();

  Map<String, dynamic> toJson() => {
    'id': id,
    'home': home,
    'lastUpdate': lastUpdate 
  };
}