import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart' hide Gradient;
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snake_snake/components/food_manager.dart';
import 'package:snake_snake/components/snake.dart';

import 'game.dart';
import 'snake_body.dart';

class PlayerSnakeHead extends ExampleSnake {
  PlayerSnakeHead(double radius) : super(radius);

  // List<SnakeBody> bodyTile = [];

  @override
  Future<void>? onLoad() {
    // bodyTile.add(SnakeBody(15));
    // bodyTile.add(SnakeBody(10,));

    return super.onLoad();
  }

  @override
  void update(double dt) {
    // for(SnakeBody body in bodyTile){
    //   body.updatePos();
    // }
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    //  for(SnakeBody body in bodyTile){
    //   //  print(body.position);
    //    body.render(canvas);
    //  }
    super.render(canvas);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is FoodManager) {
      //  bodyTile.add();
    }
    super.onCollision(intersectionPoints, other);
  }
}

class PlayerSnakeBody extends ExampleSnake {
  PlayerSnakeBody(double radius) : super(radius);

  // List<SnakeBody> bodyTile = [];

  @override
  Future<void>? onLoad() {
    // bodyTile.add(SnakeBody(15));
    // bodyTile.add(SnakeBody(10,));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    // for(SnakeBody body in bodyTile){
    //   body.updatePos();
    // }
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    //  for(SnakeBody body in bodyTile){
    //   //  print(body.position);
    //    body.render(canvas);
    //  }
    super.render(canvas);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is FoodManager) {
      //  bodyTile.add();
    }
    super.onCollision(intersectionPoints, other);
  }
}

class PlayerSnakeManager extends PositionComponent {
  List<PlayerSnakeBody> bodys = [];
  PlayerSnakeHead head = PlayerSnakeHead(30);

  @override
  Future<void>? onLoad() async {
    bodys.add(PlayerSnakeBody(20));
    bodys.add(PlayerSnakeBody(10));
    await addAll(bodys);
    await add(head);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
  }

  /// Returns all the objects that could cause a collision
  /// This is necessary because they are not registered in the GameRef, only
  /// the manager is.
  List<PositionComponent> getCollisionableObjects() {
    List<PositionComponent> objList = [];
    for (PositionComponent bodyObject in bodys) {
      objList.add(bodyObject);
    }
    objList.add(head);
    return objList;
  }
}
