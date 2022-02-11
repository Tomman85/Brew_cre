import 'package:brew_crew/presentation/common/models/brew.dart';
import 'package:brew_crew/presentation/screens/authenticate/components/auth.dart';
import 'package:brew_crew/presentation/screens/authenticate/components/database.dart';
import 'package:brew_crew/presentation/screens/home/components/settings_form.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/brew_list.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();
  final DatabaseService _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 60.0,
              ),
              child:  SettingsForm(),
            );
          });
    }

    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: [
          TextButton.icon(
            onPressed: () async {
              await _auth.signOut();
            },
            icon: Icon(
              Icons.person,
              color: Colors.brown.shade900,
            ),
            label: Text(
              'Logout',
              style: TextStyle(color: Colors.brown.shade900),
            ),
          ),
          TextButton.icon(
            onPressed: () => _showSettingsPanel(),
            icon: Icon(Icons.settings),
            label: Text('settings'),
            style: TextButton.styleFrom(primary: Colors.brown[900]),
          )
        ],
        title: Text('Brew Crew'),
      ),
      body: BrewList(),
    );
  }
}
