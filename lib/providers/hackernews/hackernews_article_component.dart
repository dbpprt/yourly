import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yourly/providers/hackernews/hackernews.dart';

class HackernewsArticleComponent extends StatelessWidget {
  final HackernewsArticleModel model;
  final GestureTapCallback onDoubleTap;

  const HackernewsArticleComponent(
      {Key key, @required this.model, this.onDoubleTap})
      : super(key: key);

  Widget actionRow(HackernewsArticleModel post) => Padding(
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

  Widget rightColumn(HackernewsArticleModel post) => Expanded(
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
                  rightColumn(model),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: actionRow(model),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
