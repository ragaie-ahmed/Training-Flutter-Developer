// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// class AppLocalizations {
//   Locale? locale;
//
//   AppLocalizations({required this.locale});
//
//   static AppLocalizations? of(BuildContext context) {
//     return Localizations.of<AppLocalizations>(context, AppLocalizations);
//   }
// static LocalizationsDelegate<AppLocalizations> delegate=_LocalizationsDelegate();
//   late Map<String, String> jsonString;
//
//   Future loadLandJson() async {
//     String json = await rootBundle.loadString(
//       "assets/Lang/${locale!.languageCode}.json",
//     );
//     Map<String, dynamic> jsonData = jsonDecode(json);
//     jsonString = jsonData.map((key, value) {
//       return MapEntry(key, value.toString());
//     });
//   }
//
//   String translate(String key) => jsonString[key] ?? "";
// }
//
// class _LocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
//   @override
//   bool isSupported(Locale locale) {
//     return ["ar", "en"].contains(locale.languageCode);
//   }
//
//   @override
//   Future<AppLocalizations> load(Locale locale) async {
//     AppLocalizations appLocalizations = AppLocalizations(locale: locale);
//     await appLocalizations.loadLandJson();
//     return appLocalizations;
//   }
//
//   @override
//   bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
//       false;
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations({required this.locale});

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _LocalizationsDelegate();

  late Map<String, String> _localizedStrings;

  Future<void> loadLangJson() async {
    String jsonString = await rootBundle.loadString(
      "assets/Lang/${locale.languageCode}.json",
    );
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
  }

  String translate(String key) => _localizedStrings[key] ?? "";
}

class _LocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _LocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ["ar", "en"].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale: locale);
    await localizations.loadLangJson();
    return localizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) => false;
}
