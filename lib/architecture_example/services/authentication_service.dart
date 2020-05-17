import 'dart:async';
import 'package:f_202010_provider_get_it/architecture_example/models/user.dart';

import '../locator.dart';
import 'api.dart';


class AuthenticationService {
  Api _api = locator<Api>();
  User user;
 // StreamController<User> userController = StreamController<User>();

  Future<bool> login(String email, String password) async {
    User fetchedUser = await _api.getUserProfile(email: email, password: password);

    var hasUser = fetchedUser != null;
    if(hasUser) {
      print('Got user token ${fetchedUser.token}');
      //userController.add(fetchedUser);
      user = fetchedUser;
    }

    return hasUser;
  }

    Future<bool> logout() async {
    return Future.value(true);
  }

}