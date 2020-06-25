part of 'loading_bloc.dart';

abstract class LoadingEvent extends Equatable {
  const LoadingEvent();
}

class LoadingErrorEvent extends LoadingEvent {
  @override
  List<Object> get props => [];
}

class LoadingSuccessEvent extends LoadingEvent {
  @override
  List<Object> get props => [];
}

class LoadingUpdateEvent extends LoadingEvent {
  @override
  List<Object> get props => [];
}