import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart' hide Gradient;
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snake_snake/components/snake.dart';
import 'package:snake_snake/components/food_manager.dart';

import 'game.dart';

class EnemySnake extends ExampleSnake {

  EnemySnake(double radius) : super(radius) {
    ;
  }

  @override
  void update(double dt)
  {
    super.update(dt);
  }

  void Vector2 _getFoodCoordinates()
  {
    print("[SENEMY SNAKE] @_getFoodCoordinates - position de la bouffe :  ${gameRef.foodManager.position}\n");
  }
}
