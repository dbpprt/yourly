import 'package:yourly/database/database.dart';

abstract class AbstractProviderModel {
  String getLaunchUrl();

  String getTitle();

  String getProviderName();

  dynamic getRawObject();
}
