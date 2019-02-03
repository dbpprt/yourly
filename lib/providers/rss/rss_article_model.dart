import 'package:equatable/equatable.dart';
import 'package:webfeed/webfeed.dart';
import 'package:yourly/database/database.dart';
import 'package:yourly/providers/abstract_provider_model.dart';

class RssArticleModel extends Equatable implements AbstractProviderModel {
  RssArticleModel(
      {this.guid,
      this.imageUrl,
      this.pubDate,
      this.title,
      this.description,
      this.type,
      this.url,
      this.rawObject})
      : super([guid]);

  final String guid;
  final String imageUrl;
  final String pubDate;
  final String title;
  final String description;
  final String type;
  final String url;
  final dynamic rawObject;

  @override
  String getLaunchUrl() {
    return url;
  }

  @override
  String getProviderName() {
    return "rss";
  }

  @override
  dynamic getRawObject() {
    return rawObject;
  }

  @override
  String getTitle() {
    return title;
  }

  static RssArticleModel fromRawObject(dynamic rawObject) {
    return RssArticleModel(
        guid: rawObject["guid"],
        imageUrl: rawObject["imageUrl"],
        title: rawObject["title"],
        description: rawObject["description"],
        pubDate: rawObject["pubDate"],
        type: rawObject["type"],
        url: rawObject["url"],
        rawObject: rawObject);
  }
}
