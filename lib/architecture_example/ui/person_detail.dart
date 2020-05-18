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
              title: Text("Person detail"),
            ),
            body: model.state == ViewState.Busy
                ? Center(child: CircularProgressIndicator())
                : Center(
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text('Name:${model.personDetail.name}'),
                      Text('Email::${model.personDetail.email}')
                    ],
                  ))));
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
