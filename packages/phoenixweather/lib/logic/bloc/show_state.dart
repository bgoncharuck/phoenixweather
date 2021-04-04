part of 'show_bloc.dart';

abstract class ShowState extends Equatable {
  List<int> get days=> null;
  List<WeatherModel> get items=> null;
  WeatherModel get item=> null;
  const ShowState();
  @override
  List<Object> get props => [days, items, item];
}

class ShowStateLoading extends ShowState {}

class ShowStateDay extends ShowState {
  final days;
  final List<WeatherModel> items;
  @override
  WeatherModel get item=> items[0];

  ShowStateDay({
    @required this.days,
    @required this.items
  });

  @override
  List<Object> get props => [days, items];
  @override
  bool get stringify => true;
}

class ShowStateItem extends ShowState {
  final WeatherModel item;
  final int day;
  final int index;

  ShowStateItem({
    @required this.item,
    @required this.day,
    @required this.index,
  });

  @override
  List<Object> get props => [item];
  @override
  bool get stringify => true;
}