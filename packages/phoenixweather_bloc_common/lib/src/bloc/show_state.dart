part of 'show_bloc.dart';

abstract class ShowState extends Equatable {
  const ShowState();
  @override
  List<Object> get props => [];
}

class ShowStateLoading extends ShowState {}

class ShowStateDay extends ShowState {
  final int day;
  final List<WeatherModel> items;

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
