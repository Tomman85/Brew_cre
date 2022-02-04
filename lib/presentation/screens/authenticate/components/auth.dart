import 'package:firebase_auth/firebase_auth.dart';

import '../../../common/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

//create user obj based on Firebase
  myUser? _userFromFirebase(User user) {
    return user != null ? myUser(uid: user.uid) : null;
  }

  // auth change using stream
  Stream<myUser?>get user{
    return _auth.authStateChanges()
        .map((User? user) => _userFromFirebase(user!));
    // .map(_userFromFirebase); to mi jakos nie dzialo

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
  Future signOut()async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;

    }
  }


}
