import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart' hide Gradient;
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snake_snake/components/player_snake.dart';
import 'package:snake_snake/components/snake.dart';
import 'package:snake_snake/components/food_manager.dart';

import 'game.dart';

/// EnemySnake is just like a basic snaky snake, except it is animated
/// by a thousand years old daemon's damned soul. Watch out : it will
/// try to eat your food and there is nothing you can do about it.
/// Luckily for you, its speed is lowered by the weight of despair
class EnemySnake extends ExampleSnake {
  double circleRadius = 10.0;
  EnemySnake(double localRadius, Vector2 initialPosition) : super(localRadius, initialPosition) {
    circleRadius = localRadius;
    velocity = 1.5;
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
    /// This constructs a list of distances in all 4 directions in order to decide where to go
    /// If there is no imminent collision, an infinite value is used.
    /// The list is sorted like this :
    /// id 0 - left
    /// id 1 - right
    /// id 2 - up
    /// id 3 - down
    Vector4 distanceToObstacle = Vector4(
        double.infinity, double.infinity, double.infinity, double.infinity);
    List<SnakeDirection> directions = [
      SnakeDirection.Left,
      SnakeDirection.Right,
      SnakeDirection.Up,
      SnakeDirection.Down
    ];
    bool isNewDirectionColliding = false;
    ComponentSet objectsOnMap = gameRef.children;
    List<PositionComponent> collisionableOjects = [];
    for (Component object in objectsOnMap) {
      if (object is PositionComponent) {
        if ((object is! FoodManager) && !identical(object, this)) {
          if (object is PlayerSnake) {
            List<PositionComponent> playerSnakeManagerObjects =
                object.collisionableObjects;
            for (PositionComponent collisionObject
                in playerSnakeManagerObjects) {
              collisionableOjects.add(collisionObject);
            }
          } else {
            if ( (bodyParts.length == 0) || (!identical(object, bodyParts[0])) ) {
              collisionableOjects.add(object);
            }
          }
        }
      }
    }
    for (PositionComponent object in collisionableOjects) {
      int directionId = 0;
      for (SnakeDirection testedDirection in directions) {
        Vector2 nextPosition = getNextPosition(testedDirection);
        double collisionDistance = nextPosition.distanceTo(object.position);
        if (collisionDistance <
            circleRadius + max(object.width, object.height)) {
          // Update the minimum collision distance in that direction
          if (collisionDistance < distanceToObstacle[directionId]) {
            distanceToObstacle[directionId] = collisionDistance;
          }
          // Remember that it will be necessary to switch directions
          if (testedDirection == newDirection) {
            isNewDirectionColliding = true;
          }
        }
        directionId++;
      }
    }
    // Now decide whether to stay in that direction
    if (isNewDirectionColliding) {
      // An obstacle is on the way. Let's escape into the direction with the longest distance to an obstacle.
      double maximumDistance = 0.0;
      int directionId = 0;
      for (SnakeDirection testedDirection in directions) {
        double collisionDistance = distanceToObstacle[directionId];
        if (maximumDistance < collisionDistance) {
          maximumDistance = collisionDistance;
          newDirection = testedDirection;
        }
        directionId++;
      }
    }

    bool newDirectionValid = false;
    if (newDirection != direction) {
      newDirectionValid = setDirection(newDirection);
      while(!newDirectionValid)
      {
        newDirection = directions[Random().nextInt(directions.length)];
        newDirectionValid = setDirection(newDirection);
      }
    }
    ///Propagate the method
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if( other is FoodManager){
    }
    else if (collisionableObjects.contains(other)){
      gameRef.onEnemySuicide();
    }
    else if (gameRef.enemySnake.collisionableObjects.contains(other)){
      gameRef.onEnemyAssasination();
    }
    super.onCollision(intersectionPoints, other);
  }

  Vector2 _getFoodCoordinates() {
    return gameRef.foodManager.position;
  }
}
