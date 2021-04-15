import 'package:flutter/material.dart';

// Constants.
import 'package:band_names/src/constants/routes.dart';

// Pages.
import 'package:band_names/src/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.HOME,
      routes: {
        Routes.HOME: (BuildContext context) => HomePage(),
      }
    );
  }
}