import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yourly/database/common/database_provider.dart';
import 'package:yourly/database/database.dart';
import 'package:yourly/database/saved_articles/saved_article_database_repository.dart';

class TimelineActionsheet extends StatelessWidget {
  final SavedArticle model;
  final Function onDelete;

  TimelineActionsheet({@required this.model, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new ListTile(
              leading: new Icon(FontAwesomeIcons.share),
              title: new Text('Share'),
              onTap: () {
                Share.share(model.url);
              },
            ),
            new ListTile(
              leading: new Icon(FontAwesomeIcons.trashAlt),
              title: new Text('Remove'),
              onTap: () async {
                await SavedArticlesDatabaseRepository(DatabaseProvider.get)
                    .delete(model.id);
                Navigator.pop(context);
                onDelete();
              },
            ),
          ],
        )
      ],
    );
  }
}
