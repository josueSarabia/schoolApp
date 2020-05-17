import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    _read();
  }
  String _username;
  String _token;
  bool _loggedIn = false;
  bool _userCreated = false;

  get username => _username;
  get userCreated => _userCreated;
  get loggedIn => _loggedIn;
  get token => _token;

  void setLoggedIn(String userName, String token) {
    _username = userName;
    _loggedIn = true;
    _token = token;
    _save();
    notifyListeners();
  }

  void setLogOut() {
    _loggedIn = false;
    _save();
    notifyListeners();
  }

  void setUserCreated(bool state) {
    _userCreated = state;
    notifyListeners();
  }

  _read() async {
    final prefs = await SharedPreferences.getInstance();
    final v = prefs.getBool('my_int_key') ?? false;
    final t = prefs.getString('my_token') ?? "_";
    final x = prefs.getString('my_username') ?? "_";
    if (v != null) {
      _loggedIn = v;
      _token = t;
      _username = x;
      notifyListeners();
    }
  }

  _save() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('my_int_key', _loggedIn);
    prefs.setString('my_token', _token);
    prefs.setString('my_username', _username);
  }
}

