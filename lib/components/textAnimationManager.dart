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

class TextAnimationManager extends Component {
  double displayedDuration = 0;
  double durationToDisplay = 2.0; // in seconds
  bool displaying = false;
  Vector2 initialPosition = Vector2(500, 300);
  TextComponent textComponent =  TextComponent(text : "");

  TextAnimationManager(Vector2 pos) : super(){
    initialPosition = pos;
  }

  void reset(){
    displayedDuration = 0;
    durationToDisplay = 2.0; // in seconds
    displaying = false;
    textComponent = TextComponent(text : "");
  }

  @override
  Future<void>? onLoad() {
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if(displaying) {
      displayedDuration += dt;
      if(displayedDuration >= durationToDisplay) {
        displaying = false;
        remove(textComponent);
      }
    }
    
    ///Propagate the method
    super.update(dt);
  }

  void displayText(String text, double duration)
  {
    if(!displaying && textComponent != null) {
      add(textComponent);
    }
    displayedDuration = 0;
    displaying = true;
    textComponent.text = text;
    textComponent.position = initialPosition.clone();
  }
}
