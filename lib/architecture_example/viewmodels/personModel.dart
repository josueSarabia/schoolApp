import 'package:f_202010_provider_get_it/architecture_example/base/base_model.dart';
import 'package:f_202010_provider_get_it/architecture_example/models/person.dart';
import 'package:f_202010_provider_get_it/architecture_example/services/api.dart';

import '../locator.dart';

class PersonModel extends BaseModel {
  Api _api = locator<Api>();

  Person personDetail;
  Future getPersonDetail(String username, String token, int personId, String personType) async {
    setState(ViewState.Busy);
    if(personType == 'student'){
      personDetail = await _api.getPersonDetail(username, token, 'students/' + personId.toString());
    } else {
      personDetail = await _api.getPersonDetail(username, token, 'professors/' + personId.toString());
    }
    setState(ViewState.Idle);
  }
}
