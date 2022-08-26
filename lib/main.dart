
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart' hide Gradient;
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
 WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MyApp(),
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
    GameWidget<MySnakeGame> mySnakeGame = GameWidget<MySnakeGame>(
      backgroundBuilder: (context) =>
          LayoutBuilder(builder: (context, contraints) {
        return SquareBackground();
      }),

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
    );

    return MaterialApp(
      title: 'PadRacing',
      home: mySnakeGame,
      theme: theme,
    );
  }
}

class MySnakeGame extends FlameGame with HasCollisionDetection, PanDetector, KeyboardEvents {
  MySnakeGame({Key? key}):super();

   late ExampleSnake mySnake;
  late FoodManager foodManager;
  //ici on va gerer la logique du jeux (score etc)


 double _gestureThreshold = 5;
  

  

  Rect _getScreenSize(BuildContext context, double appBarHeight) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;
    final topPadding = mediaQuery.padding.top;

    return Rect.fromLTWH(
      mediaQuery.padding.left,
      appBarHeight + topPadding,
      width - mediaQuery.padding.right,
      height - appBarHeight - topPadding,
    );
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    if(info.delta.game.x < - _gestureThreshold ){
      mySnake.setDirection(SnakeDirection.Left);
    }
    if(info.delta.game.x > _gestureThreshold ){
      mySnake.setDirection(SnakeDirection.Right);
    }
    if(info.delta.game.y < - _gestureThreshold ){
      mySnake.setDirection(SnakeDirection.Up);
    }
    if(info.delta.game.y > _gestureThreshold ){
      mySnake.setDirection(SnakeDirection.Down);
    }
    super.onPanUpdate(info);
  }
  
  @override
  KeyEventResult onKeyEvent(
event,
 keysPressed,
  ) {
      if(keysPressed.contains(LogicalKeyboardKey.arrowLeft) ){
      mySnake.setDirection(SnakeDirection.Left);
    }
    if(keysPressed.contains(LogicalKeyboardKey.arrowRight) ){
      mySnake.setDirection(SnakeDirection.Right);
    }
    if(keysPressed.contains(LogicalKeyboardKey.arrowUp) ){
      mySnake.setDirection(SnakeDirection.Up);
    }
    if(keysPressed.contains(LogicalKeyboardKey.arrowDown)){
      mySnake.setDirection(SnakeDirection.Down);
    }
    return KeyEventResult.ignored;
  }
  

  // void startNewGame(){

  // }

  //TODO gerer le fait que c'est une map avec des carrés et pas continues (ou pas forcement ? ou un peu ? )

  //TODO add le foodManager qui gerera de placer de la bouffe (et de la peindre) et de lui filer une hitbox
  //TODO add le gentil snake qui est controllé par (gesture et keybord ?) et qui grossie quand il bouffe et de lui filer une hitbox
  //TODO add le mechant snake qui veut manger la pomme (peut etre qu'il a des niveaux de difficulter le gus je sais pas) et de lui filer une hitbox
  //TODO gerer le gameOver
  //TODO gerer le winingCondition (on en mets un ? hehe :eyes:, quand le serpent arrive à une certaine taille -> on grossi la map et le serpent mechant et c'est repartie etc etc)

 bool _isAlreadyLoaded = false;
  @override
  Future<void>? onLoad() async {
    // TODO: implement onLoad

    //ici on va ajouter les composentes de notre jeux
    // add(BackgroundLayer(sizeEcran))
    // add(PlayerSnake());
    // add(EnemieSnake());
 await images.loadAll([
   'Ghostpixxells_pixelfood/97_sushi.png'
 ]);
    var foodSprite =  await Sprite.load('Ghostpixxells_pixelfood/97_sushi.png');
    add(FoodManager(30, foodSprite));

    mySnake = ExampleSnake(15);
    // // add(
    // //   // RectangleHitbox(
    // //   //   anchor: Anchor.center,
    // //   //   position: Vector2(130,140),
    // //   //   size: Vector2(20, 20),
    // //   // ),
    // // );
    add(mySnake);
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
    with HasGameRef<MySnakeGame>, CollisionCallbacks{
  ExampleSnake(double radius)
      : direction = SnakeDirection.Right,
        super(
          anchor: Anchor.center,
          radius: radius,
          position: Vector2.all(200),
        );

  SnakeDirection direction;

  @override
  Future<void>? onLoad() {
    add(CircleHitbox.relative(1.0,
        parentSize: Vector2.all(2 * radius), anchor: Anchor.center));
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
    if(topLeft.y < 0){
      setDirection(SnakeDirection.Down);
    }
    final bottomRight = absolutePositionOfAnchor(Anchor.bottomRight);
    if (bottomRight.x > gameSize.x ) {
      setDirection(SnakeDirection.Left);
    }
    if (bottomRight.y > gameSize.y ) {
      setDirection(SnakeDirection.Up);
    }
    switch (direction) {
      case SnakeDirection.Right:
        position.add(Vector2(1, 0));

        break;
      case SnakeDirection.Left:
        position.add(Vector2(-1, 0));

        break;
      case SnakeDirection.Up:
        position.add(Vector2(0, -1));

        break;
      case SnakeDirection.Down:
        position.add(Vector2(0, 1));

        break;
      default:
    }
    super.update(dt);
  }

  @override
  // ignore: unnecessary_overrides
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    //test qui j'ai touché et fait appel une methode du jeux en fonction
    // via gameRef.${ma methode}
    super.onCollision(intersectionPoints, other);
  }
}


enum FoodType{
  sushi,
  taco,
  waffle,
}

// class FoodManager extends SpriteGroupComponent<FoodType>
class FoodManager extends SpriteComponent
    with HasGameRef<MySnakeGame>, CollisionCallbacks{
  FoodManager( this.tileSize, this.localSprite);
  // FoodManager(double tileSize, Sprite sprite) : super(sprite: sprite, anchor: Anchor.center, size: Vector2.all(tileSize), position: Vector2(200,200));
    double tileSize;
    Sprite localSprite;


  @override
  Future<void>? onLoad() async {
    // final sushiSprite = await gameRef.loadSprite('Ghostpixxells_pixelfood/97_sushi.png');
    // final tacoSprite = await gameRef.loadSprite('Ghostpixxells_pixelfood/99_taco.png');
    // final waffleSprite = await gameRef.loadSprite('Ghostpixxells_pixelfood/101_waffle.png');
    // sprites ={
    //   FoodType.sushi : sushiSprite,
    //   FoodType.taco : tacoSprite,
    //   FoodType.waffle : waffleSprite,
    // } ;
    position = Vector2.all(200);
    size = Vector2.all(tileSize*1.5);
    anchor = Anchor.center;
    sprite = localSprite;
    add(RectangleHitbox.relative(Vector2(1.0,1.0), parentSize: size)) ;

    return super.onLoad();
  }
  
  @override
  void render(Canvas canvas) {
    // TODO: implement render
    Paint rectPain = Paint();
    rectPain.color = Colors.grey.withOpacity(0.6);
    canvas.drawRect(position.toRect(), rectPain);
    super.render(canvas);
  }

  void spawnNewFood(){
     Vector2 screenSize =  gameRef.size;
     Vector2 randomPosition = Vector2(Random().nextDouble() * screenSize.x, Random().nextDouble() * screenSize.y);

     position = randomPosition;
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

class SquareBackground extends StatelessWidget {
  var FIXEDTILESIZE = 30.0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Widget> squareList = [];
    final nbHeight = size.height ~/ FIXEDTILESIZE;

    for (int i = 0; i < 10 * nbHeight; i++) {
      squareList.add(
        Container(
          width: FIXEDTILESIZE,
          height: FIXEDTILESIZE,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.pink, Colors.blue],
              transform: GradientRotation((i % 3) * pi / 10),
            ),
          ),
        ),
      );
    }

    return Center(
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 10,
          childAspectRatio: 1.0,
        ),
        children: squareList.toList(),
      ),
    );
  }
}
