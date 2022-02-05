import 'package:brew_crew/presentation/screens/authenticate/components/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../common/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

//create user obj based on Firebase
  myUser? _userFromFirebase(User user) {
    return myUser(uid: user.uid);
  }

  // auth change using stream
  Stream<myUser?> get user {
    return _auth
        .authStateChanges()
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
  Future signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user =result.user;
      return _userFromFirebase(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      await DatabaseService(uid: user?.uid).updateUserData(
          '0', 'New crew member', 100);
      return _userFromFirebase(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
