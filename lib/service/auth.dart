import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:twitter_mask/service/api_infos.dart';

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
        final uid = user?.uid;
        _firestore.collection('users').doc(uid).set({
          "username": user?.displayName.toString(),
          "SavedTweets": null,
        });

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
