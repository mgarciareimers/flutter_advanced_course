import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Services.
import 'package:band_names/src/services/socket_service.dart';

// Constants.
import 'package:band_names/src/commons/constants/routes.dart';

// Pages.
import 'package:band_names/src/pages/home_page.dart';
import 'package:band_names/src/pages/status_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SocketService(),)
      ],
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.STATUS,
        routes: {
          Routes.HOME: (BuildContext context) => HomePage(),
          Routes.STATUS: (BuildContext context) => StatusPage(),
        }
      ),
    );
  }
}