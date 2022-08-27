import 'dart:math';

import 'package:flutter/material.dart';


// class BarScore extends StatelessWidget {
//   const BarScore({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) 
  
    
//   }
// }


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

    terrainRect = backgroundRect.deflate(10);
    return Stack(
      children: [
        // GlassyJugleBackground(),

        Container(
          alignment: Alignment(backgroundRect.left, backgroundRect.top),
          decoration: BoxDecoration(color: Colors.grey, border: Border.all(color: Colors.pink, width: 2.0),),

          // decoration: BoxDecoration(),
        ),

        Container(
          alignment: Alignment(terrainRect.left, terrainRect.top),
          decoration: BoxDecoration(color: Colors.grey, border: Border.all(color: Colors.pink, width: 2.0),),

          // decoration: BoxDecoration(),
        ),
        // ScreenTerrain(),
      ],
    );
    
  }

  
}
