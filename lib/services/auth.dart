import 'package:firebase_auth/firebase_auth.dart';
import 'package:yabber/models/AuthenticatedUser.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create user object based on FirebaseUser
  AuthenticatedUser? _userFromFirebaseUser(User user) {
    // ignore: unnecessary_null_comparison
    return user != null ? AuthenticatedUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<AuthenticatedUser?> get user {
    return _auth.userChanges()
      .map((User? user) => _userFromFirebaseUser(user!));
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // sign in with email & password

  // register with email & password

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

}
