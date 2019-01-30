import 'package:equatable/equatable.dart';

class HackerNewsArticle extends Equatable {
  final int id;
  final String title;
  final int points;
  final String user;
  final int time;
  final String timeAgo;
  final int commentsCount;
  final String type;
  final String url;
  final String domain;
  final dynamic rawObject;

  HackerNewsArticle(
      {this.id,
      this.title,
      this.points,
      this.user,
      this.time,
      this.timeAgo,
      this.commentsCount,
      this.type,
      this.url,
      this.domain,
      this.rawObject})
      : super([id]);

  @override
  String toString() => 'Post { id: $id }';

  static HackerNewsArticle fromRawObject(dynamic rawObject) {
    return HackerNewsArticle(
        id: rawObject["id"],
        title: rawObject["title"],
        points: rawObject["points"],
        user: rawObject["user"],
        time: rawObject["time"],
        timeAgo: rawObject["time_ago"],
        commentsCount: rawObject["comments_count"],
        type: rawObject["type"],
        url: rawObject["url"],
        domain: rawObject["domain"],
        rawObject: rawObject);
  }
}
