import 'package:f_202010_provider_get_it/architecture_example/base/base_model.dart';
import 'package:f_202010_provider_get_it/architecture_example/models/course_detail.dart';
import 'package:f_202010_provider_get_it/architecture_example/services/api.dart';

import '../locator.dart';

class CourseDetailModel extends BaseModel {
  Api _api = locator<Api>();

  CourseDetail courseDetail;

  Future getCourse(
    String user, String token, int courseId) async {
    setState(ViewState.Busy);
    courseDetail = await _api.getCourse(user, token, courseId);
    setState(ViewState.Idle);
  }
   Future addStudent(String user, String token, int courseId) async {
    setState(ViewState.Busy);
  try {
      await _api.addStudentService(user,token,courseId);
      getCourse(user, token, courseId);
      return Future.value(true);
    } catch (err) {
      print('homemodel addCourse ${err.toString()}');
       setState(ViewState.Idle);
      return Future.error(err.toString());
    }
  }
}
