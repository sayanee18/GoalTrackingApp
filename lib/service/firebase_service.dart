import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:goal_tracking_app/models/user_model.dart';

class FirebaseService {
  var db = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> getUserDetails() async {
    final docRef =
        db.collection("users").doc(FirebaseAuth.instance.currentUser!.uid);
    DocumentSnapshot data = await docRef.get();
    return data.data() as Map<String, dynamic>;
  }

  Future<void> setUserModel(UserModel userModel) async {
    final data = userModel.toMap();
    await db
        .collection("users")
        .doc(userModel.userID)
        .set(data, SetOptions(merge: true));
  }
}
