import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  // Helper method that keeps the code in the widgets concise.
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  // Static member to have a simple access to the delegate from the MaterialApp.
  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  Map<String, String> _localizedStrings;

  Future<bool> load() async {
    String jsonString = await rootBundle.loadString('lang/${locale.languageCode}.json');

    Map<String, dynamic> jsonMap = json.decode(jsonString);

    this._localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  // Method that will be called from every widget which needs a localized text.
  String translate(String key) {
    return this._localizedStrings[key];
  }
}

// LocalizationsDelegate is a factory for a set of localized resources.
// In this case, the localized strings will be gotten in an AppLocalizations object.
class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {

  // This delegate instance will never change.
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['es'].contains(locale.languageCode); // Include all supported language codes.
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = new AppLocalizations(locale);
    await localizations.load();

    return localizations;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}