import 'package:cbp_mobile_app_flutter/common/app_routes.dart';
import 'package:cbp_mobile_app_flutter/l10n/generated/l10n.dart';
import 'package:flutter/material.dart';

class AppLocalizations {
  AppLocalizations._();

  static GenLocalizations get current =>
      GenLocalizations.of(AppRouter.rootNavigatorKey.currentContext!)!;

  static List<Locale> get supportedLocales => GenLocalizations.supportedLocales;

  static LocalizationsDelegate<GenLocalizations> get delegate =>
      GenLocalizations.delegate;

  static List<Language> get switchLanguageLocales => [
        Language(locale: const Locale("en"), display: "EN"),
        Language(locale: const Locale("ms"), display: "BM"),
      ];
}

class Language {
  final Locale locale;
  final String display;

  Language({required this.locale, required this.display});
}
