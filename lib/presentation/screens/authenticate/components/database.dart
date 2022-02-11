import 'package:brew_crew/presentation/common/models/brew.dart';
import 'package:brew_crew/presentation/common/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});

  // collection reference
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String? sugars, String? name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  //brew list from snapshot
  Stream<List<Brew>> brewListFromSnapshot() =>
      brewCollection.snapshots().map((doc) => doc.docs
          .map((doc) => Brew.fromJson(doc.data() as Map<String, dynamic>))
          .toList());

// Stream< List<Brew>> _brewListFromSnapshot(QuerySnapshot snapshot) {
//    return snapshot.docs.map((doc) {
//      print("totu");
//      print(brewCollection.doc().get());
//      return Brew(
//        name: doc.get('name') ?? '',
//        strength: doc.get('sugsdwars') ?? 0,
//        sugars: doc.get('strength') ?? '0',
//      );
//    }).toList();
//  }

//get brews streams
// Stream<List<Brew>> get brews {
//   print(brewCollection.snapshots().map(brewListFromSnapshot));
//   return brewCollection.snapshots().map(brewListFromSnapshot);
// }

  //Userdata from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.get('name'),
        sugars: snapshot.get('sugars'),
        strength: snapshot.get('strength'));
  }

//get user doc Stream
  Stream<UserData> get userData {


    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
