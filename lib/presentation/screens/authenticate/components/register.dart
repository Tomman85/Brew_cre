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

  final Authenticate _authenticate = Authenticate();
  //text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        centerTitle: false,
        leadingWidth: 0,
        actions: [
          TextButton.icon(
            onPressed: widget.toogleView(),
            style: TextButton.styleFrom(primary: Colors.brown[900]),
            icon: Icon(Icons.person),
            label: Text('Register'),
          ),
        ],
        title: Text('Sign up to Brew Crew',textAlign: TextAlign.left,),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              TextFormField(onChanged: (val) {
                setState(() {
                  email = val;
                });
              }),
              SizedBox(
                height: 20,
              ),
              TextFormField(
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
                  print(email);
                  print(password);
                },
                style: ElevatedButton.styleFrom(primary: Colors.pink),
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
