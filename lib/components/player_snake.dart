import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart' hide Gradient, Image;
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
class PlayerSnake extends ExampleSnake {

  PlayerSnake(double localRadius, Vector2 initialPosition) : super(localRadius, initialPosition) {
    circleRadius = localRadius;
    velocity = 2.0;
    setDirection(SnakeDirection.Right);
  }

  @override
  Future<void>? onLoad() async {
    isEvil = false;
    
// final headSprite = await Sprite.load('snakes/13.png');
// sprite = headSprite;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    ///Propagate the method
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if( other is FoodManager){
      gameRef.addScore(1);
    }
    else if (collisionableObjects.contains(other)){
      if(!identical(other, bodyParts[0])){
        gameRef.onPlayerSuicide();
      }
    }
    else if (gameRef.enemySnake.collisionableObjects.contains(other)){
      gameRef.onPlayerAssasination();
    }
    super.onCollision(intersectionPoints, other);
  }

  

}
