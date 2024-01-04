import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart' hide Gradient;
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:snake_snake/components/snake.dart';
import 'package:snake_snake/components/player_snake.dart';
import 'package:snake_snake/components/enemy_snake.dart';
import 'package:snake_snake/components/textAnimationManager.dart';
import 'package:snake_snake/interface/interfaces.dart';
import 'package:snake_snake/providers/score_providers.dart';
import 'package:snake_snake/components/textAnimationManager.dart';

import 'food_manager.dart';

enum GameState {
  running,
  pause,
  gameOver,
}

class MySnakeGame extends FlameGame
    with HasCollisionDetection, PanDetector, KeyboardEvents {
  MySnakeGame(
    this.screen, {
    Key? key,
  })  : gameState = GameState.pause,
        super();

  late PlayerSnake mySnake;
  late EnemySnake enemySnake;
  late FoodManager foodManager;
  late GameState gameState;
  late TextAnimationManager textAnimationManager;
  Rect screen;
  double timeBufurePan = 0;
  static const TIMEFORPAN = 10.0;

  Vector2 mySnakeInitialPosition = Vector2(200, 250);
  Vector2 enemySnakeInitialPosition = Vector2(250, 300);

  //ici on va gerer la logique du jeux (score etc)

  double _gestureThreshold = 10;

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
    if (timeBufurePan <= 0) {
      if (info.delta.game.x < -_gestureThreshold) {
        mySnake.setDirection(SnakeDirection.Left);
      }
      if (info.delta.game.x > _gestureThreshold) {
        mySnake.setDirection(SnakeDirection.Right);
      }
      if (info.delta.game.y < -_gestureThreshold) {
        mySnake.setDirection(SnakeDirection.Up);
      }
      if (info.delta.game.y > _gestureThreshold) {
        mySnake.setDirection(SnakeDirection.Down);
      }
      super.onPanUpdate(info);
      timeBufurePan = TIMEFORPAN;
    }
  }

  @override
  KeyEventResult onKeyEvent(
    event,
    keysPressed,
  ) {
    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      mySnake.setDirection(SnakeDirection.Left);
    }
    if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      mySnake.setDirection(SnakeDirection.Right);
    }
    if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
      mySnake.setDirection(SnakeDirection.Up);
    }
    if (keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
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

  @override
  Future<void>? onLoad() async {
    paused = true;
    textAnimationManager = TextAnimationManager(Vector2(50, 50));
    add(textAnimationManager);

    //ici on va ajouter les composentes de notre jeux
    // add(BackgroundLayer(sizeEcran))
    // add(PlayerSnake());
    // add(EnemieSnake());
    gameState = GameState.running;
    await images.loadAll([
      'Ghostpixxells_pixelfood/97_sushi.png',
      'Ghostpixxells_pixelfood/99_taco.png',
      'Ghostpixxells_pixelfood/101_waffle.png',
    ]);
    var foodSprite = await Sprite.load('Ghostpixxells_pixelfood/97_sushi.png');
    foodManager = FoodManager(30, foodSprite);
    add(foodManager);
    mySnakeInitialPosition =
        Vector2(screen.centerLeft.dx, screen.centerLeft.dy);
    enemySnakeInitialPosition =
        Vector2(screen.topCenter.dx, screen.topCenter.dy);

    mySnake = PlayerSnake(15, mySnakeInitialPosition.clone());
    enemySnake = EnemySnake(10, enemySnakeInitialPosition.clone());
    // // add(
    // //   // RectangleHitbox(
    // //   //   anchor: Anchor.center,
    // //   //   position: Vector2(130,140),
    // //   //   size: Vector2(20, 20),
    // //   // ),
    // // );
    add(mySnake);
    add(enemySnake);
    return super.onLoad();
  }

  void gameOver(String reasonForDeath) {
    //to do reset all component and score

    paused = true;
    gameState = GameState.gameOver;
    mySnake.position = Vector2.all(-40);
    enemySnake.position = Vector2.all(-80);
    foodManager.position = Vector2.all(-120);

    buildContext?.read<ScoreProvider>().setReasonForDeath(reasonForDeath);
    buildContext?.read<ScoreProvider>().updateBestScore();
    overlays.add(GameOver.overlayName);
  }

  void resetGame() {
    mySnake.position = mySnakeInitialPosition.clone();
    enemySnake.position = enemySnakeInitialPosition.clone();
    mySnake.reset();
    enemySnake.reset();
    textAnimationManager.reset();
    buildContext?.read<ScoreProvider>().updateScore(0);
  }

  void startGame() {
    //to do reset all component and score
    paused = false;

    gameState = GameState.running;
    overlays.remove(StartUpMenu.overlayName);
  }

  void reStartGame() {
    //to do reset all component and score
    overlays.remove(GameOver.overlayName);
    resetGame();
    gameState = GameState.running;
    paused = false;
  }

  void onMainMenu() {
    //to do reset all component and score
    overlays.remove(GameOver.overlayName);
    overlays.add(StartUpMenu.overlayName);
    resetGame();
    gameState = GameState.pause;
    paused = true;
  }

  void addScore(int pointsToAdd) {
    // scoreProvider.addScore(pointsToAdd);
    if (buildContext != null) {
      buildContext?.read<ScoreProvider>().addScore(pointsToAdd);
    }
  }

  @override
  void update(double dt) {
    // TODO: implement update
    if (timeBufurePan >= 0) {
      timeBufurePan--;
    }
    super.update(dt);
  }

  void onFoodEatenByPlayer() {
    textAnimationManager.displayText("Tasty ! +1", 2);
  }

  void onEnemySuicide() {
    textAnimationManager.displayText("Enemy suicide ! +10", 2);
    enemySnake.reset();
    enemySnake.position = enemySnakeInitialPosition.clone();
  }

  void onEnemyAssasination() {
    textAnimationManager.displayText("Enemy ASSASSINATION ! Nice ! +15", 2);
    enemySnake.reset();
    enemySnake.position = enemySnakeInitialPosition.clone();
  }

  void onPlayerSuicide() {
    gameOver("Suicide");
  }

  void onPlayerAssasination() {
    gameOver("Assassinated by the enemy");
  }
}
