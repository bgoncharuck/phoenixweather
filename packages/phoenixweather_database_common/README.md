# Phoenixweather Runtime Database Common Dart Package

### > What is it all about?
- It is about save some data to not search it twice. 
- Also transfer it between storage and server.

```
import 'package:phoenixweather_database_common/phoenixweather_database_common.dart' 
as runtimeDatabase;

runtimeDatabase.cleanOldWeather();
runtimeDatabase.addLocation(location);

await storage.write(
    data: json.encode(
            runtimeDatabase
            .toStorageJson()),

    asFile: "phoenixweather_local.json"
);
```
### > Is it really helps make app faster?
- Nope.
- But it helps to save/load/transfer data correctly.
- Also, now location models can be shared between all users. And **this** *can* make app faster. If two users searched one location and it was synced between devices.