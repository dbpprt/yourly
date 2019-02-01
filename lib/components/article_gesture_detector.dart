import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:yourly/database/database.dart';
import 'package:yourly/providers/abstract_provider_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleGestureDetector extends StatelessWidget {
  ArticleGestureDetector(
      {@required this.child,
      @required this.model,
      this.onTap,
      this.onDoubleTap,
      this.onLongPress});

  final Widget child;
  final AbstractProviderModel model;
  final GestureTapCallback onDoubleTap;
  final GestureLongPressCallback onLongPress;
  final GestureTapCallback onTap;

  onTapHandler(BuildContext context) {
    if (onTap != null) {
      return onTap();
    }

    HapticFeedback.vibrate();

    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (BuildContext context) => WebviewScaffold(
              url: model.getLaunchUrl(),
              appBar: new AppBar(
                title: new Text(model.getTitle()),
              ),
            ),
      ),
    );
  }

  onDoubleTapHandler(BuildContext context) async {
    if (onDoubleTap != null) {
      return onDoubleTap();
    }

    HapticFeedback.vibrate();

    await SavedArticlesDatabaseRepository(DatabaseProvider.get).insert(
        SavedArticle(model.getProviderName(), json.encode(model.getRawObject()),
            DateTime.now().millisecondsSinceEpoch, model.getLaunchUrl()));
  }

  onLongPressHandler(BuildContext context) {
    if (onLongPress != null) {
      return onLongPress();
    }

    launch(model.getLaunchUrl());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: child,
      onDoubleTap: () {
        return onDoubleTapHandler(context);
      },
      onTap: () {
        return onTapHandler(context);
      },
      onLongPress: () {
        return onLongPressHandler(context);
      },
    );
  }
}
