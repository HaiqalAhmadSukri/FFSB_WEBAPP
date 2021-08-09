import 'package:flutter/material.dart';
import 'package:tolonglah/services/auth.dart';
import 'package:tolonglah/services/database.dart';
import 'package:tolonglah/shared/constants.dart';
import 'package:tolonglah/shared/loading.dart';

class Register extends StatefulWidget {
  const Register({Key? key, required this.toggleView}) : super(key: key);

  final Function toggleView;
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String confirmPassword = '';
  String error = '';
  String username = '';
  String firstName = '';
  String lastName = '';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Loading();
    } else {
      return Center(
        child: Scaffold(
            backgroundColor: Colors.amber[200],
            appBar: AppBar(
              backgroundColor: Colors.amber[400],
              elevation: 0.0,
              title: Text('Sign Up to FFSB'),
              actions: <Widget>[
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(primary: Colors.amber),
                  onPressed: () {
                    widget.toggleView();
                  },
                  icon: Icon(Icons.person),
                  label: Text('Sign In'),
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                  key: _formKey,
                  // ignore: prefer_const_literals_to_create_immutables
                  child: Column(
                    children: <Widget>[
                      // ignore: prefer_const_constructors
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                          hintText: 'Email',
                        ),
                        validator: (val) =>
                            val!.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                          hintText: 'Username',
                        ),
                        validator: (val) =>
                            val!.isEmpty ? 'Enter a username' : null,
                        onChanged: (val) {
                          setState(() {
                            username = val;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                          hintText: 'First Name',
                        ),
                        validator: (val) =>
                            val!.isEmpty ? 'Enter an name' : null,
                        onChanged: (val) {
                          setState(() {
                            firstName = val;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                          hintText: 'Last Name',
                        ),
                        validator: (val) =>
                            val!.isEmpty ? 'Enter a name' : null,
                        onChanged: (val) {
                          setState(() {
                            lastName = val;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                          hintText: 'Password',
                        ),
                        validator: (val) => val!.length < 6
                            ? 'Password must be more than 5 characters'
                            : null,
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                        obscureText: true,
                      ),
                      SizedBox(height: 20),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                          hintText: 'Confirm Password',
                        ),
                        validator: (val) =>
                            val != password ? 'Password not the same' : null,
                        onChanged: (val) {
                          setState(() {
                            confirmPassword = val;
                          });
                        },
                        obscureText: true,
                      ),
                      ElevatedButton.icon(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });
                              dynamic result =
                                  await _auth.registerWithEmailAndPassword(
                                      email, password);
                              dynamic result2 = await DatabaseService('users')
                                  .registerNewUser(
                                      username, email, firstName, lastName);
                              if (result == null) {
                                setState(() {
                                  error = 'Please supply a valid email';
                                  loading = false;
                                });
                              }
                            }
                          },
                          icon: Icon(Icons.person_add),
                          label: Text('Register')),
                      SizedBox(height: 12),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      )
                    ],
                  )),
            )),
      );
    }
  }

  TextFormField formFieldMethod(
      String hintText, var field, String error, var validate) {
    return TextFormField(
      decoration: textInputDecoration.copyWith(
        hintText: hintText,
      ),
      validator: (val) => val != field ? 'Password not the same' : null,
      onChanged: (val) {
        setState(() {
          field = val;
        });
      },
      obscureText: true,
    );
  }
}
