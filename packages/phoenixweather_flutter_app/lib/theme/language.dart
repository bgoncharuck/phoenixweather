import 'dart:io' show Platform;

abstract class ILanguageSetting {
  String get errorLabel;
  String get errorFilesPermission;
}

class EnglishLanguage implements ILanguageSetting {
  final String errorLabel= "Error";
  final String errorFilesPermission= "I can't save or load this files:";
}

// @TODO
// class GermanLanguage implements ILanguageSetting {}

class UkranianLanguage implements ILanguageSetting {
  final String errorLabel= "Помилка";
  final String errorFilesPermission= "Я не можу зберегти чи завантажити ось ці файли:";
}

class RussianLanguage implements ILanguageSetting {
  final String errorLabel= "Ошибка";
  final String errorFilesPermission= "Я не могу сохранить или загрузить:";
}

ILanguageSetting get systemLanguage {
  String languageCode = Platform.localeName.split('_')[0];
  print("Language code is $languageCode");
  switch (languageCode) {
    case 'uk':
      return UkranianLanguage();

    // case 'de':
    //   return GermanLanguage();

    case 'ru':
      return RussianLanguage();

    default:
      return EnglishLanguage();
  }
}