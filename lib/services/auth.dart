//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:padvisor/models/Users.dart';
import 'package:padvisor/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserModel? _userFromFirebaseUser(User? user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  Stream<UserModel?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  get userID => _auth.currentUser?.uid;

  //sign in with email and pass
  Future singInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential? result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      return _userFromFirebaseUser(user);
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

  Future registerWithEmailAndPassword(String name, String email,
      String password, String cohort, String phonenum, String advisorID) async {
    try {
      UserCredential? result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      await DatabaseService(uid: user!.uid).updateUserData(Student(
          role: 'student',
          name: name,
          cohort: cohort,
          phonenum: phonenum,
          advisorID: advisorID,
          archive: false));
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
