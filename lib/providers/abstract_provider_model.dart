import 'package:yourly/database/database.dart';

abstract class AbstractProviderModel {
  SavedArticle toSavedArticle();

  String getLaunchUrl();

  String getTitle();

  String getProviderName();

  dynamic getRawObject();
}
