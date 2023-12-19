enum LocalizationSupportedLanguage {
  en,
  ms,
}
extension LocalizationSupportedLanguageValue on LocalizationSupportedLanguage {
  String get languageCode {
    switch (this) {
      case LocalizationSupportedLanguage.en:
        return "en";
      case LocalizationSupportedLanguage.ms:
        return "ms";
    }
  }
}



abstract class ErrorCodeModel {
  LocalizationSupportedLanguage getLocalizationSupportedLanguage();
  Map<String, dynamic> getData();
}

