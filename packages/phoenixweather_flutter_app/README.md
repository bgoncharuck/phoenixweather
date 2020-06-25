# phoenixweather_flutter_app
<div style="text-align:center" markdown="1">
<img width="282px" height="501px" src="../../repo_assets/weather_in_kyiv.png" />
<img width="282px" height="501px" src="../../repo_assets/weather_in_munchen.png" />
<img width="282px" height="501px" src="../../repo_assets/weather_in_lviv.png" />
</div>

Simple weather app with home location sync between devices by Google API.
`and by facebook API when their covoid hysteria finally ends.`

# For Developers
### App structure:
#### It uses 3 BLoCs
1. Loading BLoC is used to initialize app, load files from local storage and load locations data from firebase. Also, it is used to rebuild app, when new user logins.
2. Search BLoC from common dart package `../phoenixweather_bloc_common` is used to make event of Search for new location:weather with Google Coding API and OpenWeather API from `../phoenixweather_common` or to update weather for previous location. It also writes data to runtime database and storage if they was provided in loadingbloc and routes/WorkingApp init/build functions. More information in `../phoenixweather_bloc_common`
3. Show BLoC from dart package `../phoenixweather_bloc_common` used to show data. It starts after SearchStateSuccess and SearchStatePrevious from Search BLoC. It will use on of two states: show_items or show_item. show_items is responsible for showing weather hourly/daily for 7 days (first 2 days/48 hours are detailed by 1 hour per item). show_item needed to show detailed information on a hour or daytime.

#### It has services:
- permissions, to solve permissions checks
- loadlocalfiles and writelocalfiles, to save/load 2-3 json files with local information, depending on network avaibility.
- firebase_load and firebase_add needed for sync locations between all users for faster search and failure-proovf for Google Coding API. It is rare, but posssible situation.
- firebase_user has methods to deal with map of user home locations and firebase_auth used to work under login providers like GoogleSignIn, FacebookLogin or GithubAPI to switch the user account.

#### It can use custom themes and languages
by implementing `lib/theme/language.dart` and `/lib/theme/style.dart` interfaces.

#### It is stable
No memory leaks or overloads thanks to BLoC and visitor patterns.

#### It is fast
Because of Runtime Database

#### It is not memory effective
Well, app will not eat much, but we use runtime database here.
BLoC patterns will help to have less state objects inside runtime.
But if app will have about >100 000 users, we will need to say "no" to runtime database.
It will become slighty slower, then, though.
And not so stable as it is.

#### All code is modular and protected by either GPLv3 or LGPLv3
You can change it in any way you want while saving copyleft license.

Don't forget to include your API keys in ../packages/phoenixweather_common/lib/src/private/key.dart
