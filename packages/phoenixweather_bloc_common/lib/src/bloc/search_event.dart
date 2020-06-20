part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class SearchEventLocationEdited extends SearchEvent {
  final String text;
  const SearchEventLocationEdited({this.text});

  @override
  List<Object> get props => [text];
  @override
  bool get stringify => true;
}

class SearchEventUpdate extends SearchEvent {
  @override
  List<Object> get props => [];
  @override
  bool get stringify => true;
}