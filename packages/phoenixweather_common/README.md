## Phoenixweather Common Dart Package

#### Main Purpose
- **IN**: City name
- **OUT**: OpenWeatherModel or null

#### API
- finding location coordinates by location name with **Google Geocoding API**, but can use any other by implementing interface ILatLonApiClient
- finding weather by coordinates with **OpenWeather API**, but can use any other by implementing IWeatherApiClient

#### Import
```
import 'package:phoenixweather_common/phoenixweather_common.dart' as synoptic;
```

#### Use
```
final weatherInParis= await synoptic
.whatIsTheWeatherIn(location: "Paris");

// handle error
if (weatherInParis == null) {
    if (synoptic.locationModel != null) 
    // print error
    print(synoptic.locationModel.data);
} else print("Temperature in ${synoptic.locationModel.data} is ${weatherInParis.hourly[0].temp} K");
```
