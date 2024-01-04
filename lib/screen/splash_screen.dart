import 'package:flutter/material.dart';
import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:snake_snake/screen/gamescreen.dart';

import '../widgets/custom_logo_animated.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const routeName = '/spalsh_screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //late FlameSplashController controller;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    //controller.dispose(); // dispose it when necessary
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomAnimatedLogoSnek(),
      // body: FlameSplashScreen(
      //   showAfter: (BuildContext context) {
      //     return CustomAnimatedLogoSnek();
      //   },
      //   theme: FlameSplashTheme.dark,
      //   onFinish: (context) =>
      //       Navigator.of(context).pushReplacementNamed(SplashScreen.routeName),
      //   controller: controller,
      // ),
    );
  }
}
