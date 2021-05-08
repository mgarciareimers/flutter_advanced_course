import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Services.
import 'package:app/src/services/socket_service.dart';
import 'package:app/src/services/auth_service.dart';

// Constants.
import 'package:app/src/commons/constants/custom_colors.dart';

// Pages.
import 'package:app/src/pages/login_page.dart';
import 'package:app/src/pages/users_page.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with TickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    this.controller = new AnimationController(vsync: this, duration: new Duration(milliseconds: 1000), lowerBound: 0.8)
      ..forward()
      ..repeat(reverse: true);

    super.initState();
  }

  @override
  void dispose() {
    this.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.GRAY_LIGHT,
      body: FutureBuilder(
        future: this._checkLoggedInState(),
        builder: (context, snapshot) => Center(
          child: ScaleTransition(
            scale: CurvedAnimation(parent: this.controller, curve: Curves.easeIn),
            child: Image(image: AssetImage('assets/logo.png'), width: MediaQuery.of(context).size.width * 0.45),
          ),
        ),
      ),
    );
  }

  // Method that checks the user state (if logged in or not).
  Future _checkLoggedInState() async {
    final AuthService authService = Provider.of<AuthService>(this.context, listen: false);

    final authenticated = await authService.isLoggedIn();

    Timer(Duration(seconds: 3), () {
      if (mounted) {
        if (authenticated) {
          // Connect to socket.
          Provider.of<SocketService>(this.context, listen: false).connect();

          Navigator.pushReplacement(this.context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => UsersPage(), transitionDuration: Duration(milliseconds: 0)));
        } else {
          Navigator.pushReplacement(this.context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => LoginPage(), transitionDuration: Duration(milliseconds: 0)));
        }
      }
    });
  }
}
