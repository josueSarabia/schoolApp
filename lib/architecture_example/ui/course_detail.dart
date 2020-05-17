import 'package:f_202010_provider_get_it/architecture_example/base/base_model.dart';
import 'package:f_202010_provider_get_it/architecture_example/base/base_view.dart';
import 'package:f_202010_provider_get_it/architecture_example/viewmodels/auth_provider.dart';
import 'package:f_202010_provider_get_it/architecture_example/viewmodels/coursedetailmodel.dart';
 
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/coursedetailmodel.dart';

class CourseDetailView extends StatelessWidget {
  final int courseId;
  CourseDetailView({this.courseId});
  @override
  Widget build(BuildContext context) {
    return BaseView<CourseDetailModel>(
        onModelReady: (model) => model.getCourse(
            Provider.of<AuthProvider>(context).username,
            Provider.of<AuthProvider>(context).token,courseId).catchError((error) async {
          print("getCourses got error: " + error);
          await _buildDialog(context, 'Alert', 'Need to login');
          Provider.of<AuthProvider>(context, listen: false).setLogOut();
          Navigator.of(context).pop();
    }),
        builder: (context, model, child) => Scaffold(
          floatingActionButton: floating(context, model),
            appBar: AppBar(
              title: Text("Course detail"),
            ),
            body: model.state == ViewState.Busy
                ? Center(child: CircularProgressIndicator())
                : Center(
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text('Curso:${model.courseDetail.name}'),
                      Text('Profesor::${model.courseDetail.professor.name}'),
                      Expanded(child: Container(
                        child:ListView(
                        children: <Widget>[
                          Text("hola")
                        ],

                      ) ,
                      ))
                      
                    ],
                  ))));
  }  Widget floating(BuildContext context, CourseDetailModel model) {
    return FloatingActionButton(
        onPressed: () => _onAdd(context, model),
        tooltip: 'Add task',
        child: new Icon(Icons.add));
  }

  void _onAdd(BuildContext context, CourseDetailModel model) async {
    // try {
    //   await model.addCourse();
    // } catch (err) {
    //   print('upsss ${err.toString()}');
    //   await _buildDialog(context, 'Alert', 'Need to login');
    //   Provider.of<AuthProvider>(context, listen: false).setLogOut();
    // }
  }
    Future<void> _buildDialog(BuildContext context, _title, _message) {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: Text(_title),
          content: Text(_message),
          actions: <Widget>[
            FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        );
      },
      context: context,
    );
  }
}
