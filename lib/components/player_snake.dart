import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
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
class PlayerSnake extends ExampleSnake {
  double circleRadius = 10.0;
  List<CircleComponent> bodyParts = [];
  List<Vector2> bodyPath = [];
  double bodyLength = 200.0;

  PlayerSnake(double localRadius) : super(localRadius) {
    circleRadius = localRadius;
    velocity = 2.0;
    for(int i = 0; i < 5; i++){
      CircleComponent newCircle = CircleComponent(radius : circleRadius*(1-1/(5-i)), 
          anchor: Anchor.center,
          position: Vector2(position.x, position.y));
      bodyParts.add(newCircle);
    }
  }

  @override
  Future<void>? onLoad() {
    for( CircleComponent body in bodyParts){
      parent?.add(body);
    }
    return super.onLoad();
  }

  // void updatePosition(Vector2 positionParent){
  //   Vector2 delta = positionParent - position;
    
  //   position = positionParent;

  // }

  @override
  void update(double dt) {
    /// add the current position at the top of the list
    bodyPath.insert(0, Vector2(position.x, position.y));
    /// remove the extraneous length and relocate the body parts on the path
    double lengthFromTop = 0.0;
    Vector2 positionOfPreviousPart = position;
    int bodyPartId = 0;
    for(int i = 1; i < bodyPath.length; i++)
    {
      lengthFromTop += bodyPath[i-1].distanceTo(bodyPath[i]);
      if(lengthFromTop > bodyLength){
        bodyPath.removeRange(i, bodyPath.length);
        break;
      }
      double maxDistanceToPreviousPart = (bodyPartId>0)?bodyParts[bodyPartId-1].radius+bodyParts[bodyPartId].radius:circleRadius+bodyParts[bodyPartId].radius;
      if(positionOfPreviousPart.distanceTo(bodyPath[i]) >= maxDistanceToPreviousPart){
        positionOfPreviousPart = bodyPath[i];
        bodyParts[bodyPartId].position.setFrom(bodyPath[i]);
        bodyPartId++;
        if(bodyPartId >= bodyParts.length){
          break;
        }
      }
    }
    
    ///Propagate the method
    super.update(dt);
  }

  List<PositionComponent>  get collisionableObjects {
    return [ this, ...bodyParts];
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if( other is FoodManager){
      gameRef.addScore(1);
    }
    super.onCollision(intersectionPoints, other);
  }

}
