import 'package:brew_crew/presentation/screens/authenticate/components/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
   Home({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: [
          TextButton.icon(
            onPressed: () async{await _auth.signOut();},
            icon: Icon(
              Icons.person,
              color: Colors.brown.shade900,
            ),
            label: Text(
              'Logout',
              style: TextStyle(color: Colors.brown.shade900),
            ),
          )
        ],
        title: Text('Brew Crew'),
      ),
      body: Container(
        child: Text('Home'),
      ),
    );
  }
}
