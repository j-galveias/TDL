import 'package:CCU/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User getCurrentUser() {
    print(_auth.currentUser?.uid);
    return _auth.currentUser!;
  }

  Stream<User?> get user {
    return _auth.userChanges();
  }

  //sign in with google account
  /*Future signInWithGoogle() async {
    try {
      GoogleSignInAccount googleUser = await _googleSignIn.!signIn();
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential result = await _auth.signInWithCredential(credential);
      User user = result.user;

      if (result.additionalUserInfo.isNewUser) {
        //create new document for the user with uid
        await DatabaseService(uid: user.uid).createUserData();
      }
      print(user);
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }*/

  //sign in with email and password
  Future signInEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future registerEmailAndPassword(
      String email, String password, String name) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      user?.updateDisplayName(name);
      user?.updatePhotoURL('https://firebasestorage.googleapis.com/v0/b/balcoes-79acf.appspot.com/o/avatarIconGrande.png?alt=media&token=b6af58cc-087c-4ab6-aa42-728a2294e98a');
      //create new document for the user with uid
      await DatabaseService(uid: user!.uid).createUserData();

      return user;
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
