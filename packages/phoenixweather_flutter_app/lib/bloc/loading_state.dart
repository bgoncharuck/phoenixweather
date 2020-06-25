part of 'loading_bloc.dart';

abstract class LoadingState extends Equatable {
  const LoadingState();
}

class LoadingInitial extends LoadingState {
  @override
  List<Object> get props => [];
}

class LoadingError extends LoadingState {
  final error= "error";
  @override
  List<Object> get props => [error];
}

class LoadingSuccess extends LoadingState {
  final done= "done";
  @override
  List<Object> get props => [done];
}

class LoadingUpdate extends LoadingState {
  final update= "update";
  @override
  List<Object> get props => [update];
}