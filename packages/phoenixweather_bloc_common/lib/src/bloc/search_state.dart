part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
  CurrentData get data=> null;
  String get errorText=> "";
  @override
  List<Object> get props => [data, errorText];
}

// init states
class SearchStateEmpty extends SearchState{}
class SearchStatePrevious extends SearchState{
  final ILatLonApiModel location;
  final CurrentData data;

  const SearchStatePrevious({
    this.location= null,
    @required this.data
  });

  @override
  List<Object> get props => [location, data];
  @override
  bool get stringify => true;
}

// loading
class SearchStateLoading extends SearchState{}

// result states
class SearchStateSuccess extends SearchState{
  final ILatLonApiModel location;
  final CurrentData data;

  const SearchStateSuccess({
    @required this.location,
    @required this.data
  });

  @override
  List<Object> get props => [location, data];
  @override
  bool get stringify => true;
}

class SearchStateWrongGoogleCodingApiKey extends SearchState{}
class SearchStateWrongLocation extends SearchState{}
class SearchStateNoInternet extends SearchState {}
class SearchStateError extends SearchState{
  final String errorText;
  const SearchStateError(this.errorText);
  @override
  List<Object> get props => [errorText];
  @override
  bool get stringify => true;
}





