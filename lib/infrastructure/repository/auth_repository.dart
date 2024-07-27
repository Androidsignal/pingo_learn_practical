import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  FirebaseAuth auth = FirebaseAuth.instance;

  AuthRepository();

  User? get user {
    return FirebaseAuth.instance.currentUser;
  }

  Future<void> signOutAuth() async {
    if (auth.currentUser is User) {
      await auth.signOut();
    }
  }

  Future<User?> signUp(String email, String password, String name) async {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  Future<User?> login(String email, String password) async {
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
