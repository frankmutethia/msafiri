import 'package:flutter/material.dart';
import 'package:msafiri/screens/signup_screen.dart';
import 'package:msafiri/services/auth_services.dart';

class LoginScreen extends StatefulWidget {
  static final String id = "login_screen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email, _password;
  // code ya Kuvalidate forms
  final _formKey = GlobalKey<FormState>();

  //Method ya  kuvalidate form na Signup user
  _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      // Hapa Tunacall class auth_service.dart ndio tuchukue details za kulogin
      AuthService.login(context,_email, _password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            height: 270.0,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(top: 100.0, left: 50.0),
              child: Text(
                'Login Page',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
            color: Colors.blueGrey,
          ),
          Form(
              key: _formKey,
              child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 10.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 13.0,
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (email) =>
                      !email.contains('@') ? 'Email is invalid' : null,
                  onSaved: (email) => _email = email,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 10.0),
                child: TextFormField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 13.0,
                    ),
                  ),
                  obscureText: true,
                  validator: (password) => password.length < 5
                      ? 'Password mut be atleast 5 characters'
                      : null,
                  onSaved: (password) => _password = password,
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Container(
                width: 340.0,
                height: 45.0,
                child: FlatButton(
                  onPressed: () {


                  _submit();


                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.0)),
                  color: Colors.blueGrey,
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 15.0, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Don't have and Account?"),
                  FlatButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, SignUpScreen.id);
                      },
                      child: Text('Sign Up')),
                ],
              ),
            ],
          ))
        ],
      ),
    );
  }
}
 