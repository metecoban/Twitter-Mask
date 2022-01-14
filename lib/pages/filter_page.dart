import 'package:flutter/material.dart';
import 'package:twitter_mask/models/filter_info_model.dart';
import 'package:twitter_mask/models/user_model.dart';
import 'package:twitter_mask/pages/homepage.dart';
import 'package:twitter_mask/service/firebase_operations.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key, this.user}) : super(key: key);
  final UserModel? user;

  @override
  _FilterPageState createState() => _FilterPageState();
}

String? _startDate = "";
String? _endDate = "";
int _counter = 0;

class _FilterPageState extends State<FilterPage> {
  @override
  void initState() {
    _counter = widget.user!.filterInfos!.length;
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _counter = 0;
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 7),
              child: IconButton(
                  onPressed: () {
                    setState(() {});
                  },
                  icon: const CircleAvatar(
                    child: Icon(Icons.replay),
                  )),
            )
          ],
          backgroundColor: Colors.blue,
          title: const Text("Filter"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            margin: const EdgeInsets.all(5),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    onTap: () async {
                      Map? curInfo = widget.user!.filterInfos![index];
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return FilterAlertDialog(
                              user: widget.user,
                              filterInfos: FilterInfo(
                                  content: curInfo!["content"],
                                  itemID: curInfo["itemID"],
                                  startTime: curInfo["startTime"],
                                  endTime: curInfo["endTime"],
                                  likeCount: curInfo["likeCount"],
                                  rtCount: curInfo["rtCount"]),
                              formKey: _formKey);
                        },
                      );

                      setState(() {});
                    },
                    title: Text(widget.user!.filterInfos![index]["content"]),
                  ),
                );
              },
              itemCount: _counter,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            int newCounter = _counter + 1;
            await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return FilterAlertDialog(
                      user: widget.user,
                      filterInfos: FilterInfo(
                          content: "*Content",
                          itemID: newCounter.toString(),
                          startTime: "",
                          endTime: "",
                          likeCount: "Like count",
                          rtCount: "RT count"),
                      formKey: _formKey);
                });
            setState(() {});
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class FilterAlertDialog extends StatelessWidget {
  final FilterInfo? filterInfos;
  const FilterAlertDialog({
    Key? key,
    required GlobalKey<FormState> formKey,
    this.filterInfos,
    this.user,
  })  : _formKey = formKey,
        super(key: key);
  final UserModel? user;
  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    TextEditingController contentController = TextEditingController();
    TextEditingController likeController = TextEditingController();
    TextEditingController rtController = TextEditingController();
    likeController.text = "0";
    rtController.text = "0";
    return AlertDialog(
      content: Stack(
        children: <Widget>[
          Form(
            key: _formKey,
            child: SizedBox(
              height: 350,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            child: Text(filterInfos!.itemID.toString()),
                          ),
                          IconButton(
                            onPressed: () {
                              user!.filterInfos!
                                  .removeAt(int.parse(filterInfos!.itemID) - 1);

                              FirebaseOperation.setValues(user);
                              _counter--;
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      )),
                  TextField(
                    controller: contentController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      labelText: filterInfos!.content,
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: 'Write what you want to search',
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2020),
                                    lastDate: DateTime.now())
                                .then((value) => _startDate = DateTime.parse(
                                        value!.toUtc().toIso8601String())
                                    .toString()
                                    .replaceFirst(" ", "T"));
                          },
                          child: const Text("Start Time"),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2020),
                                    lastDate: DateTime.now())
                                .then((value) => _endDate = DateTime.parse(
                                        value!.toUtc().toIso8601String())
                                    .toString()
                                    .replaceFirst(" ", "T"));
                          },
                          child: const Text("End Time"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: 160,
                          child: TextField(
                            controller: likeController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              labelText: filterInfos!.likeCount,
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              hintText: 'How many likes',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: SizedBox(
                          width: 160,
                          child: TextField(
                            controller: rtController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              labelText: filterInfos!.rtCount,
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              hintText: 'How many retweets',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        user!.filterInfos!.add({
                          'itemID': filterInfos!.itemID,
                          'content': contentController.text,
                          'startTime': _startDate,
                          'endTime': _endDate,
                          'likeCount': likeController.text,
                          'rtCount': rtController.text,
                        });
                        FirebaseOperation.setValues(user);
                        _counter = user!.filterInfos!.length;
                        Navigator.pop(context);
                      },
                      child: const Text("Save")),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
