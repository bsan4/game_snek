import 'dart:math';
import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snake_snake/components/game.dart';
import 'package:snake_snake/providers/score_providers.dart';
import 'package:url_launcher/url_launcher.dart';

class GameOver extends StatelessWidget {
  GameOver(this.game, {Key? key}) : super(key: key);
  MySnakeGame game;
  static const overlayName = 'gameover';

  final Uri _cofferUrl = Uri.parse('https://www.buymeacoffee.com/snekthegame');

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Container(
          alignment: Alignment.bottomCenter,

          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.2),
                Colors.black.withOpacity(0.2),
              ],
            ),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/background/Sans titre-4.png'),
            ),
          ),
          // alignment: Alignment.center,
          child:
              Consumer<ScoreProvider>(builder: (context, scoreProvider, child) {
            return Column(
              // mainAxisSize: MainAxisSize.,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    child: Text(
                  'Game Over',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline1,
                )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 24.0),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      scoreProvider.reasonForDeath,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${scoreProvider.myName} : ${scoreProvider.myScore}',
                    textAlign: TextAlign.center,
                  ),
                )),
                Expanded(
                  flex: 2,
                  child: FutureBuilder<List<ScoreOnline>>(
                    future: scoreProvider.retrieveOnlineBestScores(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      } else
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 24.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: (snapshot.data
                                  ?.map(
                                    (scorer) => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        FittedBox(
                                            fit: BoxFit.fitHeight,
                                            child: Text(scorer.nameScorer)),
                                        FittedBox(
                                            fit: BoxFit.fitHeight,
                                            child:
                                                Text(scorer.score.toString())),
                                        // Text(scorer.rank.toString()),
                                      ],
                                    ),
                                  )
                                  .toList() as List<Row>)),
                        );
                    },
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 12.0),
                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Colors.transparent),
                      onPressed: (() {
                        game.reStartGame();
                      }),
                      child: FittedBox(
                        child: Text('Restart'),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 12.0),
                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Colors.transparent),
                      onPressed: (() async {
                        if (await canLaunchUrl(_cofferUrl)) {
                          launchUrl(_cofferUrl,
                              mode: LaunchMode.externalApplication);
                        }
                      }),
                      child: FittedBox(
                        child: Text('Buy my a coffee!'),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: IconButton(
                      onPressed: () {
                        game.onMainMenu();
                      },
                      icon: Icon(
                        Icons.home,
                        color: Colors.white,
                      )),
                ),
                Spacer(),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class StartUpMenu extends StatelessWidget {
  StartUpMenu(this.game, {Key? key}) : super(key: key);

  static const overlayName = 'zizi';
  MySnakeGame game;
  final Uri _cofferUrl = Uri.parse('https://www.buymeacoffee.com/snekthegame');

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Container(
          alignment: Alignment.bottomCenter,
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/background/Sans titre-4.png'),
            ),
          ),
          // alignment: Alignment.center,
          child:
              Consumer<ScoreProvider>(builder: (context, scoreProvider, child) {
            return Column(
              // mainAxisSize: MainAxisSize.,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Spacer(),
                Expanded(
                    child: AnimatedTextKit(
                  isRepeatingAnimation: true,
                  repeatForever: true,
                  animatedTexts: [
                    ScaleAnimatedText(
                      'Snek! : The Game',
                      textAlign: TextAlign.center,
                      textStyle: Theme.of(context).textTheme.headline1,
                    ),
                  ],
                )),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 24.0),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '${scoreProvider.myName} BestScore ${scoreProvider.myBestScore}',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 12.0),
                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Colors.transparent),
                      onPressed: (() {
                        game.startGame();
                      }),
                      child: FittedBox(
                        child: Text('Play'),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 12.0),
                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Colors.transparent),
                      onPressed: (() async {
                        if (await canLaunchUrl(_cofferUrl)) {
                          launchUrl(_cofferUrl,
                              mode: LaunchMode.externalApplication);
                        }
                      }),
                      child: FittedBox(
                        child: Text('Buy my a coffee!'),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        'Thx Ghostpixxells_pixelfood for the pngs!',
                        textAlign: TextAlign.center,
                        softWrap: true,
                      ),
                    ),
                  ),
                ),
                Spacer(),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class SquareBackground extends StatelessWidget {
  var FIXEDTILESIZE = 30.0;

  SquareBackground(Rect this.screen);

  Rect screen;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Widget> squareList = [];
    final nbHeight = size.height ~/ FIXEDTILESIZE;

    for (int i = 0; i < 10 * nbHeight; i++) {
      squareList.add(
        Container(
          width: FIXEDTILESIZE,
          height: FIXEDTILESIZE,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.pink, Colors.blue],
              transform: GradientRotation((i % 3) * pi / 10),
            ),
          ),
        ),
      );
    }

    return Center(
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 10,
          childAspectRatio: 1.0,
        ),
        children: squareList.toList(),
      ),
    );
  }
}

class CorrectBackground extends StatelessWidget {
  CorrectBackground({Key? key, this.backgroundRect}) : super(key: key);

  Rect? backgroundRect;

  late Rect terrainRect;
  @override
  Widget build(BuildContext context) {
    if (backgroundRect != null) {
      terrainRect = backgroundRect!.deflate(100);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/background/Sans titre-3.png',
              fit: BoxFit.cover),
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5,
              sigmaY: 5,
            ),
            child: Container(),
          ),
        ],
      ),
    );
  }
}
