import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twitter_mask/models/user_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, this.user}) : super(key: key);
  final UserModel? user;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text("Profile"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20),
                height: 200,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(widget.user!.photoUrl
                        .toString()
                        .replaceAll("_normal", "")),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                child: Center(
                  child: Text(
                    widget.user!.username.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/ArchivePage',
                      arguments: widget.user);
                },
                child: const Text("Tweet Archive"),
              ),
              const SizedBox(height: 270),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text("Log out"),
              ),
            ],
          ),
        ));
  }
}
