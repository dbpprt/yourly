import 'package:equatable/equatable.dart';
import 'package:yourly/database/database.dart';
import 'package:yourly/providers/abstract_provider_model.dart';

class HackernewsArticleModel extends Equatable
    implements AbstractProviderModel {
  HackernewsArticleModel(
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

  final int commentsCount;
  final String domain;
  final int id;
  final int points;
  final dynamic rawObject;
  final int time;
  final String timeAgo;
  final String title;
  final String type;
  final String url;
  final String user;

  @override
  String getLaunchUrl() {
    return url;
  }

  @override
  String getProviderName() {
    return "hackernews";
  }

  @override
  dynamic getRawObject() {
    return rawObject;
  }

  @override
  String getTitle() {
    return title;
  }

  static HackernewsArticleModel fromRawObject(dynamic rawObject) {
    return HackernewsArticleModel(
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
