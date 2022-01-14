import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:twitter_mask/models/tweets_model.dart';
import 'package:twitter_mask/service/api_infos.dart';
import 'package:http/http.dart' as http;

class ApiOperations {
  static Future<List<TweetModel>> getResponse(
      String content, String startTime, String endTime) async {
    List<TweetModel> list = [];

    const _authority = "api.twitter.com";
    const _path = "/2/tweets/search/recent";
    var _params = {
      "query": content,
      "start_time": startTime,
      "end_time": endTime,
      "max_results": "10",
      "tweet.fields": "public_metrics",
    };
    final _bearer = APIInfo.bearer.toString();

    final _uri = Uri.https(_authority, _path, _params);
    final response = await http.get(
      _uri,
      headers: {'Authorization': 'Bearer $_bearer'},
    );
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);
      for (var e in (decoded["data"] as List)) {
        list.add(TweetModel(
            e["id"],
            e["text"],
            e["public_metrics"]["like_count"].toString(),
            e["public_metrics"]["retweet_count"].toString()));
      }
    }
    return list;
  }
}
