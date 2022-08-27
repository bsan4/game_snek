import 'package:flutter/material.dart';

import 'package:provider/provider.dart';


class ScoreProvider with ChangeNotifier{

  late int _myScore;

  ScoreProvider(){
    //todo chope le score en local ou en ligne si on le temps 
    _myScore = 0;
  }

  bool updateScore(int newScore){
    _myScore = newScore;
    return true;
  }
  bool addScore(int pointToAdd){
    _myScore += pointToAdd;
    notifyListeners();
    return true;
  }


  int get myScore {
    return _myScore;
  }
}