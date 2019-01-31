import 'package:flutter/material.dart';
import 'package:yourly/config.dart';
import 'package:yourly/database/common/database_provider.dart';
import 'package:yourly/database/entities/saved_article.dart';
import 'package:yourly/database/saved_article_database_repository.dart';
import 'package:yourly/providers/abstract_provider_api.dart';

class TimelineProviderApi extends AbstractProviderApi {
  TimelineProviderApi(ArticleProviderConfiguration configuration)
      : super(configuration: configuration);

  @override
  Future<List<dynamic>> fetch(int page) async {
    return await SavedArticlesDatabaseRepository(DatabaseProvider.get)
        .getArticles(page - 1, 25);
  }

  @override
  Widget render(BuildContext buildContext, rawObject) {
    final article = rawObject as SavedArticle;
  }
}
