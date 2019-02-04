import 'dart:async' show Future;
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:equatable/equatable.dart';

class ArticleProviderConfiguration extends Equatable {
  final String name;
  final String provider;
  final String url;

  final String displayName;
  final String settingDisplayName;
  final String icon;
  final String group;

  ArticleProviderConfiguration(
      {this.name,
      this.provider,
      this.url,
      this.displayName,
      this.settingDisplayName,
      this.icon,
      this.group})
      : super([name]);
}

class AppConfiguration {
  final List<ArticleProviderConfiguration> providers;

  AppConfiguration({this.providers});
}

class ConfigurationProvider {
  static final http.Client httpClient = http.Client();
  static final _instance = ConfigurationProvider._internal();
  static ConfigurationProvider get = _instance;
  bool isInitialized = false;
  AppConfiguration _config;

  ConfigurationProvider._internal();

  Future<AppConfiguration> config() async {
    if (!isInitialized) await _init();
    return _config;
  }

  Future _init() async {
    final rawConfig =
        json.decode(await rootBundle.loadString('assets/config.json'));
    final rawConfigProviders = rawConfig['providers'] as List;

    final rssConfigResponse = await httpClient.get(
        'https://raw.githubusercontent.com/dennisbappert/yourly/master/assets/rss.json');

    if (rssConfigResponse.statusCode == 200) {
      final rssConfigProviders = json.decode(rssConfigResponse.body) as List;
      rawConfigProviders.addAll(rssConfigProviders);
    }
    _config = AppConfiguration(providers: List<ArticleProviderConfiguration>());

    for (var rawProvider in rawConfigProviders) {
      _config.providers.add(
        ArticleProviderConfiguration(
          icon: rawProvider["icon"],
          name: rawProvider["name"],
          provider: rawProvider["provider"],
          displayName: rawProvider["displayName"],
          settingDisplayName: rawProvider["settingDisplayName"],
          url: rawProvider["url"],
          group: rawProvider["group"],
        ),
      );
    }

    isInitialized = true;
  }
}
