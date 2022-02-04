import 'package:brew_crew/presentation/common/models/user.dart';
import 'package:brew_crew/presentation/screens/authenticate/components/auth.dart';
import 'package:brew_crew/presentation/screens/home/home.dart';
import 'package:brew_crew/presentation/screens/wrapper/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<myUser?>.value(
      initialData: null,
      catchError: (_, __) {},
      value: AuthService().user,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Wrapper(),
      ),
    );
  }
}
