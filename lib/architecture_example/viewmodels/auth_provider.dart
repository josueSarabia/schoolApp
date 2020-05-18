import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    _read();
  }
  String _username;
  String _token;
  String _email;
  bool _loggedIn = false;
  bool _userCreated = false;
  bool _rememberSession = false;

  get username => _username;
  get userCreated => _userCreated;
  get email => _email;
  get loggedIn => _loggedIn;
  get token => _token;
  get rememberSession => _rememberSession;

  void setLoggedIn(String userName, String token, String email , bool rememberSession) {
    _username = userName;
    _email = email;
    _loggedIn = true;
    _token = token;
    _rememberSession = rememberSession;
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
    final z = prefs.getString('my_email') ?? "_";
    final y = prefs.getBool('rememberSession') ?? false;
    if (v != null) {
      _loggedIn = v;
      _token = t;
      _username = x;
      _rememberSession = y;
      _email = z;
      notifyListeners();
    }
  }

  _save() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('rememberSession', _rememberSession);
    prefs.setBool('my_int_key', _loggedIn);
    prefs.setString('my_token', _token);
    prefs.setString('my_username', _username);
    prefs.setString('my_email', _username);
  }
}

