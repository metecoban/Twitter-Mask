import 'package:flutter/material.dart';
import 'package:twitter_mask/models/user_model.dart';
import 'package:twitter_mask/service/firebase_operations.dart';

class ArchivePage extends StatefulWidget {
  const ArchivePage({Key? key, this.user}) : super(key: key);
  final UserModel? user;

  @override
  _ArchivePageState createState() => _ArchivePageState();
}

class _ArchivePageState extends State<ArchivePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Tweet Archive"),
      ),
      body: Container(
        margin: const EdgeInsets.all(5),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 20,
                child: ListTile(
                  onTap: () {
                    debugPrint('side${index + 1}');
                  },
                  trailing: IconButton(
                    onPressed: () {
                      //tweeti silme
                      widget.user!.savedTweets!
                          .remove(widget.user!.savedTweets![index]);

                      FirebaseOperation.setValues(widget.user);
                      setState(() {});
                    },
                    icon: const Icon(Icons.delete),
                  ),
                  title: Text(widget.user!.savedTweets![index]["text"]),
                ),
              ),
            );
          },
          itemCount: widget.user!.savedTweets!.length,
        ),
      ),
    );
  }
}
