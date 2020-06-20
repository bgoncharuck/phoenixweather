library phoenixweather_common;

import 'package:meta/meta.dart';
import 'src/client/latlonapi.dart';
import 'src/client/weatherapi.dart';
import 'src/models/latlonapi.dart';
import 'src/models/openweather.dart';

export 'src/client/latlonapi.dart';
export 'src/client/weatherapi.dart';
export 'src/models/latlonapi.dart';
export 'src/models/openweather.dart';

// see client and create private folder to use your API keys
ILatLonApiClient locationClient= GoogleGeocoding();
IOpenWeatherAPIClient weatherClient= OpenWeather();

// will save last asked location
// use it for error handling
// locationModel.data is string which store location you asked
// or "Error: ..."
ILatLonApiModel locationModel= null;

Future<OpenWeatherModel> whatIsTheWeatherIn({@required String location}) async {
    
  locationModel= await locationClient.getByCityName(city: location);
  if (locationModel == null || locationModel.data.startsWith("Error")) return null;
    
  return await weatherClient.getByLocation(
      location: locationModel
  );
}
