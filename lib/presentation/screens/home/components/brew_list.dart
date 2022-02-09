import 'package:brew_crew/presentation/common/models/brew.dart';
import 'package:brew_crew/presentation/screens/authenticate/components/database.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'brew_tile.dart';

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
          // print(user);
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
  Widget buildUser(Brew user) => ListTile(
    leading: CircleAvatar(
      child: Text(user.sugars),
    ),
    title: Text(user.name),
    subtitle: Text('${user.strength}'),
  );
}
