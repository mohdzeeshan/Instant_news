import 'package:firebase_auth/firebase_auth.dart';

class firebaseService {
  final FirebaseAuth _firebaseAuth;

  firebaseService(this._firebaseAuth);

  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseException catch (e) {
      print(e.message);
      return e.message;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String> signUp({String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseException catch (e) {
      print(e.message);
      return e.message;
    }
  }

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<bool> isLoggedIn() async {
    if (_firebaseAuth.currentUser != null)
      return true;
    else
      return false;
  }

  Future<String> loggedInUser() async {
    User user = await _firebaseAuth.currentUser;
    return user.email;
  }
}
