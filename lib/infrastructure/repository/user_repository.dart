import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/user_model.dart';

class UserRepository {
  UserRepository();

  User? get user {
    return FirebaseAuth.instance.currentUser;
  }

  Future<void> setUser({required UserModel model}) async {
    await FirebaseFirestore.instance.collection('Users').doc(model.id).set(model.toJson());
  }

  Future<UserModel?> getUser({required String id}) async {
    final snapshot = await FirebaseFirestore.instance.collection('Users').doc(id).get();
    if (snapshot.exists) {
      return UserModel.fromJson(snapshot.data()!);
    }
    return null;
  }

}
