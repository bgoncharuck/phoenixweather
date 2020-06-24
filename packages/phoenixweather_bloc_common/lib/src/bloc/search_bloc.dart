import 'dart:async';
import 'dart:io';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/currentdata.dart';

import 'package:phoenixweather_common/phoenixweather_common.dart';
import 'package:phoenixweather_database_common/phoenixweather_database_common.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    
    if (await noInternetConection()) {
      if (previousData != null && previousLocation != null)
        yield SearchStatePrevious(
            location: previousLocation,
            data: previousData
        );
      else yield SearchStateError("No internet connection");
    }

    if (event is SearchEventLocationEdited) {
      final String locationString= event.text;
      if (locationString.isEmpty) yield this.initialState;      
      else {
        // loading state while operation is pending
        yield SearchStateLoading();
        
        // Main stuff of location/weather search is going on here
        try {
    
          // get location
          final locationModel= await localLocationClient.getByCityName(city: locationString);

          // if location model is null for some reason show initial state
          if (locationModel == null) yield this.initialState;
          if (locationModel.data.startsWith("Error")) {
            // show error with error text inside of it
            if (locationModel.data.contains(wrongLocationName)) {
              yield SearchStateWrongLocation();
            } else if (locationModel.data.contains(wrongGoogleApiKeyError)) {
              yield SearchStateWrongGoogleCodingApiKey();
            } else yield SearchStateError(locationModel.data);
          } else {

            if (pushLocationModelToServer != null)
              pushLocationModelToServer(locationModel);

            // get weather
            final openWeatherModel= await localWeatherClient.getByLocation(location: locationModel);
            if (openWeatherModel == null) 
              yield SearchStateError("Error: OpenWeather Server is unavaible or your API key is wrong.");

            final currentData= CurrentData.fromOW(openWeatherModel);
            if (currentData == null) 
              yield SearchStateError("Error: can't convert OpenWeatherModel to data");

            // IF ALL OKAY
            previousData= currentData;
            previousLocation= locationModel;
            if (database != null) {
              await database.addWeather(
                location: locationModel,
                data: currentData
              );
              if (writeRecords != null)
                database.acceptAsyncNoWaiting(writeRecords);
            }
            yield SearchStateSuccess(
              location: locationModel, 
              data: currentData
            );
          }
        } catch (error) {
          yield SearchStateError(error.toString());
        }
      }
    } else if (event is SearchEventUpdate) {

      yield SearchStateLoading();
      try {
          if (previousLocation == null)
            yield SearchStateEmpty();
          else {
            // update weather
            final openWeatherModel= await localWeatherClient.getByLocation(location: previousLocation);
            if (openWeatherModel == null) 
              yield this.initialState;

            final currentData= CurrentData.fromOW(openWeatherModel);
            if (currentData == null) 
              yield this.initialState;

            // IF ALL OKAY
            previousData= currentData;
            if (database != null) {
              await database.addWeather(
                location: previousLocation,
                data: currentData
              );
              if (writeRecords != null)
                database.acceptAsyncNoWaiting(writeRecords);
            }
            yield SearchStateSuccess(
              location: previousLocation, 
              data: currentData
            );
        }

      } catch (error) {
        yield this.initialState;
      }
    }
  }

  // --------------------------------------------------------------------------------------------------------------------------
ILatLonApiClient localLocationClient;
IOpenWeatherAPIClient localWeatherClient;
RuntimeDatabase database;
CurrentData previousData;
ILatLonApiModel previousLocation;
AsyncRuntimeDatabaseVisitor writeRecords;
Future<void> Function(ILatLonApiModel model) pushLocationModelToServer;
 SearchBloc({
    this.previousData,
    this.previousLocation,
    this.localLocationClient,
    this.localWeatherClient,
    this.database,
    this.writeRecords,
    this.pushLocationModelToServer,
  }) {
    localLocationClient= (localLocationClient != null) ? localLocationClient : locationClient;
    localWeatherClient= (localWeatherClient != null) ? localWeatherClient : weatherClient;
  }

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
  .debounceTime(Duration(microseconds: 400))
  .switchMap(transition);

  @override
  void onTransition(Transition<SearchEvent, SearchState> transition) {
    // @DEBUG
    // print(database.locations.byName.length);
    super.onTransition(transition);
  }
}

Future<bool> noInternetConection() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return false;
    }
  } catch (_) {}
  return true;
}