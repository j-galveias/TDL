import 'package:CCU/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User getCurrentUser() {
    return _auth.currentUser!;
  }

  Stream<User?> get user {
    return _auth.userChanges();
  }

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
      String email, String password, String name, String licensePlate) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      user.updateDisplayName(name);
      //create new document for the user with uid
      await DatabaseService(uid: user.uid).createUserData(name, email, licensePlate);

      return await user.reload().then((value) { return user;});
      //return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  Future registerEmailAndPasswordPolice() async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: "police@mail.com", password: "123456");
      User user = result.user!;
      user.updateDisplayName("Police");
      //create new document for the user with uid
      await DatabaseService(uid: user.uid).createPoliceUserData();

      return await user.reload().then((value) { return user;});
      //return user;
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
      print("--------------++++++++++++++++++++");
      print(e.toString());
      return null;
    }
  }
}
