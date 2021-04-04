library phoenixweather_common;

import 'package:meta/meta.dart';
import 'client/latlonapi.dart';
import 'client/weatherapi.dart';
import 'models/latlonapi.dart';
import 'models/openweather.dart';

export 'client/latlonapi.dart';
export 'client/weatherapi.dart';
export 'models/latlonapi.dart';
export 'models/openweather.dart';
export 'models/weather.dart';
export 'models/currentdata.dart';

/// see client and create private folder to use your API keys
LatLonApiClient locationClient = GoogleGeocoding();
OpenWeatherAPIClient weatherClient = OpenWeather();

/// will save last asked location
/// use it for error handling
/// locationModel.data is string which store location you asked
/// or "Error: ..."
LatLonApiModel locationModel;

Future<OpenWeatherModel> whatIsTheWeatherIn({@required String location}) async {
  //
  locationModel = await locationClient.getByCityName(city: location);

  if (locationModel == null || locationModel.data.startsWith("Error"))
    return null;

  return await weatherClient.getByLocation(location: locationModel);
}
