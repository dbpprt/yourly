import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class YourlyDrawer extends StatefulWidget {
  @override
  YourlyDrawerState createState() {
    return new YourlyDrawerState();
  }
}

class YourlyDrawerState extends State<YourlyDrawer> {
  String version;

  @override
  void initState() {
    super.initState();

    (() async {
      final packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        version = packageInfo.version;
      });
    })();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: new Stack(
        //alignment:new Alignment(x, y)
        children: <Widget>[
          new Positioned(
            child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text("Yourly $version"),
                  accountEmail: Text("github.com/dennisbappert/yourly"),
                  currentAccountPicture:
                      Image.asset("assets/web_hi_res_512.png"),
                ),
                ListTile(
                  leading: Icon(FontAwesomeIcons.cog),
                  title: Text("Settings"),
                  trailing: Icon(FontAwesomeIcons.arrowRight),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, '/settings');
                  },
                ),
                ListTile(
                  leading: Icon(FontAwesomeIcons.github),
                  title: Text("About"),
                  trailing: Icon(FontAwesomeIcons.arrowRight),
                  onTap: () {
                    Navigator.of(context).pop();
                    launch("https://www.github.com/dennisbappert/yourly");
                  },
                ),
                ListTile(
                  leading: Icon(FontAwesomeIcons.questionCircle),
                  title: Text("Help"),
                  trailing: Icon(FontAwesomeIcons.arrowRight),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, '/help');
                  },
                ),
              ],
            ),
          ),
          new Positioned(
            child: new Align(
              alignment: FractionalOffset.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "Made with ❤️ in Hamburg",
                      style: TextStyle(
                        fontSize: 15,
                        decoration: TextDecoration.none,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
