import 'package:flame/collisions.dart';
import 'package:flame/flame.dart';
import 'package:flame/components.dart';

import 'game.dart';

enum SnakeDirection {
  Right,
  Left,
  Up,
  Down,
}

class ExampleSnake extends CircleComponent
    with HasGameRef<MySnakeGame>, CollisionCallbacks {
  ExampleSnake(double radius)
      : direction = SnakeDirection.Right,
        super(
          anchor: Anchor.center,
          radius: radius,
          position: Vector2.all(200),
        );
  double velocity = 2.0;
  SnakeDirection direction;

  @override
  Future<void>? onLoad() {
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

  void setDirection(SnakeDirection localDirection) {
    direction = localDirection;
  }

  @override
  void update(double dt) {
    //check for out of the screen
    final topLeft = absoluteTopLeftPosition;
    final gameSize = gameRef.size;
    if (topLeft.x < 0) {
      setDirection(SnakeDirection.Right);
    }
    if (topLeft.y < 0) {
      setDirection(SnakeDirection.Down);
    }
    final bottomRight = absolutePositionOfAnchor(Anchor.bottomRight);
    if (bottomRight.x > gameSize.x) {
      setDirection(SnakeDirection.Left);
    }
    if (bottomRight.y > gameSize.y) {
      setDirection(SnakeDirection.Up);
    }
    position = getNextPosition(direction);
    super.update(dt);
  }

  @override
  // ignore: unnecessary_overrides
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    //test qui j'ai touché et fait appel une methode du jeux en fonction
    // via gameRef.${ma methode}
    super.onCollision(intersectionPoints, other);
  }

  Vector2 getNextPosition(localDirection) {
    Vector2 nextPosition = position;
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
}
