import 'package:firebase_auth/firebase_auth.dart';

import '../../../common/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

//create user obj based on Firebase
  myUser? _userFromFirebase(User user) {
    return user != null ? myUser(uid: user.uid) : null;
  }

//sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;

      return _userFromFirebase(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
//sign in email and password

//register with email and password

//sign out

}
