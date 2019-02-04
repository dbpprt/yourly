import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourly/config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:collection/collection.dart';

class SettingsPage extends StatefulWidget {
  @override
  SettingsPageState createState() {
    return new SettingsPageState();
  }
}

class SettingsPageState extends State<SettingsPage> {
  AppConfiguration _configuration;
  List<String> _activeProviders;
  SharedPreferences _preferences;

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
      }

      setState(() {
        _configuration = configuration;
        _activeProviders = activeProviders;
        _preferences = preferences;
      });
    })();
  }

  Widget tab(String text) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 1),
          child: Icon(
            FontAwesomeIcons.angleRight,
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

  Widget providerList(List<ArticleProviderConfiguration> providers) {
    return new ListView(
      children: providers.map((ArticleProviderConfiguration provider) {
        return new CheckboxListTile(
          activeColor: Colors.purple,
          title: new Text(provider.settingDisplayName ?? provider.displayName),
          value: _activeProviders.any((_) {
            return _ == provider.name;
          }),
          onChanged: (bool value) async {
            setState(() {
              if (value) {
                _activeProviders.add(provider.name);
              } else {
                _activeProviders.removeWhere((_) {
                  return _ == provider.name;
                });
              }
            });

            await _preferences.setStringList(
                "active_providers", _activeProviders);
          },
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_configuration == null) {
      return Container();
    }

    final providerGroups = groupBy(_configuration.providers,
        (_) => (_ as ArticleProviderConfiguration).group);

    final tabs = new List<Widget>();
    final tabContents = new List<Widget>();

    for (var providerGroup in providerGroups.keys) {
      tabs.add(Tab(child: tab(providerGroup)));
      tabContents.add(providerList(providerGroups[providerGroup]));
    }

    return DefaultTabController(
      length: tabs.length,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            isScrollable: true,
            tabs: tabs,
          ),
          title: Text('Settings'),
        ),
        body: TabBarView(children: tabContents.toList()),
      ),
    );
  }
}
