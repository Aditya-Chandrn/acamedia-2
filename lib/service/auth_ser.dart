import 'package:acamedia/helper/helper_functions.dart';
import 'package:acamedia/service/db_ser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //Login function
  Future loginUser(String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future registerUser(String name, String email, String password) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email.toString().trim(), password: password))
          .user!;

      if (user != null) {
        await DatabaseService(uid: user.uid).updateData(name, email);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //signOut

  Future signOut() async {
    try {
      await helperFunctions.saveLoginStatus(false);
      await helperFunctions.saveEmailSF("");
      await helperFunctions.saveUserNameSF("");
      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }
}
