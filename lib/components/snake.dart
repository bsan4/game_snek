import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/flame.dart';
import 'package:flame/components.dart';

import 'package:snake_snake/components/food_manager.dart';

import 'game.dart';

enum SnakeDirection {
  Right,
  Left,
  Up,
  Down,
}

class ExampleSnake extends SpriteComponent
    with HasGameRef<MySnakeGame>, CollisionCallbacks {
  double circleRadius = 10.0;
  List<SpriteComponent> bodyParts = [];
  List<Vector2> bodyPath = [];
  bool isEvil = true;

  ExampleSnake(double radius, Vector2 initialPosition)
      : direction = SnakeDirection.Right,
        super(
          anchor: Anchor.center,
          size: Vector2.all(2 * radius),
          position: Vector2(initialPosition.x, initialPosition.y),
        );
  double velocity = 2.0;
  SnakeDirection direction;

  double get radius {
    return size.x / 2;
  }

  @override
  Future<void>? onLoad() async {
    if (isEvil) {
      final headSprite = await Sprite.load('snakes/enemie.png');
      sprite = headSprite;
    } else {
      final headSprite = await Sprite.load('snakes/player.png');
      sprite = headSprite;
    }
    // bodyOddSprite = await Sprite.load('snakes/17.png');
    // bodyEvenSprite = await Sprite.load('snakes/18.png');
    add(CircleHitbox());
    return super.onLoad();
  }

  void swapeDirection() {
    switch (direction) {
      case SnakeDirection.Right:
        direction = SnakeDirection.Left;
        break;
      case SnakeDirection.Left:
        direction = SnakeDirection.Right;
        break;

      default:
    }
  }

  /// Sets the new direction for the snake. Going backwards is forbidden.
  /// If the new direction is a forbidden one, this method returns false
  bool setDirection(SnakeDirection localDirection) {
    if ((direction == SnakeDirection.Right) &&
            (localDirection != SnakeDirection.Left) ||
        (direction == SnakeDirection.Left) &&
            (localDirection != SnakeDirection.Right) ||
        (direction == SnakeDirection.Up) &&
            (localDirection != SnakeDirection.Down) ||
        (direction == SnakeDirection.Down) &&
            (localDirection != SnakeDirection.Up)) {
      direction = localDirection;
      switch (direction) {
        case SnakeDirection.Right:
          
        angle =  pi / 2;
          break;
        case SnakeDirection.Left:
        angle =   - pi / 2;
          
          break;
        case SnakeDirection.Down:
          
        angle =  pi ;
          break;
        case SnakeDirection.Up:
          
        angle =  0 ;
          break;
        default:
      }
      return true;
    } else {
      return false;
    }
  }

  @override
  void update(double dt) {
    //check for out of the screen
    if (gameRef.gameState == GameState.running) {
      final gameSize = gameRef.size;
      position = getNextPosition(direction);
      if (position.x < 0) {
        position.x = gameSize.x;
      }
      if (position.y < 0) {
        position.y = gameSize.y;
      }
      if (position.x > gameSize.x) {
        position.x = 0;
      }
      if (position.y > gameSize.y) {
        position.y = 0;
      }

      /// add the current position at the top of the list
      bodyPath.insert(0, Vector2(position.x, position.y));

      /// remove the extraneous length and relocate the body parts on the path
      Vector2 positionOfPreviousPart = position;
      int bodyPartId = 0;
      for (int i = 1; i < bodyPath.length; i++) {
        if (bodyParts.length > 0) {
          double maxDistanceToPreviousPart = (bodyPartId > 0)
              ? bodyParts[bodyPartId - 1].size.x / 2 +
                  bodyParts[bodyPartId].size.x / 2
              : circleRadius + bodyParts[bodyPartId].size.x / 2;
          if (positionOfPreviousPart.distanceTo(bodyPath[i]) >=
              maxDistanceToPreviousPart) {
            positionOfPreviousPart = bodyPath[i];
            bodyParts[bodyPartId].position.setFrom(bodyPath[i]);
            bodyPartId++;
            if (bodyPartId >= bodyParts.length) {
              bodyPath.removeRange(i, bodyPath.length);
              break;
            }
          }
        }
      }
      super.update(dt);
    }
  }

  Vector2 getNextPosition(localDirection) {
    Vector2 nextPosition = Vector2(position.x, position.y);
    switch (localDirection) {
      case SnakeDirection.Right:
        nextPosition.add(Vector2(1, 0) * velocity);
        break;
      case SnakeDirection.Left:
        nextPosition.add(Vector2(-1, 0) * velocity);
        break;
      case SnakeDirection.Up:
        nextPosition.add(Vector2(0, -1) * velocity);
        break;
      case SnakeDirection.Down:
        nextPosition.add(Vector2(0, 1) * velocity);
        break;
      default:
    }
    return nextPosition;
  }

  List<PositionComponent> get collisionableObjects {
    return [this, ...bodyParts];
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is FoodManager) {
      _addBodyPart();
    }
    super.onCollision(intersectionPoints, other);
  }

  void _addBodyPart() async {
    /// add a nex component
    ///
    ///
    String pathToSprite =
        isEvil ? 'snakes/17.png' : 'snakes/14.png';
    final sprite = await Sprite.load(pathToSprite);
    SpriteComponent newCircle = SpriteComponent(
        sprite: sprite,
        size: Vector2.all(2 * circleRadius),
        anchor: Anchor.center,
        position: Vector2(position.x, position.y));
    bodyParts.add(newCircle);

    /// resize all elements to increasingly small diameters
    int circleId = 0;
    for (SpriteComponent part in bodyParts) {
      part.size = Vector2.all(
          circleRadius * (1 - 1 / (1 + bodyParts.length - circleId)));
      circleId++;
    }
    parent?.add(newCircle);
  }
}
