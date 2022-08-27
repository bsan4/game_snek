import 'package:flutter/material.dart';

import 'package:flame/game.dart';
import 'package:provider/provider.dart';
import 'package:snake_snake/providers/score_providers.dart';

import '../components/game.dart';
import '../interface/interfaces.dart';

class GameScreen extends StatelessWidget{
  // FocusNode gameFocus = FocusNode();

  AppBar appBar = AppBar(
    title: const Text('Snakes'),
    centerTitle: true,
    leading: IconButton(
      icon: const Icon(Icons.menu),
      onPressed: () {},
    ),
    elevation: 0,
    actions: [
      Consumer<ScoreProvider>(
        builder: (context, scoreProvider, _) => FittedBox(
            fit: BoxFit.contain,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Text('Score : ${scoreProvider.myScore}'),
            )),
      ),
    ],
    // leading:
  );

    Rect _getScreenSize(BuildContext context, double appBarHeight) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;
    final topPadding = mediaQuery.padding.top;

    return Rect.fromLTWH(
      mediaQuery.padding.left,
      appBarHeight + topPadding,
      width - mediaQuery.padding.right,
      height - appBarHeight - topPadding,
    );
  }




      // final tileSize = screen.width / 30;

      // final board = Board(
      //   screen.width ~/ tileSize,
      //   screen.height ~/ tileSize,
      // );

      // final _gameRenderer = GameRenderer(
      //   tileSize: tileSize,
      //   screen: screen,
      //   board: board,
      // );



    //   overlayBuilderMap: { // todo Overlay en fonction du jeux
    //     'menu': (_, game) => Menu(game),
    //     'gameover': (_, game) => GameOver(game),
    //   },
    //   initialActiveOverlays: const ['menu'],
    // );



  @override
  Widget build(BuildContext context) {
        final screen = _getScreenSize(
        context,
        appBar.preferredSize.height,
      );
      final tileSize = screen.width / 30;

      // final board = Board(
      //   screen.width ~/ tileSize,
      //   screen.height ~/ tileSize,
      // );



  GameWidget<MySnakeGame> mySnakeGame = GameWidget<MySnakeGame>(
    backgroundBuilder: (context) =>
        LayoutBuilder(builder: (context, contraints) {
      return CorrectBackground(backgroundRect : screen);
    }),
    game: MySnakeGame(),
    // focusNode: gameFocus,
    loadingBuilder: (context) => Center(
      child: Text(
        'Loading...',
        style: Theme.of(context).textTheme.headline1,
      ),
    ),
  );


    return Scaffold(
      appBar: appBar,
      body: mySnakeGame,
    );
  }
}
