import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'game.dart';

enum SnakeDirection {
  Right,
  Left,
  Up,
  Down,
}

class SnakeBody extends CircleComponent
    with HasGameRef<MySnakeGame>, CollisionCallbacks {
  SnakeBody(double radius)
      : direction = SnakeDirection.Right,
      
        super(
          anchor: Anchor.center,
          radius: radius,
          position:Vector2(20, 30),
          
        );
  double velocity = 2.0;
  SnakeDirection direction;

  Paint getBodyPaint(){
    Paint paint = Paint();
    paint.color = Colors.pink ;
    return paint ;
  }
  @override
  Future<void>? onLoad() {
    paint = getBodyPaint();
    add(CircleHitbox());
    return super.onLoad();
  }

  



  @override
  void update(double dt) {
    // Vector2 deltas = head.position - position;
    // position.add(deltas.normalized());
    super.update(dt);
  }

  void updatePos(){
    position.add(Vector2(12.0,0));
  }

  @override
  // ignore: unnecessary_overrides
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    //test qui j'ai touché et fait appel une methode du jeux en fonction
    // via gameRef.${ma methode}
    super.onCollision(intersectionPoints, other);
  }
}
