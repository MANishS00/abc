import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../service/api_adress.dart';

class UserState with ChangeNotifier {
  SharedPreferences? _prefs;

  // Constructor to initialize SharedPreferences
  UserState() {
    _init();
  }

  // Initialize SharedPreferences
  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Method for user login
  Future<bool> loginNow(String usuario, String password) async {
    String url = '$baseUrl:8000/api/v1/logins/';

    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({
          "username": usuario,
          "password": password,
        }),
      );

      var data = json.decode(response.body) as Map;
      if (data.containsKey("token")) {
        // Store token in SharedPreferences
        await _prefs?.setString("token", data['token']);
        return true;
      }
      return false;
    } catch (e) {
      print("Login Error:");
      print(e);
      return false;
    }
  }

  // Method for user registration
  Future<bool> registerNow(String usuario, String password) async {
    String url = '$baseUrl:8000/api/v1/registers/';

    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({
          "username": usuario,
          "password": password,
        }),
      );

      var data = json.decode(response.body) as Map;
      if (data["error"] == false) {
        return true;
      }
      return false;
    } catch (e) {
      print("Registration Error:");
      print(e);
      return false;
    }
  }

  // Method to retrieve the token from SharedPreferences
  String? getToken() {
    return _prefs?.getString('token');
  }

  // Method to remove the token (e.g., for logging out)
  Future<void> removeToken() async {
    await _prefs?.remove('token');
  }
}
