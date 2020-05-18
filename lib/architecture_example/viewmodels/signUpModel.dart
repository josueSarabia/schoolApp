import 'package:f_202010_provider_get_it/architecture_example/base/base_model.dart';
import 'package:f_202010_provider_get_it/architecture_example/models/user.dart';
import 'package:f_202010_provider_get_it/architecture_example/services/api.dart';

class SignUpModel extends BaseModel {
  final Api _api = Api();
  User _user;
  User get user => _user;
  Future<bool> signUp(String email, String password, String username, String name) async {
    setState(ViewState.Busy);
    var fetchedUser = await _api.signUp(email: email, password: password, username: username, name: name); // faltan campos
    var hasUser = fetchedUser != null;
    if (hasUser) {
      print('Got user token ${fetchedUser.token}');
      //userController.add(fetchedUser);
      _user = fetchedUser;
    }
    notifyListeners();
    setState(ViewState.Idle);
    return hasUser;
  }
}