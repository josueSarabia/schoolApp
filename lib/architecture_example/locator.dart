import 'package:get_it/get_it.dart';

import 'services/api.dart';
import 'services/authentication_service.dart';
import 'services/couses_service.dart';
import 'viewmodels/coursedetailmodel.dart';
import 'viewmodels/homemodel.dart';
import 'viewmodels/loginmodel.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() =>   CourseService());
  locator.registerLazySingleton(() => Api());
  locator.registerFactory(() => LoginModel());
  locator.registerFactory(() => HomeModel());
  locator.registerFactory(() => CourseDetailModel());
}
