// Pages.
import 'package:app/src/pages/chat_page.dart';
import 'package:app/src/pages/loading_page.dart';
import 'package:app/src/pages/login_page.dart';
import 'package:app/src/pages/sign_up_page.dart';
import 'package:app/src/pages/users_page.dart';
import 'package:flutter/cupertino.dart';

class Routes {
  static const String CHAT_PAGE = 'chat';
  static const String LOADING_PAGE = 'loading';
  static const String LOGIN_PAGE = 'login';
  static const String SIGN_UP_PAGE = 'signUp';
  static const String USERS_PAGE = 'users';

  static Map<String, Widget Function(BuildContext context)> define() {
    return {
      CHAT_PAGE: (_) => ChatPage(),
      LOADING_PAGE: (_) => LoadingPage(),
      LOGIN_PAGE: (_) => LoginPage(),
      SIGN_UP_PAGE: (_) => SignUpPage(),
      USERS_PAGE: (_) => UsersPage(),
    };
  }
}