class FilterInfo {
  final String itemID;
  final String content;
  final String startTime;
  final String endTime;
  final String likeCount;
  final String rtCount;

  FilterInfo({
    required this.itemID,
    required this.content,
    required this.startTime,
    required this.endTime,
    required this.likeCount,
    required this.rtCount,
  });

  Map<String, String> toJson() => {
        'itemID': itemID,
        'content': content,
        'startTime': startTime,
        'endTime': endTime,
        'likeCount': likeCount,
        'rtCount': rtCount,
      };
}
