part of 'show_bloc.dart';

abstract class ShowState extends Equatable {
  int get day=> null;
  List<WeatherModel> get items=> null;
  WeatherModel get item=> null;
  const ShowState();
  @override
  List<Object> get props => [day, items, item];
}

class ShowStateLoading extends ShowState {}

class ShowStateDay extends ShowState {
  final int day;
  final List<WeatherModel> items;
  @override
  WeatherModel get item=> items[0];

  ShowStateDay({
    @required this.day,
    @required this.items
  });

  @override
  List<Object> get props => [day, items];
  @override
  bool get stringify => true;
}

class ShowStateItem extends ShowState {
  final WeatherModel item;

  ShowStateItem({@required this.item});

  @override
  List<Object> get props => [item];
  @override
  bool get stringify => true;
}