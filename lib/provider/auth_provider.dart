
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as httpClient;
import 'package:jwt_decode/jwt_decode.dart';

import '../model/http_exception.dart';

class AuthProvider with ChangeNotifier {

  String _token = '';

  bool get isAuth {
    return token != '';
  }

  String get token {
    if (_token != '' && !Jwt.isExpired(_token)) {
      return _token;
    }
    return '';
  }

  Future<void> signup(String email, String password) async {
    final url = Uri.parse('http://localhost:8080/api/user/register');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    try {
      final response = await httpClient.post(url, headers: headers, body: json.encode({
        'email': email,
        'password': password
      }));

      final res = json.decode(response.body);
      log(res.toString());
      notifyListeners();
    } catch (error) {
      log(error.toString());
      rethrow;
    }
  }


  Future<void> login(String email, String password) async {
    final url = Uri.parse('http://localhost:8080/api/user/login');
    Map<String,String> headers = {
      'Content-type' : 'application/json',
      'Accept': 'application/json',
    };

    try {
      final response = await httpClient.post(url, headers: headers, body: json.encode({
        'email': email,
        'password': password
      }));
      if (response.statusCode != 200) {
        throw HttpException(json.decode(response.body)['message'].toString());
      }

      final res = json.decode(response.body);
      log(res.toString());
      _token = json.decode(response.body)['token'].toString();
      notifyListeners();
    } catch (error) {
      log(error.toString());
      rethrow;
    }
  }

  void logout() {
    _token = '';
    notifyListeners();
  }
}