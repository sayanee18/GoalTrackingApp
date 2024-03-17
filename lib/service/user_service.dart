import 'package:firebase_auth/firebase_auth.dart';
import 'package:goal_tracking_app/models/user_model.dart';

class UserService {
  Future<UserCredential?> loginUser(String email, String password) async {
    try {
      UserCredential credential;
      credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      throw Exception(e);
    }
    return null;
  }
}

Future<UserCredential?> singUpUser(String email, String password) async {
  try {
    UserCredential credential;
    credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  } catch (e) {
    throw Exception(e);
  }
  return null;
}

UserModel createNewuser(UserCredential userCredential) {
  return UserModel(
      completed: [],
      email: userCredential.user!.email!,
      name: "",
      pending: [],
      userID: userCredential.user!.uid);
}

// UserModel getUser(UserCredential userCredential) {

// }
