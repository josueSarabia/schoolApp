import 'package:f_202010_provider_get_it/architecture_example/base/base_model.dart';
import 'package:f_202010_provider_get_it/architecture_example/base/base_view.dart';
import 'package:f_202010_provider_get_it/architecture_example/viewmodels/auth_provider.dart';
import 'package:f_202010_provider_get_it/architecture_example/viewmodels/signUpModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<SignUpModel>(
        builder: (context, model, child) => Scaffold(
            body:
                // Provider.of<User>(context, listen: false).logged == true ?  CourseListView() :
                model.state == ViewState.Busy
                    ? Center(child: CircularProgressIndicator())
                    : Center(child: SignUpForm(model: model, contextSignUp: context,)

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

class SignUpForm extends StatefulWidget {
  SignUpModel model;
  BuildContext contextSignUp;
  SignUpForm({this.model, this.contextSignUp});
  @override
  SignUpFormState createState() => SignUpFormState();
}

class SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  String password;
  String username;
  String name;
  String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign up'),
        ),
        body: Form(
            key: _formKey,
            child: Column(children: <Widget>[
              // Add TextFormFields and RaisedButton here.
              TextFormField(
                // The validator receives the text that the user has entered.
                decoration: const InputDecoration(
                  icon: Icon(Icons.account_circle),
                  labelText: 'Name',
                ),
                validator: (value) {
                  this.name = value;
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                // The validator receives the text that the user has entered.
                decoration: const InputDecoration(
                  icon: Icon(Icons.people),
                  labelText: 'User name',
                ),
                validator: (value) {
                  this.username = value;
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                // The validator receives the text that the user has entered.
                decoration: const InputDecoration(
                  icon: Icon(Icons.email),
                  labelText: 'Email',
                ),
                validator: (value) {
                  this.email = value;
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  icon: Icon(Icons.lock),
                  labelText: 'Password',
                ),
                validator: (value) {
                  this.password = value;
                  if (value.trim().isEmpty) {
                    return 'Password is required';
                  }
                  return null;
                },
              ),
              RaisedButton(
                onPressed: () async {
                  // Validate returns true if the form is valid, otherwise false.
                  if (_formKey.currentState.validate()) {
                    var signUpSuccess = await this.widget.model.signUp(
                        this.email, this.password, this.username, this.name);
                    if (signUpSuccess) {
                      //print('LoginView loginSuccess setting up setLoggedIn ');
                      Provider.of<AuthProvider>(this.widget.contextSignUp, listen: false)
                          .setLoggedIn(this.widget.model.user.username,
                              this.widget.model.user.token, this.email, false);
                      Navigator.pop(this.widget.contextSignUp);
                    }
                  }
                },
                child: Text('Submit'),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Log in'),
              )
            ])));
  }
}
