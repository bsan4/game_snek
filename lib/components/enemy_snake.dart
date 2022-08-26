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
  double circleRadius = 10.0;
  EnemySnake(double localRadius) : super(localRadius) {
    circleRadius = localRadius;
  }

  @override
  void update(double dt) {
    /// Calculate the new direction, which is towards the food
    SnakeDirection newDirection = direction;
    Vector2 foodCoordinates = _getFoodCoordinates();
    // The current position is compared to the target + 1 for hysteresis
    if (position.x > foodCoordinates.x + circleRadius) {
      newDirection = SnakeDirection.Left;
    } else if (position.x + circleRadius < foodCoordinates.x) {
      newDirection = SnakeDirection.Right;
    } else if (position.y > foodCoordinates.y + circleRadius) {
      newDirection = SnakeDirection.Up;
    } else if (position.y + circleRadius < foodCoordinates.y) {
      newDirection = SnakeDirection.Down;
    }

    /// Avoid a deadly object, such as a wall or a player. Food is fine.
    ComponentSet objectsOnMap = gameRef.children;
    for (Component object in objectsOnMap) {
      if (object is PositionComponent) {
        if ((object is! FoodManager) && !identical(object, this)) {
          Vector2 nextPosition = getNextPosition(newDirection);
          double collisionDistance = nextPosition.distanceTo(object.position);
          if (collisionDistance < circleRadius) {
            print("Going to collide : ${collisionDistance}");
          }
        }
      }
    }

    if (newDirection != direction) {
      setDirection(newDirection);
    }

    ///Propagate the method
    super.update(dt);
  }

  Vector2 _getFoodCoordinates() {
    return gameRef.foodManager.position;
  }
}
