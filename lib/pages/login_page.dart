import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:twitter_mask/models/user_model.dart';
import 'package:twitter_mask/service/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text("Twitter Mask"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              margin: const EdgeInsets.only(top: 50, left: 50, right: 50),
              child: Column(
                children: [
                  SizedBox(height: 200, child: Image.asset("assets/logo.jpeg")),
                  const SizedBox(
                    height: 80,
                  ),
                  const Text(
                    '*In order to use the Twitter Mask application, you must log in from twitter.',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 160,
                  ),
                  SignInButton(
                    Buttons.Twitter,
                    text: "Use Twitter to Login",
                    onPressed: () async {
                      UserModel? user = await AuthService.login();
                      Navigator.pushNamed(context, '/Homepage',
                          arguments: user);
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
