import 'package:brew_crew/presentation/common/constants/constants.dart';
import 'package:brew_crew/presentation/common/models/user.dart';
import 'package:brew_crew/presentation/screens/authenticate/components/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String? _currentName;

  String? _currentSugars;

  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<myUser>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData? userData = snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  'Update your brew settings',
                  style: TextStyle(fontSize: 18.0),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  initialValue: _currentName ?? userData?.name,
                  decoration: textInputDecoration,
                  validator: (val) {
                    if (val == null) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                  onChanged: (val) => setState(() {
                    _currentName = val;
                  }),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                //dropdown
                DropdownButtonFormField(
                  value: _currentSugars ?? userData?.sugars,
                  decoration: textInputDecoration,
                  onChanged: (val) => setState(() {
                    _currentSugars = val.toString();
                  }),
                  items: sugars.map((sugar) {
                    return DropdownMenuItem(
                      child: Text('$sugar sugars'),
                      value: sugar,
                    );
                  }).toList(),
                ),
                //slider
                Slider(
                  min: 100,
                  max: 900,

                  activeColor: Colors.brown[_currentStrength ?? userData!.strength],
                  inactiveColor: Colors.brown[_currentStrength ?? userData!.strength],
                  value: (_currentStrength ?? userData!.strength).toDouble(),
                  onChanged: (val) => setState(() {
                    _currentStrength = val.round();
                  }),
                  divisions: 8,
                ),
                ElevatedButton(
                  onPressed: () async {
                    _currentStrength ??= userData?.strength;
                    _currentName ??= userData?.name;
                    _currentSugars ??= userData?.sugars;
                    await DatabaseService(uid: user.uid).updateUserData(
                        _currentSugars!, _currentName!, _currentStrength!);

                    Navigator.pop(context);
                  },
                  child: Text('Update'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pink[400],
                  ),
                ),
              ],
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
