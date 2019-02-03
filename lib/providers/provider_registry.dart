import 'dart:async' show Future;
import 'package:yourly/config.dart';
import 'package:yourly/providers/abstract_provider_api.dart';
import 'package:yourly/providers/github/github.dart';
import 'package:yourly/providers/hackernews/hackernews.dart';
import 'package:yourly/providers/rss/rss.dart';
import 'package:yourly/providers/timeline/timeline.dart';

class Provider {
  AbstractProviderApi api;

  Provider({this.api});
}

class ProviderRegistry {
  static final _instance = ProviderRegistry._internal();

  ProviderRegistry._internal();

  static ProviderRegistry get = _instance;

  bool isInitialized = false;

  final Map<String, Provider> _providers = new Map();

  Future<void> _init() async {
    final config = await ConfigurationProvider.get.config();

    for (var providerConfig in config.providers) {
      switch (providerConfig.provider) {
        case "github":
          _providers.putIfAbsent(providerConfig.name, () {
            return Provider(api: GithubTrendingProviderApi(providerConfig));
          });
          break;

        case "hackernews":
          _providers.putIfAbsent(providerConfig.name, () {
            return Provider(api: HackernewsProviderApi(providerConfig));
          });
          break;

        case "rss":
          _providers.putIfAbsent(providerConfig.name, () {
            return Provider(api: RssProviderApi(providerConfig));
          });
          break;
      }
    }

    _providers.putIfAbsent("timeline", () {
      return Provider(api: TimelineProviderApi(null, providers: _providers));
    });

    isInitialized = true;
  }

  Future<Provider> resolve(String name) async {
    if (!isInitialized) await _init();

    if (_providers.containsKey(name)) {
      return _providers[name];
    }

    throw Exception("unknown provider $name");
  }
}
