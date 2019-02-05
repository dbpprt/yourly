import 'package:flutter/material.dart';
import 'package:yourly/components/components.dart';
import 'package:yourly/pages/homepage.dart';
import 'package:yourly/pages/onboarding.dart';
import 'package:intl/intl.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:yourly/pages/settings.dart';

void main() => runApp(new RestartWidget(
      child: new YourlyApp(),
    ));

class YourlyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Intl.defaultLocale = 'en_US';

    Future.wait([
      initializeDateFormatting('en', null),
    ]);

    return new MaterialApp(
        title: 'Yourly',
        theme: new ThemeData(
          brightness: Brightness.dark,
          accentColor: Colors.deepPurple,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        //Add Route to the main Page.
        routes: {
          '/main': (context) => Homepage(),
          '/settings': (context) => SettingsPage(),
          '/help': (context) => OnboardingPage(),
        },
        home: OnboardingInitializer(
          homepage: Homepage(),
          onboarding: OnboardingPage(),
        ));
  }
}
