import 'package:flutter/material.dart';

import 'package:flame/game.dart';
import 'package:provider/provider.dart';
import 'package:snake_snake/providers/score_providers.dart';

import '../components/game.dart';
import '../interface/interfaces.dart';

class GameScreen extends StatefulWidget{
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  FocusNode gameFocus = FocusNode();



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
  @override
  Widget build(BuildContext context) {

      FocusNode buttonFocus = FocusNode(onKey: (node, event) {
    node.unfocus();
    gameFocus.requestFocus();

    return KeyEventResult.ignored;
  },);

      AppBar appBar = AppBar(
        backgroundColor: Colors.transparent,
    title: const Text('Snakes'),
    centerTitle: true,
    leading: IconButton(
      autofocus: false,
      focusNode: buttonFocus,
      // highlightColor: Colors.transparent,
      // splashColor: Colors.transparent,
      // hoverColor: Colors.transparent,
focusColor: Colors.transparent,
      icon: const Icon(Icons.menu),
      onPressed: () => null
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
      extendBodyBehindAppBar: true,
      appBar: appBar,
      body: mySnakeGame,
    );
  }
}
