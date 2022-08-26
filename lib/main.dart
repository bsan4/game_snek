
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart' hide Gradient;
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/game.dart';

void main() {
 WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      textTheme: TextTheme(
        headline1: GoogleFonts.vt323(
          fontSize: 35,
          color: Colors.white,
        ),
        button: GoogleFonts.vt323(
          fontSize: 30,
          fontWeight: FontWeight.w500,
        ),
        bodyText1: GoogleFonts.vt323(
          fontSize: 28,
          color: Colors.grey,
        ),
        bodyText2: GoogleFonts.vt323(
          fontSize: 18,
          color: Colors.grey,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: Colors.black,
          minimumSize: const Size(150, 50),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hoverColor: Colors.red.shade700,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red.shade700,
          ),
        ),
      ),
    );
    GameWidget<MySnakeGame> mySnakeGame = GameWidget<MySnakeGame>(
      backgroundBuilder: (context) =>
          LayoutBuilder(builder: (context, contraints) {
        return SquareBackground();
      }),

      game: MySnakeGame(),
      loadingBuilder: (context) => Center(
        child: Text(
          'Loading...',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),

      // overlayBuilderMap: { // todo Overlay en fonction du jeux
      //   'menu': (_, game) => Menu(game),
      //   'gameover': (_, game) => GameOver(game),
      // },
      // initialActiveOverlays: const ['menu'],
    );

    return MaterialApp(
      title: 'PadRacing',
      home: mySnakeGame,
      theme: theme,
    );
  }
}







class SquareBackground extends StatelessWidget {
  var FIXEDTILESIZE = 30.0;
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
