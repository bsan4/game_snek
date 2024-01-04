import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:snake_snake/screen/gamescreen.dart';
import 'package:snake_snake/screen/splash_screen.dart';

import '../interface/interfaces.dart';

class CustomAnimatedLogoSnek extends StatefulWidget {
  const CustomAnimatedLogoSnek({Key? key}) : super(key: key);

  @override
  State<CustomAnimatedLogoSnek> createState() => _CustomAnimatedLogoSnekState();
}

class _CustomAnimatedLogoSnekState extends State<CustomAnimatedLogoSnek>
    with TickerProviderStateMixin {
  bool isInit = false;
  bool _titleOpacity = false;
  bool _subtitleOpacity = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!isInit) {
      isInit = true;
      Future.delayed(Duration(seconds: 1)).then((value) {
        setState(() {
  _titleOpacity = true;
});
      });
      Future.delayed(Duration(seconds: 2)).then((value) {
        setState(() {
  _subtitleOpacity = true;
});
      });
      Future.delayed(Duration(seconds: 10)).then((value) =>
          Navigator.of(context).pushReplacementNamed(GameScreen.routeName));
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CorrectBackground(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Expanded(
              child: AnimatedOpacity(
                opacity: _titleOpacity ? 1.0 : 0.0,
                // opacity: 1.0,
                duration: Duration(milliseconds: 1000),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26.0),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      'SNEK!',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: AnimatedOpacity(
                opacity: _subtitleOpacity ? 1.0 : 0.0,
                duration: Duration(milliseconds: 1000),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26.0),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text('The Game'),
                  ),
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
