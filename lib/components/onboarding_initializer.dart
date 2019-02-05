import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceSetter extends StatefulWidget {
  final Widget child;

  PreferenceSetter({@required this.child});
  @override
  PreferenceSetterState createState() {
    return new PreferenceSetterState();
  }
}

class PreferenceSetterState extends State<PreferenceSetter> {
  bool welcome = false;

  @override
  void initState() {
    super.initState();

    (() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool("welcome", true);

      setState(() {
        welcome = true;
      });
    })();
  }

  @override
  Widget build(BuildContext context) {
    if (welcome == true) {
      return widget.child;
    }

    return Container();
  }
}

class OnboardingInitializer extends StatelessWidget {
  OnboardingInitializer({@required this.homepage, @required this.onboarding});

  final Widget homepage;
  final Widget onboarding;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder:
          (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            break;
          default:
            if (!snapshot.hasError) {
              return snapshot.data.getBool("welcome") != null
                  ? homepage
                  : PreferenceSetter(
                      child: onboarding,
                    );
            }
        }

        return Container();
      },
    );
  }
}
