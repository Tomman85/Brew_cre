import 'package:brew_crew/presentation/common/models/user.dart';
import 'package:brew_crew/presentation/screens/authenticate/authenticate.dart';
import 'package:brew_crew/presentation/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<myUser?>(context);

    //return either Home or Authentiacate Widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
