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

/// EnemySnake is just like a basic snaky snake, except it is animated
/// by a thousand years old daemon's damned soul. Watch out : it will
/// try to eat your food and there is nothing you can do about it.
class EnemySnake extends ExampleSnake {
  EnemySnake(double radius) : super(radius) {
    ;
  }

  @override
  void update(double dt) {
    /// Calculate the new direction, which is towards the food
    Vector2 foodCoordinates = _getFoodCoordinates();
    if (position.x > foodCoordinates.x) {
      setDirection(SnakeDirection.Left);
    } else {
      setDirection(SnakeDirection.Right);
    }

    if (position.y > foodCoordinates.y) {
      setDirection(SnakeDirection.Up);
    } else {
      setDirection(SnakeDirection.Down);
    }

    ///Propagate the method
    super.update(dt);
  }

  Vector2 _getFoodCoordinates() {
    print(
        "[SENEMY SNAKE] @_getFoodCoordinates - position de la bouffe :  ${gameRef.foodManager.position}\n");
    return gameRef.foodManager.position;
  }
}
