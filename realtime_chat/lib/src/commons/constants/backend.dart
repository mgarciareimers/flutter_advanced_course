import 'dart:io';

class Backend {
  static final String BASE_URL = Platform.isAndroid ? 'http://10.0.2.2:3000' : 'http://localhost:3000';
  static const String API = 'api';
  static const String V1 = 'v1';

  // Headers.
  static const String CONTENT_TYPE = 'Content-Type';
  static const String CONTENT_APPLICATION_JSON = 'application/json';

  // Users.
  static const String LOGIN = 'login';

}