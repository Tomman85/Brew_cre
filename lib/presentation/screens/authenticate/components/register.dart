import 'package:brew_crew/presentation/common/constants/constants.dart';
import 'package:brew_crew/presentation/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';

import 'auth.dart';

class Register extends StatefulWidget {
  final Function toogleView;

  const Register({Key? key, required this.toogleView}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final Authenticate _authenticate = Authenticate();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              centerTitle: false,
              leadingWidth: 0,
              actions: [
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      widget.toogleView();
                    });
                  },
                  style: TextButton.styleFrom(primary: Colors.brown[900]),
                  icon: Icon(Icons.person),
                  label: Text('Sign In'),
                ),
              ],
              title: Text(
                'Sign up to Brew Crew',
                textAlign: TextAlign.left,
              ),
            ),
            body:loading
                ? Center(child: CircularProgressIndicator(color: Colors.pink),)
                : Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (val) {
                        if (val?.length == 0) {
                          return 'Enter a email';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      validator: (val) {
                        if (val == null || val.length < 6) {
                          return "Enter the password 6+ chars long ";
                        }
                        return null;
                      },
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() == true) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await _auth
                              .registerWithEmailAndPassword(email, password);

                          if (result == null) {
                            setState(() {
                              loading = false;
                              error = 'please supply a valid email';
                            });
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.pink),
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
