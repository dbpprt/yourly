import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yourly/providers/github/github_trending_article_model.dart';

class GithubTrendingArticleComponent extends StatelessWidget {
  final GithubTrendingArticleModel model;
  final GestureTapCallback onDoubleTap;

  const GithubTrendingArticleComponent(
      {Key key, @required this.model, this.onDoubleTap})
      : super(key: key);

  static int _getColorFromHex(String hexColor) {
    if (hexColor == null) {
      hexColor = "#FF9E9E9E";
    }
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  Widget actionRow(GithubTrendingArticleModel post) => Padding(
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
                        text: "${post.forks}",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 14)),
                  ]),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 3),
                  child: Icon(
                    FontAwesomeIcons.codeBranch,
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
                        text: "${post.stars}",
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
                        text: "${post.currentPeriodStars}",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 14)),
                  ]),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 3),
                  child: Icon(
                    FontAwesomeIcons.grinStars,
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
                        text: "${post.language ?? "???"}",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 14)),
                  ]),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 3),
                  child: Icon(
                    FontAwesomeIcons.circle,
                    size: 15.0,
                    color: Color(_getColorFromHex(post.languageColor)),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget rightColumn(GithubTrendingArticleModel post) => Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 4.0),
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
                      text: "${post.author}  ",
                    ),
                    TextSpan(
                        text: "by ${post.builtByUsername}",
                        style: TextStyle(color: Colors.grey)),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0),
                child: Text(
                  post.name,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, right: 8.0, top: 4.0, bottom: 16.0),
                child: Text(
                  post.description,
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
                CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(
                      model.builtByAvatar
                              .replaceAll("github.com", "github.com.rsz.io") +
                          '?width=30',
                    )),
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
    ));
  }
}
