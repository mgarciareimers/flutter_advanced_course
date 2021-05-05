import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Models.
import 'package:app/src/models/user_model.dart';

// Constants.
import 'package:app/src/commons/constants/backend.dart';
import 'package:app/src/commons/constants/strings.dart';

class AuthService with ChangeNotifier {
  UserModel user;
  bool _isLogging = false;

  bool get isLogging => this._isLogging;
  set isLogging(bool value) {
    this._isLogging = value;
    notifyListeners();
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    this.isLogging = true;

    final Map<String, dynamic> data = {
      'email': email,
      'password': password,
    };

    final http.Response response = await http.post(Uri.parse('${ Backend.BASE_URL }/${ Backend.API }/${ Backend.V1 }/${ Backend.LOGIN }'), body: jsonEncode(data), headers: { Backend.CONTENT_TYPE: Backend.CONTENT_APPLICATION_JSON });

    final body = jsonDecode(response.body);

    String token;

    if (body['data'] != null) {
      this.user = new UserModel.fromJson(body[Strings.DATA][Strings.USER]);
      token = body[Strings.DATA][Strings.TOKEN];
    }

    this.isLogging = false;

    return {
      Strings.SUCCESS: body[Strings.SUCCESS],
      Strings.MESSAGE: body[Strings.MESSAGE],
      Strings.TOKEN: token
    };
  }
}