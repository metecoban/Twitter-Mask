import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:twitter_mask/models/filter_info_model.dart';

class UserModel {
  String? uID;
  String? uIDForDoc;
  String? username;
  String? photoUrl;
  List? filterInfos = [];
  List? savedTweets = [];

  UserModel(this.uID, this.uIDForDoc, this.username, this.photoUrl,
      this.filterInfos, this.savedTweets);

  Map<String, dynamic> toJson() => {
        'uID': uID,
        'uIDForDoc': uIDForDoc,
        'username': username,
        'photoUrl': photoUrl,
        'filterInfo': filterInfos,
        'savedTweets': savedTweets,
      };

  /* factory UserModel.fromSnapshot(snapshot) {
    return UserModel(
      uID: snapshot["uID"],
      uIDForDoc: snapshot["uIDForDoc"],
      username: snapshot["username"],
      photoUrl: snapshot["photoUrl"],
      filterInfos: snapshot["filterInfos"],
      savedTweets: snapshot["savedTweets"],
    );
  } */
}
