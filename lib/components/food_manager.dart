import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart' hide Gradient;
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'game.dart';

enum FoodType {
  sushi,
  taco,
  waffle,
}

class FoodManager extends SpriteGroupComponent<FoodType>
// class FoodManager extends SpriteComponent
    with HasGameRef<MySnakeGame>, CollisionCallbacks {
  FoodManager(this.tileSize, this.localSprite);
  // FoodManager(double tileSize, Sprite sprite) : super(sprite: sprite, anchor: Anchor.center, size: Vector2.all(tileSize), position: Vector2(200,200));
  double tileSize;
  Sprite localSprite;

  late Sprite sushiSprite ;
  late Sprite tacoSprite ;
  late Sprite waffleSprite ;

  @override
  Future<void>? onLoad() async {

    sushiSprite = await gameRef.loadSprite('Ghostpixxells_pixelfood/97_sushi.png');
    tacoSprite = await gameRef.loadSprite('Ghostpixxells_pixelfood/99_taco.png');
    waffleSprite = await gameRef.loadSprite('Ghostpixxells_pixelfood/101_waffle.png');

    sprites ={
      FoodType.sushi : sushiSprite,
      FoodType.taco : tacoSprite,
      FoodType.waffle : waffleSprite,
    } ;
    current = FoodType.sushi;
    position = Vector2.all(300);
    print(position);
    size = Vector2.all(tileSize);
    anchor = Anchor.center;
    // sprite = localSprite;
    RectangleHitbox hitBox = RectangleHitbox();
    add(hitBox);

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    // TODO: implement render
    
   
    // canvas.drawRect(
    //     Rect.fromLTRB(
    //         position.x - size.x,
    //         position.y - size.y,
    //         position.x + size.x,
    //         position.y + size.y),
    //     rectPain);
    super.render(canvas);
  }

  void spawnNewFood() {
    Vector2 screenSize = gameRef.size;
    Vector2 randomPosition = Vector2(Random().nextDouble() * screenSize.x,
        Random().nextDouble() * screenSize.y);

    position = randomPosition;

    current = FoodType.values[Random().nextInt(FoodType.values.length)];
    //add a point to gameref (that will eventualy tell the snake he's growing)
  }

  @override
  // ignore: unnecessary_overrides
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    //test qui j'ai touché et fait appel une methode du jeux en fonction
    // via gameRef.${ma methode}
    spawnNewFood();
    super.onCollision(intersectionPoints, other);
  }
}
