import 'dart:io' show Platform;

abstract class ILanguageSetting {
  String get errorLabel;
  String get errorFilesPermission;
  String get errorGoogleApi;
  String get errorWrongLocation;
  String get noInternet;
  String get emptyPage;
  String get night;
  String get morning;
  String get evening;
  String get day;
  String get clear;
  String get thunderstorm;
  String get drizzle;
  String get rain;
  String get snow;
  String get mist;
  String get clouds;
  String get pressure;
  String get humidity;
  String get feelsLike;
  String get windSpeed;
  String get probabilityPrecipitation;
}

class EnglishLanguage implements ILanguageSetting {
  final String errorLabel= "Error";
  final String errorFilesPermission= "My Lord, you did not grant me access to a storage.\nI can't save or load these config files:\n";
  final String errorGoogleApi= "No Google Coding API key.";
  final String errorWrongLocation= "Wrong city or location. No such data record.";
  final String noInternet= "No record in offline database was found.";
  final String emptyPage= "Enter location in the top bar.";
  final String night= "Night";
  final String morning= "Morning";
  final String evening= "Evening";
  final String day= "Day";
  final String clear= "Clear";
  final String thunderstorm= "Storm";
  final String drizzle= "Drizzle";
  final String rain= "Rain";
  final String snow= "Snow";
  final String mist= "Mist";
  final String clouds= "Clouds";
  final String pressure= "pressure, mm";
  final String humidity= "humidity, %";
  final String feelsLike= "feels like";
  final String windSpeed= "wind speed, m/s";
  final String probabilityPrecipitation= "probability precipitation, %";
}

class GermanLanguage implements ILanguageSetting {
  final String errorLabel= "Error";
  final String errorFilesPermission= "Mein Herr, Sie haben keinen Zugang zu dem Speicher gewährt.\nIch kann diese Konfigurationsdateien nicht speichern oder laden:\n";
  final String errorGoogleApi= "Kein Google Coding API-Schlüssel.";
  final String errorWrongLocation= "Falsche Stadt oder Ort. Keine solche Aufzeichnung.";
  final String noInternet= "Es wurde kein Datensatz in der Offline-Datenbank gefunden.";
  final String emptyPage= "Suchort in der oberen Leiste.";
  final String night= "Nacht";
  final String morning= "Morgen";
  final String evening= "Abend";
  final String day= "Tag";
  final String clear= "Klar";
  final String thunderstorm= "Sturm";
  final String drizzle= "Sprühregen";
  final String rain= "Regen";
  final String snow= "Schnee";
  final String mist= "Nebel";
  final String clouds= "Wolken";
  final String pressure= "Druck, mm";
  final String humidity= "Feuchtigkeit, %";
  final String feelsLike= "fühlt sich an wie";
  final String windSpeed= "Windgeschwindigkeit, m/s";
  final String probabilityPrecipitation= "Niederschlagswahrscheinlichkeit, %";
}

class UkranianLanguage implements ILanguageSetting {
  final String errorLabel= "Помилка";
  final String errorFilesPermission= "Мій Володарю, я не можу зберегти чи завантажити ось ці файли:";
  final String errorGoogleApi= "Відсутній ключ Google Coding API";
  final String errorWrongLocation= "Ви вказали неправильне місто або його немає у базі.";
  final String noInternet= "Не знайдено записів у локальній базі даних. Підключіть інтернет, або пошукайте щось інше.";
  final String emptyPage= "Введіть назву міста зверху, щоб розпочати пошук.";
  final String night= "Ніч";
  final String morning= "Ранок";
  final String evening= "Вечір";
  final String day= "День";
  final String clear= "Ясно";
  final String thunderstorm= "Гроза";
  final String drizzle= "Мряка";
  final String rain= "Дощ";
  final String snow= "Сніг";
  final String mist= "Туман";
  final String clouds= "Хмарно";
  final String pressure= "тиск, мм";
  final String humidity= "вологість, %";
  final String feelsLike= "відчувається як";
  final String windSpeed= "швидкість вітру, м/с";
  final String probabilityPrecipitation= "ймовірність опадів, %";
}

class RussianLanguage implements ILanguageSetting {
  final String errorLabel= "Ошибка";
  final String errorFilesPermission= "Мой господин, я не могу сохранить или загрузить вот эти файлы:";
  final String errorGoogleApi= "Отсутствует ключ Google Coding API";
  final String errorWrongLocation= "Вы указали неправильный город или его нет в базе.";
  final String noInternet= "Не найдено записей в локальной базе данных. Подключите интернет, или поищите что-то другое.";
  final String emptyPage= "Введите название города сверху, чтобы начать поиск.";
  final String night= "Ночь";
  final String morning= "Утро";
  final String evening= "Вечер";
  final String day= "День";
  final String clear= "Ясно";
  final String thunderstorm= "Гроза";
  final String drizzle= "Изморось";
  final String rain= "Дождь";
  final String snow= "Снег";
  final String mist= "Туман";
  final String clouds= "Хмарно";
  final String pressure= "давление, мм";
  final String humidity= "влажность, %";
  final String feelsLike= "ощущается как";
  final String windSpeed= "скорость ветра, м/с";
  final String probabilityPrecipitation= "вероятность осадков, %";
}

ILanguageSetting get systemLanguage {
  String languageCode = Platform.localeName.split('_')[0];
  // print("Language code is $languageCode");
  switch (languageCode) {
    case 'uk':
      return UkranianLanguage();

    case 'de':
      return GermanLanguage();

    case 'ru':
      return RussianLanguage();

    default:
      return EnglishLanguage();
  }
}