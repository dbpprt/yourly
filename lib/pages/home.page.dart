import 'package:flutter/material.dart';
import 'package:yourly/components/menu.component.dart';
import 'package:yourly/pages/github_trending.page.dart';
import 'package:yourly/pages/hackernews.page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yourly/pages/timeline.page.dart';

class HomePage extends StatelessWidget {
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
              Tab(child: tab("HN", FontAwesomeIcons.yCombinator)),
              Tab(child: tab("Trending", FontAwesomeIcons.github)),
              Tab(child: tab("Trending C#", FontAwesomeIcons.github)),
              Tab(child: tab("Trending Dart", FontAwesomeIcons.github)),
            ],
          ),
          title: Text('Yourly'),
        ),
        drawer: Menu(),
        body: TabBarView(
          children: [
            TimelinePage(),
            HackerNewsPage(),
            GithubTrendingPage(),
            GithubTrendingPage(
              language: 'c%23',
            ),
            GithubTrendingPage(
              language: 'dart',
            ),
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
