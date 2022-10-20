import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:project_management/domain/model/login_user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user based on firebaseUser
  LoginUser _firebaseUser(User? user) {
    if (user != null) {
      return LoginUser(uid: user.uid);
    }
    return LoginUser(uid: null);
  }

  //get user from stream
  Stream<LoginUser> get loginUser {
    return _auth.authStateChanges().map(_firebaseUser);
  }

  // sign in as anonymously
  Future signInAnonymous() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? signInUser = result.user;
      return _firebaseUser(signInUser);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  // register with email and password
  Future register(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return _firebaseUser(result.user);
    } catch (e) {
      rethrow;
    }
  }

  //sign in with email and password
  Future SignInWithEmailAndPass(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return _firebaseUser(result.user);
    } catch (e) {
      rethrow;
    }
  }

  // sign out
  Future signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
