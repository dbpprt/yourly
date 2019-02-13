import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yourly/config.dart';
import 'package:yourly/providers/abstract_provider_api.dart';
import 'package:http/http.dart' as http;
import 'package:yourly/providers/github/github.dart';

class GithubTrendingProviderApi extends AbstractProviderApi {
  GithubTrendingProviderApi(ArticleProviderConfiguration configuration)
      : super(configuration: configuration);

  static final http.Client httpClient = http.Client();

  @override
  Future<List<dynamic>> fetch(int page) async {
    if (page != 1) {
      return List<dynamic>();
    }

    final url = configuration.url;

    final response = await httpClient
        .get(url, headers: {'Content-Type': 'application/json; charset=utf-8'});
    if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes)) as List;
      return data;
    } else {
      throw Exception('error fetching articles');
    }
  }

  @override
  Widget render(BuildContext buildContext, rawObject,
      GestureTapCallback onDoubleTap, Function onRefresh) {
    return GithubTrendingArticleComponent(
        onDoubleTap: onDoubleTap,
        model: GithubTrendingArticleModel.fromRawObject(rawObject));
  }
}
