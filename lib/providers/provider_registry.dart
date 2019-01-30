import 'dart:async' show Future;
import 'package:yourly/config.dart';
import 'package:yourly/providers/abstract_provider_api.dart';
import 'package:yourly/providers/github/github.dart';

class Provider {
  AbstractProviderApi api;

  Provider({this.api});
}

class ProviderRegistry {
  static final _instance = ProviderRegistry._internal();
  static ProviderRegistry get = _instance;
  bool isInitialized = false;

  ProviderRegistry._internal();

  Future<Provider> resolve(String name) async {
    final config = await ConfigurationProvider.get.config();
    final providerConfiguration =
        config.providers.where((_) => _.name == name).single;

    switch (name) {
      case 'github':
        return Provider(
          api: GithubTrendingProviderApi(providerConfiguration),
        );
    }

    throw Exception("unknown provider $name");
  }
}
