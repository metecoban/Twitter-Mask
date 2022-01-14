class TweetModel {
  final String id;
  final String text;
  final String like;
  final String rt;
  TweetModel(this.id, this.text, this.like, this.rt);

  @override
  String toString() {
    return "id: $id, text: $text, like: $like, rt: $rt";
  }
}
