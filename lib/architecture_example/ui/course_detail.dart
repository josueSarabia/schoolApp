import 'package:f_202010_provider_get_it/architecture_example/base/base_model.dart';
import 'package:f_202010_provider_get_it/architecture_example/base/base_view.dart';
import 'package:f_202010_provider_get_it/architecture_example/ui/person_detail.dart';
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
                      Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(('https://akm-img-a-in.tosshub.com/indiatoday/images/story/201811/online-3412473_1920_1.jpeg?tz.RfsTe_UTLHiDqxmpG7PY_nTIBjwF7'),)
)
              ),
            ),
            ListTile(
              
              title: Text('Curso:${model.courseDetail.name}'),
              subtitle:  Text('Profesor:${model.courseDetail.professor.name}'),
            ),
            ButtonBar(

              alignment: MainAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                  child: const Text('Profesor details'),
                  onPressed: () {
                    getDetail(context, model.courseDetail.professor.id, 'profesor');

                  },
                ),
                
              ],
            ),
          ],
        ),
      ),
                      
                     
                      Expanded(child: Container(
                        child:ListView(
                        children: model.courseDetail.students.map((p){
                         return  Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.person),
              title: Text(p.name),
              subtitle: Text('Correo: ${p.email}'),
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text('get details'),
                  onPressed: () {
                    getDetail(context, p.id, 'student');
                  },
                ),
                
              ],
            ),
          ],
        ),
      );

                        }).toList(),

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

  void getDetail(BuildContext context, int personId, String personType) async {
    
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => PersonDetail(personId: personId, personType: personType)),
    );
  }

  void _onAdd(BuildContext context, CourseDetailModel model) async {
    try {
       
      await model.addStudent(Provider.of<AuthProvider>(context,listen: false).username,
        Provider.of<AuthProvider>(context,listen: false).token,this. courseId);
    } catch (err) {
      
      print('upsss ${err.toString()}');
      Provider.of<AuthProvider>(context, listen: false).setLogOut();
      await _buildDialog(context, 'Alert', 'Need to login');
      Navigator.of(context).pop();
      
    }
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
