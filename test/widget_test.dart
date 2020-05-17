// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:f_202010_provider_get_it/architecture_example/ui/login_view.dart';
import 'package:f_202010_provider_get_it/architecture_example/viewmodels/loginmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

//class MockUserRepository extends Mock implements LoginModel {}


void main() {
  //MockUserRepository _repo = new  MockUserRepository();
    Widget _makeTestable(Widget child) {
    return ChangeNotifierProvider<LoginModel>.value(
      child: MaterialApp(
        home: child,
      ),
    );
  }



  testWidgets('test login', (WidgetTester tester) async {



    // Build our app and trigger a frame.
    //await tester.pumpWidget(_makeTestable(LoginView()));
    //var buttonLogin = find.text('Login');
    //await tester.tap(buttonLogin);
    // await tester.pump();
     // verify(_repo.signIn("test@testmail.com", "password")).called(1);
    // Verify that our counter starts at 0.
    //expect(find.text('Login'), findsNothing);
  });
}
