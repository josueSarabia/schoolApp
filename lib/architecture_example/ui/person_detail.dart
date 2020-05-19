import 'package:f_202010_provider_get_it/architecture_example/base/base_model.dart';
import 'package:f_202010_provider_get_it/architecture_example/base/base_view.dart';
import 'package:f_202010_provider_get_it/architecture_example/viewmodels/auth_provider.dart';
import 'package:f_202010_provider_get_it/architecture_example/viewmodels/personModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonDetail extends StatelessWidget {
  final int personId;
  final String personType;
  PersonDetail({this.personId, this.personType});
  @override
  Widget build(BuildContext context) {
    return BaseView<PersonModel>(
        onModelReady: (model) => model
                .getPersonDetail(
                    Provider.of<AuthProvider>(context).username,
                    Provider.of<AuthProvider>(context).token,
                    personId,
                    personType)
                .catchError((error) async {
              print("getPersonDetail got error: " + error);
              await _buildDialog(context, 'Alert', 'Need to login');
              Provider.of<AuthProvider>(context, listen: false).setLogOut();
              Navigator.of(context).pop();
            }),
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              title: Text("Information"),
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
                                      image: NetworkImage(
                                    ('https://www.kindpng.com/picc/m/24-248253_user-profile-default-image-png-clipart-png-download.png'),
                                  ))),
                            ),
                            ListTile(
                              title: Center(
                                  child: Text(
                                'Name: ${model.personDetail.name}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                              subtitle: Center(
                                  child: Text(
                                      'Email: ${model.personDetail.email}')),
                            ),
                          ],
                        )),
                        Expanded(
                          child: Card(
                              child: Container(
                                  padding: new EdgeInsets.all(11.0),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text('About',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey)),
                                        ),
                                        Divider(color: Colors.grey),
                                        Center(
                                            child: Container(
                                                padding: EdgeInsets.all(35.0),
                                                child: Column(
                                                  children: <Widget>[
                                                    
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(15.0),
                                                      child:
                                                          Text('Username: ${model.personDetail.username} '),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(15.0),
                                                      child:
                                                          Text('Phone: ${model.personDetail.phone}'),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(15.0),
                                                      child:
                                                          Text('City: ${model.personDetail.city}'),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(15.0),
                                                      child:
                                                          Text('Country: ${model.personDetail.country}'),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(15.0),
                                                      child:
                                                          Text('Birthday: ${model.personDetail.birthday}'),
                                                    ),
                                                  ],
                                                )))
                                      ]))),
                        )
                      ]))));
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
