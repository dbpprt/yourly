import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';
import 'package:yourly/components/article_gesture_detector.dart';
import 'package:yourly/providers/rss/rss.dart';
import 'package:timeago/timeago.dart' as timeago;

class RssArticleComponent extends StatelessWidget {
  const RssArticleComponent({Key key, @required this.model, this.onDoubleTap})
      : super(key: key);

  final RssArticleModel model;
  final GestureTapCallback onDoubleTap;

  Widget rightColumn(RssArticleModel post) => Expanded(
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
                      text: "",
                    ),
                    TextSpan(
                        text: timeago.format(
                          DateFormat('EEE, dd MMM yyyy HH:mm:ss zzz', 'en')
                              .parse(post.pubDate),
                        ),
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
                    left: 8.0, right: 8.0, top: 8.0, bottom: 8.0),
                child: AutoSizeText(
                  post.description,
                  style: TextStyle(fontSize: 14.0),
                  minFontSize: 14.0,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return ArticleGestureDetector(
        model: model,
        onDoubleTap: onDoubleTap,
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
                    model.imageUrl != null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Image(
                                  height: 150,
                                  width: 150,
                                  image: NetworkImage(
                                    model.imageUrl,
                                  )),
                            ],
                          )
                        : Container(),
                    rightColumn(model),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
