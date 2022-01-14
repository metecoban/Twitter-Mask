import 'package:flutter/material.dart';
import 'package:twitter_mask/models/tweets_model.dart';
import 'package:twitter_mask/models/user_model.dart';
import 'package:twitter_mask/service/api_operations.dart';
import 'package:twitter_mask/service/firebase_operations.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key, this.user}) : super(key: key);
  final UserModel? user;

  @override
  _HomepageState createState() => _HomepageState();
}

List<TweetModel>? tweetList = [];

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    asyncMethod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        title: const Text("Twitter Mask"),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 7),
            child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/ProfilePage',
                      arguments: widget.user);
                },
                icon: CircleAvatar(
                  backgroundImage:
                      NetworkImage(widget.user!.photoUrl.toString()),
                )),
          )
        ],
      ),
      body: Container(
          margin: const EdgeInsets.all(5),
          child: (tweetList!.isNotEmpty)
              ? ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 20,
                        child: ListTile(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                      title: Text(tweetList![index].text),
                                      content: Text("Like Count: " +
                                          tweetList![index].like +
                                          " Retweet Count: " +
                                          tweetList![index].rt),
                                    ));
                          },
                          trailing: IconButton(
                            onPressed: () {
                              widget.user!.savedTweets!.add({
                                "text": tweetList![index].text,
                                "id": tweetList![index].id
                              });
                              FirebaseOperation.setValues(widget.user);
                            },
                            icon: const Icon(Icons.save_alt_outlined),
                          ),
                          title: Text(tweetList![index].text.toString()),
                        ),
                      ),
                    );
                  },
                  itemCount: tweetList!.length,
                )
              : const Center(
                  child: Text(
                  "No matching data",
                  style: TextStyle(fontSize: 20),
                ))),
      floatingActionButton: SizedBox(
        height: 100.0,
        width: 100.0,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () async {
              await Navigator.pushNamed(context, '/FilterPage',
                  arguments: widget.user);
              tweetList = [];
              asyncMethod();
              setState(() {});
            },
            child: const Text("Filter"),
          ),
        ),
      ),
    );
  }

  Future<void> asyncMethod() async {
    for (var i = 0; i < widget.user!.filterInfos!.length; i++) {
      List<TweetModel>? a = await ApiOperations.getResponse(
          widget.user!.filterInfos![i]["content"],
          widget.user!.filterInfos![i]["startTime"],
          widget.user!.filterInfos![i]["endTime"]);

      for (var j = 0; j < a.length; j++) {
        if (int.parse(a[j].like) >=
                int.parse(widget.user!.filterInfos![i]["likeCount"]) &&
            int.parse(a[j].rt) >=
                int.parse(widget.user!.filterInfos![i]["rtCount"])) {
          tweetList!.add(a[j]);
        }
      }
    }
    setState(() {});
  }
}
