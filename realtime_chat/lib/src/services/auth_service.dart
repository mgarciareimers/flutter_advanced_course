import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Models.
import 'package:app/src/models/user_model.dart';

// Constants.
import 'package:app/src/commons/constants/backend.dart';
import 'package:app/src/commons/constants/strings.dart';

class AuthService with ChangeNotifier {
  UserModel _user;
  bool _isLoading = false;

  final FlutterSecureStorage _storage = new FlutterSecureStorage();
  
  UserModel get user => this._user;

  bool get isLoading => this._isLoading;
  set isLoading(bool value) {
    this._isLoading = value;
    notifyListeners();
  }

  // Method that gets the jwt.
  static Future<String> getJWT() async => await new FlutterSecureStorage().read(key: Strings.TOKEN);

  // Method that removes the jwt.
  static Future<void> removeJWT() async => await new FlutterSecureStorage().delete(key: Strings.TOKEN);

  // Method that saves the jwt.
  Future _saveJWT(String token) async {
    return await this._storage.write(key: Strings.TOKEN, value: token);
  }

  // Method that logs the user into the app.
  Future<Map<String, dynamic>> login(String email, String password) async {
    this.isLoading = true;

    try {
      final Map<String, dynamic> data = {
        'email': email,
        'password': password,
      };

      final http.Response response = await http.post(Uri.parse('${ Backend.BASE_URL }/${ Backend.API }/${ Backend.V1 }/${ Backend.LOGIN }'), body: jsonEncode(data), headers: { Backend.CONTENT_TYPE: Backend.CONTENT_APPLICATION_JSON });

      final body = jsonDecode(response.body);

      String token;

      if (body['success'] && body['data'] != null) {
        this._user = new UserModel.fromJson(body[Strings.DATA][Strings.USER]);
        token = body[Strings.DATA][Strings.TOKEN];
      }

      // Save token in memory.
      await this._saveJWT(token);

      this.isLoading = false;

      return {
        Strings.SUCCESS: body[Strings.SUCCESS],
        Strings.MESSAGE: body[Strings.MESSAGE],
      };
    } catch(e) {
      this.isLoading = false;

      return {
        Strings.SUCCESS: false,
        Strings.MESSAGE: null,
      };
    }
  }

  // Method that signs the user up.
  Future<Map<String, dynamic>> signUp(String name, String email, String password) async {
    this.isLoading = true;

    try {
      final Map<String, dynamic> data = {
        'name': name,
        'email': email,
        'password': password,
      };

      final http.Response response = await http.post(Uri.parse('${ Backend.BASE_URL }/${ Backend.API }/${ Backend.V1 }/${ Backend.SIGN_UP }'), body: jsonEncode(data), headers: { Backend.CONTENT_TYPE: Backend.CONTENT_APPLICATION_JSON });

      final body = jsonDecode(response.body);

      String token;

      if (body['success'] && body['data'] != null) {
        this._user = new UserModel.fromJson(body[Strings.DATA][Strings.USER]);
        token = body[Strings.DATA][Strings.TOKEN];
      }

      // Save token in memory.
      await this._saveJWT(token);

      this.isLoading = false;

      return {
        Strings.SUCCESS: body[Strings.SUCCESS],
        Strings.MESSAGE: body[Strings.MESSAGE],
      };
    } catch(e) {
      this.isLoading = false;

      return {
        Strings.SUCCESS: false,
        Strings.MESSAGE: null,
      };
    }
  }

  // Method that checks if the user is logged.
  Future<bool> isLoggedIn() async {
    try {
      final response = await http.get(Uri.parse('${ Backend.BASE_URL }/${ Backend.API }/${ Backend.V1 }/${ Backend.REFRESH }'), headers: { Backend.CONTENT_TYPE: Backend.CONTENT_APPLICATION_JSON, Strings.TOKEN: await getJWT() });

      final body = jsonDecode(response.body);

      String token;

      if (body['success'] && body['data'] != null) {
        this._user = new UserModel.fromJson(body[Strings.DATA][Strings.USER]);
        token = body[Strings.DATA][Strings.TOKEN];
      }

      // Save token in memory.
      if (token == null) {
        await removeJWT();
      } else {
        await this._saveJWT(token);
      }

      return token != null && token.length > 0;
    } catch(e) {
      return false;
    }
  }
}