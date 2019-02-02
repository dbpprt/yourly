import 'package:fancy_on_boarding/fancy_on_boarding.dart';
import 'package:flutter/material.dart';
import 'package:fancy_on_boarding/page_model.dart';

class OnboardingPage extends StatelessWidget {
  final pageList = [
    PageModel(
      color: const Color(0xFF678FB4),
      heroAssetPath: 'assets/web_hi_res_512.png',
      title: Text(
        'Welcome to Yourly',
        style: TextStyle(
          fontWeight: FontWeight.w800,
          color: Colors.white,
          fontSize: 34.0,
        ),
      ),
      body: Text(
        'Your favorite news at a glance',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
      iconAssetPath: 'assets/empty.png',
    ),
    PageModel(
        color: const Color(0xFF65B0B4),
        heroAssetPath: 'assets/onboarding01.png',
        title: Text('Easy to use',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontSize: 34.0,
            )),
        body: Text(
            'Tap to open, double tap to open in your browser and long press to archive',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            )),
        iconAssetPath: 'assets/empty.png'),
    PageModel(
      color: const Color(0xFF9B90BC),
      heroAssetPath: 'assets/onboarding02.png',
      title: Text('Open Source',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontSize: 34.0,
          )),
      body: Text('Feel free to give me a pull request on GitHub',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          )),
      iconAssetPath: 'assets/empty.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: FancyOnBoarding(
        pageList: pageList,
        mainPageRoute: '/main',
      ),
    );
  }
}
