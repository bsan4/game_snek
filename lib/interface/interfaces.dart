import 'dart:math';
import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snake_snake/components/game.dart';
import 'package:snake_snake/providers/score_providers.dart';

class GameOver extends StatelessWidget {
  const GameOver({Key? key}) : super(key: key);

  static const overlayName = 'gameover';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
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
                Expanded(
                    child: Text(
                  'Game Over',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline1,
                )),
                Expanded(
                    child: Text(
                  scoreProvider.reasonForDeath,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline1,
                )),
                Expanded(
                    child: Text(
                  'Your Score ${scoreProvider.myScore}',
                  textAlign: TextAlign.center,
                )),
                Expanded(
                  child: FutureBuilder<List<ScoreOnline>>(
                    future: scoreProvider.bestScores(),
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
                                    (scorer) => Card(
                                      color: Colors.transparent,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(scorer.nameScorer),
                                          Text(scorer.score.toString()),
                                          Text(scorer.rank.toString()),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList() as List<Card>)),
                        );
                    },
                  ),
                ),
                Spacer()
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
                Expanded(
                    child: AnimatedTextKit(
                  isRepeatingAnimation: true,
                  repeatForever: true,
                  animatedTexts: [
                    ScaleAnimatedText(
                      'Snakes : The Game',
                      textAlign: TextAlign.center,
                      textStyle: Theme.of(context).textTheme.headline1,
                    ),
                  ],
                )),
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Your BestScore ${scoreProvider.myBestScore}',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 24.0),
                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Colors.transparent),
                      onPressed: (() {
                        game.startGame();
                      }),
                      child: Text('Play'),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 24.0),
                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Colors.transparent),
                      onPressed: (() {}),
                      child: Text('Buy my a beer'),
                    ),
                  ),
                ),
                Spacer()
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
  CorrectBackground({Key? key, required this.backgroundRect}) : super(key: key);

  Rect backgroundRect;

  late Rect terrainRect;
  @override
  Widget build(BuildContext context) {
    terrainRect = backgroundRect.deflate(100);

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
