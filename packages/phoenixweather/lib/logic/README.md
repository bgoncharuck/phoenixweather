# Phoenixflower Business Logic Common Dart Pacckage

## business logic pattern
### 1. Search Weather
#### SearchEventLocationEdited
#### IN: 
- `String` location name
##### Posssible OUT:
- SearchStateEmpty, 
- SearchStatePrevious{`ILatLonApiModel `location, `CurrentData` data}
- SearchStateLoading
- SearchStateSuccess{`ILatLonApiModel `location, `CurrentData` data}
- SearchStateWrongGoogleCodingApiKey
- SearchStateWrongLocation
- SearchStateError{`String` errorText}
#### SearchEventUpdate
#### IN: no
#### Possible OUT:
- SearchStatePrevious{`ILatLonApiModel `location, `CurrentData` data}
- SearchStateSuccess{`ILatLonApiModel `location, `CurrentData` data}

### 2. Show Data
#### ShowItemEvent
#### IN:
- `WeatherModel` item
#### OUT:
- ShowStateItem{`WeatherModel` item}
#### ShowDayEvent
#### IN:
- `CurrentData` data
- `int` day = [1,7]
#### OUT:
- ShowStateDay{`int` day, `List<WeatherModel>` items}
