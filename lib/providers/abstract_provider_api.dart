import 'package:yourly/config.dart';

abstract class AbstractProviderApi {
  final ArticleProviderConfiguration configuration;

  AbstractProviderApi({this.configuration});

  Future<List<dynamic>> fetch(int page);
}
