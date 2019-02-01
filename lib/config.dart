import 'dart:async' show Future;
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:equatable/equatable.dart';

class ArticleProviderConfiguration extends Equatable {
  final String name;
  final String provider;
  final String url;

  final String displayName;
  final String icon;

  ArticleProviderConfiguration(
      {this.name, this.provider, this.url, this.displayName, this.icon})
      : super([name]);
}

class AppConfiguration {
  final List<ArticleProviderConfiguration> providers;

  AppConfiguration({this.providers});
}

class ConfigurationProvider {
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

    _config = AppConfiguration(providers: List<ArticleProviderConfiguration>());

    for (var rawProvider in rawConfig['providers']) {
      _config.providers.add(
        ArticleProviderConfiguration(
            icon: rawProvider["icon"],
            name: rawProvider["name"],
            provider: rawProvider["provider"],
            displayName: rawProvider["displayName"],
            url: rawProvider["url"]),
      );
    }

    isInitialized = true;
  }
}
