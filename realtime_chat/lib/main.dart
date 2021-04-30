import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// Routes.
import 'package:app/src/routes/routes.dart';

// Commons.
import 'package:app/src/commons/utils/app_localizations.dart';

// Constants.
import 'package:app/src/commons/constants/strings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.APP_NAME,
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.LOGIN_PAGE,
      routes: Routes.define(),

      // Supported local languages.
      supportedLocales: [
        //Locale('en', 'US'),
        //Locale('en', 'UK'),
        Locale('es', 'ES'),
        //Locale('es', 'MX'),
      ],

      // Make sure that the localization data for the proper language is loaded.
      localizationsDelegates: [
        AppLocalizations.delegate, // A class which loads the translations from JSON files.
        GlobalMaterialLocalizations.delegate, // Built-in localization of basic text for Material widgets.
        GlobalCupertinoLocalizations.delegate, // Built-in localization of basic text for Cupertino widgets.
        GlobalWidgetsLocalizations.delegate, // Built-in localization for text direction LTR/RTL.
      ],

      // Returns a locale which will be used by the app.
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode && supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }

        return supportedLocales.first;
      },
    );
  }
}