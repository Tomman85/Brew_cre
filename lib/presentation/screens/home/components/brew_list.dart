import 'package:brew_crew/presentation/common/models/brew.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'brew_tile.dart';

class BrewList extends StatefulWidget {
  const BrewList({Key? key}) : super(key: key);

  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context);
print(brews);
    return ListView.builder(
      itemBuilder: (ctx, i) {
        return BrewTile(brew: brews[i]);
      },
      itemCount: brews.length,
    );
  }
}
