import 'package:flutter/material.dart';
import 'package:yourly/config.dart';
import 'package:yourly/providers/abstract_provider_api.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';
import 'package:yourly/providers/rss/rss.dart';

class RssProviderApi extends AbstractProviderApi {
  static final http.Client httpClient = http.Client();

  RssProviderApi(ArticleProviderConfiguration configuration)
      : super(configuration: configuration);

  @override
  Future<List<dynamic>> fetch(int page) async {
    if (page != 1) {
      return List<dynamic>();
    }

    final url = configuration.url;

    final response = await httpClient.get(url);
    if (response.statusCode == 200) {
      final feedItems = RssFeed.parse(response.body).items;
      final data = List<Map<String, dynamic>>();

      for (var feedItem in feedItems) {
        data.add({
          "guid": feedItem.guid,
          "title": feedItem.title,
          "description": feedItem.description,
          "pubDate": feedItem.pubDate,
          "type": 'rssitem',
          "url": feedItem.link,
          "imageUrl": feedItem.content.images.first
        });
      }

      return data;
    } else {
      throw Exception('error fetching articles');
    }
  }

  @override
  Widget render(BuildContext buildContext, rawObject,
      GestureTapCallback onDoubleTap, Function onRefresh) {
    return RssArticleComponent(
        onDoubleTap: onDoubleTap,
        model: RssArticleModel.fromRawObject(rawObject));
  }
}
