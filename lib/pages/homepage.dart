import 'package:flutter/material.dart';
import 'package:yourly/pages/generic_article_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Homepage extends StatelessWidget {
  Widget tab(String text, IconData icon) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 3),
          child: Icon(
            icon,
            size: 18.0,
            color: Colors.grey,
          ),
        ),
        RichText(
          maxLines: 1,
          text: TextSpan(children: [
            TextSpan(
                text: text,
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 14)),
          ]),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Image.asset("assets/web_hi_res_512.png"),
              onPressed: () {},
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(child: tab("Timeline", FontAwesomeIcons.history)),
              Tab(child: tab("Hackernews", FontAwesomeIcons.yCombinator)),
              Tab(child: tab("Trending", FontAwesomeIcons.github)),
              Tab(child: tab("Trending C#", FontAwesomeIcons.github)),
              Tab(child: tab("Trending Dart", FontAwesomeIcons.github)),
            ],
          ),
          title: Text('Yourly'),
        ),
        body: TabBarView(
          children: [
            GenericArticlePage(
              articleProviderName: "timeline",
            ),
            //TimelinePage(),
            GenericArticlePage(
              articleProviderName: "hackernews-news",
            ),
            GenericArticlePage(
              articleProviderName: "github-trending",
            ),
            GenericArticlePage(
              articleProviderName: "github-trending-csharp",
            ),
            GenericArticlePage(
              articleProviderName: "github-trending-dart",
            )
            // GithubTrendingPage(),
            // GithubTrendingPage(
            //   language: 'c%23',
            // ),
            // GithubTrendingPage(
            //   language: 'dart',
            // ),
          ],
        ),
      ),
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('Home Page'),
    //   ),
    //   drawer: XmobeMenu(),
    //   body: Center(
    //     child: Text('Home Page content here'),
    //   ),
    // );
  }
}
