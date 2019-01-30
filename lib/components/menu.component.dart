import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:yourly/pages/home.page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final List<MenuItem> menuItems = <MenuItem>[
  MenuItem('Home', FontAwesomeIcons.home, HomePage()),
  MenuItem(
    'GitHub',
    FontAwesomeIcons.github,
    WebviewScaffold(
      url: 'https://github.com/dennisbappert/yourly',
      appBar: new AppBar(
        title: new Text("GitHub"),
      ),
    ),
  ),
  MenuItem(
    'License',
    FontAwesomeIcons.fileSignature,
    WebviewScaffold(
      url: 'https://github.com/dennisbappert/yourly/blob/master/LICENSE',
      appBar: new AppBar(
        title: new Text("License"),
      ),
    ),
  ),
  MenuItem(
    'Issues',
    FontAwesomeIcons.bug,
    WebviewScaffold(
      url: 'https://github.com/dennisbappert/yourly/issues',
      appBar: new AppBar(
        title: new Text("Issues"),
      ),
    ),
  ),
];

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return MenuItemWidget(menuItems[index]);
        },
        itemCount: menuItems.length,
      ),
    );
  }
}

class MenuItem {
  MenuItem(this.title, this.icon, this.page);

  final String title;
  final IconData icon;
  final Widget page;
}

class MenuItemWidget extends StatelessWidget {
  final MenuItem item;
  const MenuItemWidget(this.item);

  Widget _buildMenu(MenuItem menuItem, context) {
    return ListTile(
      title: Text(menuItem.title),
      leading: new Icon(menuItem.icon),
      onTap: () {
        Navigator.of(context).push(
          new MaterialPageRoute(
            builder: (BuildContext context) => menuItem.page,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildMenu(this.item, context);
  }
}
