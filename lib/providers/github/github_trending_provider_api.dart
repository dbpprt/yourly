import 'dart:convert';

import 'package:yourly/config.dart';
import 'package:yourly/providers/abstract_provider_api.dart';
import 'package:http/http.dart' as http;

class GithubTrendingProviderApi extends AbstractProviderApi {
  static final http.Client httpClient = http.Client();

  GithubTrendingProviderApi(ArticleProviderConfiguration configuration)
      : super(configuration: configuration);

  @override
  Future<List<dynamic>> fetch(int page) async {
    if (page != 1) {
      return List<dynamic>();
    }

    final url = configuration.url;

    final response = await httpClient.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data;
    } else {
      throw Exception('error fetching articles');
    }
  }
}
