import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yourly/database/common/database_provider.dart';
import 'package:yourly/database/entities/saved_article.dart';
import 'package:yourly/database/saved_article_database_repository.dart';
import 'package:yourly/models/hacker_news_article.dart' as model;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class HackerNewsArticle extends StatelessWidget {
  final model.HackerNewsArticle post;
  final GestureTapCallback onDoubleTap;

  const HackerNewsArticle({Key key, @required this.post, this.onDoubleTap})
      : super(key: key);

  Widget actionRow(model.HackerNewsArticle post) => Padding(
        padding: const EdgeInsets.only(right: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                RichText(
                  maxLines: 1,
                  text: TextSpan(children: [
                    TextSpan(
                        text: "${post.commentsCount}",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 14)),
                  ]),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 3),
                  child: Icon(
                    FontAwesomeIcons.comment,
                    size: 15.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                RichText(
                  maxLines: 1,
                  text: TextSpan(children: [
                    TextSpan(
                        text: "${post.points}",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 14)),
                  ]),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 3),
                  child: Icon(
                    FontAwesomeIcons.star,
                    size: 15.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                RichText(
                  maxLines: 1,
                  text: TextSpan(children: [
                    TextSpan(
                        text: "${post.type}",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 14)),
                  ]),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 3),
                  child: Icon(
                    FontAwesomeIcons.trophy,
                    size: 15.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget rightColumn(model.HackerNewsArticle post) => Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 4.0, right: 4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: RichText(
                  maxLines: 1,
                  text: TextSpan(children: [
                    TextSpan(
                      text: "${post.user}  ",
                    ),
                    TextSpan(
                        text: "- ${post.timeAgo}",
                        style: TextStyle(color: Colors.grey)),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0),
                child: Text(
                  post.title,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, right: 8.0, top: 8.0, bottom: 16.0),
                child: Text(
                  post.url,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
        ),
      );

  Future<void> _save() async {
    await SavedArticlesDatabaseRepository(DatabaseProvider.get).insert(
        SavedArticle("hackernews", json.encode(post.rawObject),
            DateTime.now().millisecondsSinceEpoch, post.url));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        color: Colors.grey.shade900,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  rightColumn(post),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: actionRow(post),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        launch(post.url);
      },
      onDoubleTap: () async {
        if (onDoubleTap != null) {
          return onDoubleTap();
        }

        HapticFeedback.vibrate();

        await _save();

        Fluttertoast.showToast(
            msg: "Archived",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            textColor: Colors.black,
            fontSize: 16.0);
      },
      onLongPress: () {
        HapticFeedback.vibrate();

        Navigator.of(context).push(
          new MaterialPageRoute(
            builder: (BuildContext context) => WebviewScaffold(
                  url: 'https://news.ycombinator.com/item?id=' +
                      post.id.toString(),
                  appBar: new AppBar(
                    title: new Text(post.title),
                  ),
                ),
          ),
        );
      },
    );
  }
}
