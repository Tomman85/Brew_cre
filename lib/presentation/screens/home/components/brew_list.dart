import 'package:brew_crew/presentation/common/models/brew.dart';
import 'package:brew_crew/presentation/screens/authenticate/components/database.dart';
import 'package:flutter/material.dart';

class BrewList extends StatefulWidget {
  const BrewList({Key? key}) : super(key: key);

  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  DatabaseService _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Brew>>(
      stream: _databaseService.brewListFromSnapshot(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final users = snapshot.data;
          print(users);
          return ListView(
            children: users!.map(buildUser).toList(),
          );
        } else if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget buildUser(Brew user) {
    return Padding(
    padding: const EdgeInsets.only(top:8.0),
    child: Card(
      margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
      child: ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.brown[user.strength],
            ),
            title: Text(user.name),
        subtitle: Text('Takes ${user.sugars} sugars(s)'),
          ),
    ),
  );
  }
}

