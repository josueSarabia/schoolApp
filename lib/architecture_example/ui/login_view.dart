import 'package:f_202010_provider_get_it/architecture_example/base/base_model.dart';
import 'package:f_202010_provider_get_it/architecture_example/base/base_view.dart';
import 'package:f_202010_provider_get_it/architecture_example/ui/signUp_view.dart';
import 'package:f_202010_provider_get_it/architecture_example/viewmodels/auth_provider.dart';
import 'package:f_202010_provider_get_it/architecture_example/viewmodels/loginmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<LoginModel>(
        builder: (context, model, child) => Scaffold(
            body:
                // Provider.of<User>(context, listen: false).logged == true ?  CourseListView() :
                model.state == ViewState.Busy
                    ? Center(child: CircularProgressIndicator())
                    : Center(child: LoginForm(model: model, contextLogin: context,)

                        /*FlatButton(
                      child: Text("Login"),
                      onPressed: () async {
                        var loginSuccess = await model.login();
                        if (loginSuccess) {
                          print('LoginView loginSuccess setting up setLoggedIn ');
                          Provider.of<AuthProvider>(context, listen: false).setLoggedIn(model.user.username,model.user.token);
                        }
                      }),*/
                        )));
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

class LoginForm extends StatefulWidget {
  LoginModel model;
  BuildContext contextLogin;
  LoginForm({this.model, this.contextLogin});
  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  String user;
  String password;
  bool rememberSession = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Log in'),
        ),
        body: Form(
            key: _formKey,
            child: Column(children: <Widget>[
              // Add TextFormFields and RaisedButton here.
              TextFormField(
                // The validator receives the text that the user has entered.
                initialValue: Provider.of<AuthProvider>(this.widget.contextLogin, listen: false)
                        .rememberSession
                    ? Provider.of<AuthProvider>(this.widget.contextLogin, listen: false).email
                    : '',
                decoration: const InputDecoration(
                  labelText: 'Email',
                  icon: Icon(Icons.email),
                ),
                validator: (value) {
                  this.user = value;
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }

                  return null;
                },
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  icon: Icon(Icons.lock),
                ),
                validator: (value) {
                  this.password = value;
                  if (value.trim().isEmpty) {
                    return 'Password is required';
                  }

                  return null;
                },
              ),
              CheckboxListTile(
                title: Text('Remember me'),
                value: rememberSession,
                onChanged: (bool value) {
                  setState(() {
                    rememberSession = !rememberSession;
                  });
                },
                //secondary: const Icon(Icons.hourglass_empty),
              ),
              RaisedButton(
                onPressed: () async {
                  // Validate returns true if the form is valid, otherwise false.
                  if (_formKey.currentState.validate()) {
                    var loginSuccess =
                        await this.widget.model.login(this.user, this.password);
                    if (loginSuccess) {
                      //print('LoginView loginSuccess setting up setLoggedIn ');
                      Provider.of<AuthProvider>(this.widget.contextLogin, listen: false)
                          .setLoggedIn(
                              this.widget.model.user.username,
                              this.widget.model.user.token,
                              this.user,
                              this.rememberSession);
                    }
                  }
                },
                child: Text('Submit'),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpView()));
                },
                child: Text('Sing up'),
              )
            ])));
  }
}
