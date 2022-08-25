import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart' hide Image, Gradient;
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      textTheme: TextTheme(
        headline1: GoogleFonts.vt323(
          fontSize: 35,
          color: Colors.white,
        ),
        button: GoogleFonts.vt323(
          fontSize: 30,
          fontWeight: FontWeight.w500,
        ),
        bodyText1: GoogleFonts.vt323(
          fontSize: 28,
          color: Colors.grey,
        ),
        bodyText2: GoogleFonts.vt323(
          fontSize: 18,
          color: Colors.grey,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: Colors.black,
          minimumSize: const Size(150, 50),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hoverColor: Colors.red.shade700,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red.shade700,
          ),
        ),
      ),
    );

    return MaterialApp(
      title: 'PadRacing',
      home: GameWidget<MySnakeGame>(
        backgroundBuilder: (context) => Container(
          color: Colors.pink,
        ),
        game: MySnakeGame(),
        loadingBuilder: (context) => Center(
          child: Text(
            'Loading...',
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        // overlayBuilderMap: { // todo Overlay en fonction du jeux
        //   'menu': (_, game) => Menu(game),
        //   'gameover': (_, game) => GameOver(game),
        // },
        // initialActiveOverlays: const ['menu'],
      ),
      theme: theme,
    );
  }
}

class MySnakeGame extends FlameGame with HasCollisionDetection {
  MySnakeGame({Key? key}) : super();
  //ici on va gerer la logique du jeux (score etc)

  //TODO gerer le fait que c'est une map avec des carrés et pas continues (ou pas forcement ? ou un peu ? )
  
  //TODO add le foodManager qui gerera de placer de la bouffe (et de la peindre) et de lui filer une hitbox 
  //TODO add le gentil snake qui est controllé par (gesture et keybord ?) et qui grossie quand il bouffe
  //TODO add le mechant snake qui veut manger la pomme (peut etre qu'il a des niveaux de difficulter le gus je sais pas)
  //TODO gerer le gameOver
  //TODO gerer le winingCondition (on en mets un ? hehe :eyes:, quand le serpent arrive à une certaine taille -> on grossi la map et le serpent mechant et c'est repartie etc etc)


  @override
  Future<void>? onLoad() {
    // TODO: implement onLoad

    //ici on va ajouter les composentes de notre jeux
    // add(PlayerSnake());
    // add(EnemieSnake());
    // add(FoodsManager());
    // add(
    //   // RectangleHitbox(
    //   //   anchor: Anchor.center,
    //   //   position: Vector2(130,140),
    //   //   size: Vector2(20, 20),
    //   // ),
    // );
    add(ExampleSnake(20));
    return super.onLoad();
  }
}

enum SnakeDirection {
  Right,
  Left,
  Up,
  Down,
}

class ExampleSnake extends CircleComponent
    with HasGameRef<MySnakeGame>, CollisionCallbacks {
  ExampleSnake(double radius)
      : _paint = Paint()..color = Colors.blue,
        direction = SnakeDirection.Right,
        super(
          anchor: Anchor.center,
          radius: radius,
          position: Vector2.all(20),
        );

  Paint _paint;
  SnakeDirection direction;

  @override
  Future<void>? onLoad() {
    add(CircleHitbox.relative(1.0,
        parentSize: Vector2.all(2 * radius), anchor: Anchor.center));
    return super.onLoad();
  }

  void swapeDirection(){
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

  @override
  void update(double dt) {
    //check for out of the screen
    final topLeft = absoluteTopLeftPosition;
    final gameSize = gameRef.size;
    if(topLeft.x > gameSize.x || topLeft.y > gameSize.y) {
      swapeDirection();

    }
    final bottomRight = absolutePositionOfAnchor(Anchor.bottomRight);
    if(bottomRight.x < 0 || bottomRight.y < 0) {
      swapeDirection();

    }
    switch (direction) {
      case SnakeDirection.Right:
        position.add(Vector2(1, 1));

        break;
      case SnakeDirection.Left:
        position.add(Vector2(-1, -1));

        break;
      default:
    }
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    //test qui j'ai touché et fait appel une methode du jeux en fonction 
    // via gameRef.${ma methode}
    super.onCollision(intersectionPoints, other);
  }
  
}
