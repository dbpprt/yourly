import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yourly/components/components.dart';
import 'package:yourly/config.dart';
import 'package:yourly/database/common/database_provider.dart';
import 'package:yourly/database/database.dart';
import 'package:yourly/providers/abstract_provider_api.dart';
import 'package:yourly/providers/provider_registry.dart';
import 'package:rounded_modal/rounded_modal.dart';

class TimelineProviderApi extends AbstractProviderApi {
  TimelineProviderApi(ArticleProviderConfiguration configuration,
      {this.providers})
      : super(configuration: configuration);

  Map<String, Provider> providers;

  @override
  Future<List<dynamic>> fetch(int page) async {
    return await SavedArticlesDatabaseRepository(DatabaseProvider.get)
        .getArticles(page - 1, 25);
  }

  @override
  Widget render(BuildContext buildContext, rawObject,
      GestureTapCallback onDoubleTap, Function onRefresh) {
    final article = rawObject as SavedArticle;

    final provider = providers.values.firstWhere(
        (_) => _.api.configuration.provider == article.providerName);

    return provider.api.render(
      buildContext,
      json.decode(article.data),
      () {
        return _onDoubleTapHandler(buildContext, article, onRefresh);
      },
      onRefresh,
    );
  }

  _onDoubleTapHandler(
      BuildContext context, SavedArticle article, Function onRefresh) {
    HapticFeedback.vibrate();

    showRoundedModalBottomSheet(
        context: context,
        radius: 10.0, // This is the default
        color: Colors.black87,
        // color: Colors.grey.shade50, // Also default
        builder: (context) {
          return TimelineActionsheet(
            model: article,
            onDelete: onRefresh,
          );
        });
  }
}
