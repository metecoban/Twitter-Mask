import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:twitter_mask/models/user_model.dart';
import 'package:twitter_mask/service/api_infos.dart';
import 'package:twitter_mask/service/firebase_operations.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<UserModel?> login() async {
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

        return await FirebaseOperation.getValues();
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
