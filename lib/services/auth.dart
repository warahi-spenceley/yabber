import 'package:firebase_auth/firebase_auth.dart';
import 'package:yabber/models/SignedInUser.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create user object based on FirebaseUser
  SignedInUser? _userFromFirebaseUser(User user) {
    // ignore: unnecessary_null_comparison
    return user != null ? SignedInUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<SignedInUser?> get user {
    return _auth.userChanges()
      .map((User? user) => _userFromFirebaseUser(user!));
  }

  // FirebaseAuth.instance
  // .userChanges()
  // .listen((User? user) {
  //   if (user == null) {
  //     print('User is currently signed out!');
  //   } else {
  //     print('User is signed in!');
  //   }
  // });

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

}
