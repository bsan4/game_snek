import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';


class GameOver extends StatelessWidget {
  const GameOver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Center(child: Card(

        clipBehavior: Clip.antiAlias,
        child: Image.asset('assets/images/background/Sans titre-4.png'),
      ),),
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

    print('terrain : ${terrainRect.toString()}');
    print('background : ${backgroundRect.toString()}');
    return   ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),

                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset('assets/images/background/Sans titre-3.png',fit: BoxFit.cover),
                      BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 5,
                          sigmaY: 5,
                        ),
                        child: Container(
                          
                          ),

                        ),
                    ],
                  ),
                  );
  }
}
