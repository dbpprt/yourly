import 'package:equatable/equatable.dart';
import 'package:yourly/database/database.dart';
import 'package:yourly/providers/abstract_provider_model.dart';

class GithubTrendingArticleModel extends Equatable
    implements AbstractProviderModel {
  GithubTrendingArticleModel(
      {this.author,
      this.name,
      this.url,
      this.description,
      this.language,
      this.languageColor,
      this.stars,
      this.forks,
      this.currentPeriodStars,
      this.builtByAvatar,
      this.builtByUsername,
      this.rawObject})
      : super([name]);

  final String author;
  final String builtByAvatar;
  final String builtByUsername;
  final int currentPeriodStars;
  final String description;
  final int forks;
  final String language;
  final String languageColor;
  final String name;
  final dynamic rawObject;
  final int stars;
  final String url;

  @override
  String getLaunchUrl() {
    return url;
  }

  @override
  String getProviderName() {
    return "github";
  }

  @override
  dynamic getRawObject() {
    return rawObject;
  }

  @override
  String getTitle() {
    return name;
  }

  @override
  SavedArticle toSavedArticle() {
    return null;
  }

  static GithubTrendingArticleModel fromRawObject(dynamic rawObject) {
    return GithubTrendingArticleModel(
        author: rawObject["author"],
        name: rawObject["name"],
        url: rawObject["url"],
        description: rawObject["description"],
        language: rawObject["language"],
        languageColor: rawObject["languageColor"],
        stars: rawObject["stars"],
        forks: rawObject["forks"],
        currentPeriodStars: rawObject["currentPeriodStars"],
        builtByAvatar: rawObject["builtBy"][0]["avatar"],
        builtByUsername: rawObject["builtBy"][0]["username"],
        rawObject: rawObject);
  }
}
