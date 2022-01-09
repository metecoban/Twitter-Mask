//import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:twitter_mask/models/user_model.dart';
import 'package:twitter_mask/service/api_infos.dart';
//import 'package:http/http.dart' as http;

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future login() async {
    final twitterLogin = TwitterLogin(
      /// Consumer API keys
      apiKey: APIInfo.apiKey,
      apiSecretKey: APIInfo.apiSecretKey,
      redirectURI: APIInfo.redirectURI,
    );

    final authResult = await twitterLogin.login();
    switch (authResult.status) {
      case TwitterLoginStatus.loggedIn:
        // success
        debugPrint('====== Login success ======');
        final twitterAuthCredential = TwitterAuthProvider.credential(
          accessToken: authResult.authToken!,
          secret: authResult.authTokenSecret!,
        );

        await _auth.signInWithCredential(twitterAuthCredential);

        final User? user = _auth.currentUser;

        //debugPrint(user?.providerData[0].uid.toString());

        UserModel.username = user?.displayName.toString();
        UserModel.photoUrl = user?.photoURL.toString();
        final uid = user?.uid;
        _firestore.collection('users').doc(uid).set({
          "username": user?.displayName.toString(),
          "SavedTweets": null,
        });

        /* const _authority = "api.twitter.com";
        const _path =
            "/2/users/by/username/meteC0ban"; // here it will be with id 
        const _params = {"user.fields": "id"};
        final _bearer = APIInfo.bearer.toString();

        final _uri = Uri.https(_authority, _path, _params);
        final response = await http.get(
          _uri,
          headers: {'Authorization': 'Bearer $_bearer'},
        );
        if (response.statusCode == 200) {
          var decoded = json.decode(response.body);
          debugPrint(decoded.toString());
        } */
        break;
      case TwitterLoginStatus.cancelledByUser:
        // cancel
        debugPrint('====== Login cancel ======');
        break;
      case TwitterLoginStatus.error:
      case null:
        // error
        debugPrint('====== Login error ======');
        break;
    }
  }
}
