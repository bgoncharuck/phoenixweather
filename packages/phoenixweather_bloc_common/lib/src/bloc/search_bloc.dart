import 'dart:async';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/currentdata.dart';

// APIs to make search and get result
import 'package:phoenixweather_common/phoenixweather_common.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SearchEventLocationEdited) {
      final String locationString= event.text;
      if (locationString.isEmpty) yield this.initialState;      
      else {
        // loading state while operation is pending
        yield SearchStateLoading();
        
        // Main stuff of location/weather search is going on here
        try {

          // get location
          final locationModel= await locationClient.getByCityName(city: locationString);

          // if location model is null for some reason show initial state
          if (locationModel == null) yield this.initialState;
          if (locationModel.data.startsWith("Error")) {
            // show error with error text inside of it
            if (locationModel.data.contains(wrongLocationName)) {
              yield SearchStateWrongLocation();
            } else if (locationModel.data.contains(wrongGoogleApiKeyError)) {
              yield SearchStateWrongGoogleCodingApiKey();
            } else yield SearchStateError(locationModel.data);
          }

          // get weather
          final openWeatherModel= await weatherClient.getByLocation(location: locationModel);
          if (openWeatherModel == null) 
            yield SearchStateError("Error: OpenWeather Server is unavaible or your API key is wrong.");

          final currentData= CurrentData.fromOW(openWeatherModel);
          if (currentData == null) 
            yield SearchStateError("Error: can't convert OpenWeatherModel to data");

          // IF ALL OKAY
          previousData= currentData;
          previousLocation= locationModel;
          if (addToDatabase != null) addToDatabase(
            location: locationModel,
            data: currentData
          );
          yield SearchStateSuccess(
            location: locationModel, 
            data: currentData
          );

        } catch (error) {
          yield SearchStateError(error.toString());
        }
      }
    } else if (event is SearchEventUpdate) {

      yield SearchStateLoading();
      try {

        // update weather
        final openWeatherModel= await weatherClient.getByLocation(location: previousLocation);
        if (openWeatherModel == null) 
          yield this.initialState;

        final currentData= CurrentData.fromOW(openWeatherModel);
        if (currentData == null) 
          yield this.initialState;

        // IF ALL OKAY
        previousData= currentData;
        if (addToDatabase != null) addToDatabase(
            location: previousLocation,
            data: currentData
        );
        yield SearchStateSuccess(
          location: previousLocation, 
          data: currentData
        );

      } catch (error) {
        yield this.initialState;
      }
    }
  }

  // --------------------------------------------------------------------------------------------------------------------------
  Future<bool> Function({
  @required ILatLonApiModel location, 
  @required CurrentData data
  }) addToDatabase;
  CurrentData previousData;
  ILatLonApiModel previousLocation;
  SearchBloc({
    this.previousData= null,
    this.previousLocation= null,
    this.addToDatabase= null
  });

  @override
  SearchState get initialState {
    if (previousData != null) 
      if (previousLocation != null) {
        return SearchStatePrevious(
          location: previousLocation,
          data: previousData
        );
      } else return SearchStatePrevious(data: previousData);
      
    return SearchStateEmpty();
  }

  @override
  Stream<Transition<SearchEvent, SearchState>> transformEvents(
    Stream<SearchEvent> events,
    Stream<Transition<SearchEvent, SearchState>> Function (SearchEvent event) transition
  ) => events
  .debounceTime(Duration(seconds: 1))
  .switchMap(transition);

  @override
  void onTransition(Transition<SearchEvent, SearchState> transition) {
    // @DEBUG
    // print(transition);
    super.onTransition(transition);
  }
}
