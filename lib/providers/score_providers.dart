import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class ScoreOnline {
  int id;
  int rank;
  int score;
  String nameScorer;
  String nationality;

  ScoreOnline(
      {required this.id,
      required this.rank,
      required this.score,
      required this.nameScorer,
      required this.nationality});
}

class ScoreProvider with ChangeNotifier {
  late int _myScore;
  late int _myBestScore;
  final db = FirebaseFirestore.instance;

  List<ScoreOnline> fakeList = [
    ScoreOnline(
      id: 1,
      rank: 1,
      score: 123,
      nameScorer: 'Igor',
      nationality: 'Pologne',
    ),
    ScoreOnline(
      id: 2,
      rank: 2,
      score: 60,
      nameScorer: 'Alban',
      nationality: 'France',
    ),
    ScoreOnline(
      id: 3,
      rank: 3,
      score: 123,
      nameScorer: 'James',
      nationality: 'USA',
    ),
  ];

  ScoreProvider() {
    //todo chope le score en local ou en ligne si on le temps
    // Create a new user with a first and last name
    final user = <String, dynamic>{
      "id": "3",
      "name": "James",
      "score": 120
    };

// Add a new document with a generated ID
    db.collection("scoresfirab").add(user).then((DocumentReference doc) =>
        print('DocumentSnapshot added with ID: ${doc.id}'));
    _myScore = 0;
    _myBestScore = 0;
  }

  Future<List<ScoreOnline>> bestScores() async {
    // await Future.delayed(Duration(milliseconds: 5000));

    return fakeList;
  }

  bool updateScore(int newScore) {
    _myScore = newScore;
    return true;
  }

  bool addScore(int pointToAdd) {
    _myScore += pointToAdd;
    notifyListeners();
    return true;
  }

  int get myScore {
    return _myScore;
  }

  int get myBestScore {
    return _myBestScore;
  }
}
