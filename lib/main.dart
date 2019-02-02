import 'package:flutter/material.dart';
import 'package:yourly/components/components.dart';
import 'package:yourly/pages/homepage.dart';
import 'package:yourly/pages/onboarding.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          '/help': (context) => OnboardingPage(),
        },
        home: OnboardingInitializer(
          homepage: Homepage(),
          onboarding: OnboardingPage(),
        ));
  }
}
