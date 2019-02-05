import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourly/components/components.dart';
import 'package:yourly/config.dart';
import 'package:yourly/pages/generic_article_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Homepage extends StatefulWidget {
  @override
  HomepageState createState() {
    return new HomepageState();
  }
}

class HomepageState extends State<Homepage> {
  AppConfiguration _configuration;
  List<String> _activeProviders;
  int _previousTabCount = -1;

  @override
  void initState() {
    super.initState();

    (() async {
      final configuration = await ConfigurationProvider.get.config();
      final preferences = await SharedPreferences.getInstance();
      var activeProviders = preferences.getStringList("active_providers");

      if (activeProviders == null || activeProviders.length == 0) {
        activeProviders = [
          "hackernews-news",
          "github-trending",
          "github-trending-dart"
        ];

        await preferences.setStringList("active_providers", activeProviders);
      }

      setState(() {
        _configuration = configuration;
        _activeProviders = activeProviders;
      });
    })();
  }

  Widget tab(String text, IconData icon) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 5),
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
    if (_configuration == null) {
      return new Container();
    }

    final tabs = new List<Tab>();
    final tabContents = new List<Widget>();

    tabs.add(
      Tab(child: tab("Timeline", FontAwesomeIcons.history)),
    );

    tabContents.add(
      GenericArticlePage(
        articleProviderName: "timeline",
      ),
    );

    for (var activeProvider in _activeProviders) {
      final providerConfig = _configuration.providers.firstWhere((_) {
        return _.name == activeProvider;
      });

      if (providerConfig != null) {
        tabs.add(
          Tab(
              child:
                  tab(providerConfig.displayName, FontAwesomeIcons.newspaper)),
        );

        tabContents.add(
          GenericArticlePage(
            articleProviderName: activeProvider,
          ),
        );
      }
    }

    Future.delayed(Duration(milliseconds: 1)).then((_) {
      if (_previousTabCount != -1 && tabs.length != _previousTabCount) {
        RestartWidget.restartApp(context);
      }

      _previousTabCount = tabs.length;
    });

    return DefaultTabController(
      length: tabs.length,
      initialIndex: 1,
      child: Scaffold(
        drawer: YourlyDrawer(),
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Image.asset("assets/web_hi_res_512.png"),
              onPressed: () {},
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            tabs: tabs,
          ),
          title: Text('Yourly'),
        ),
        body: TabBarView(
          children: tabContents,
        ),
      ),
    );
  }
}
