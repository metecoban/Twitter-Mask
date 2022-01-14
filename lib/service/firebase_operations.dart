import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:twitter_mask/models/user_model.dart';

class FirebaseOperation {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<UserModel?> getValues() async {
    User? curUser = _auth.currentUser;
    try {
      var response = await _firestore
          .collection('users')
          .doc(curUser!.uid.toString())
          .get();
      var user = response.data();

      return UserModel(user!["uID"], user["uIDForDoc"], user["username"],
          user["photoUrl"], user["filterInfo"], user["savedTweets"]);
    } catch (e) {
      return setValues(UserModel(curUser!.providerData[0].uid.toString(),
          curUser.uid, curUser.displayName, curUser.photoURL, [], []));
    }
  }

  static UserModel setValues(UserModel? user) {
    _firestore.collection('users').doc(user!.uIDForDoc).set(user.toJson());
    return user;
  }
}
