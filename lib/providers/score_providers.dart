// import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

// import ''

class ScoreOnline {
  int score;
  String nameScorer;

  ScoreOnline({
    required this.score,
    required this.nameScorer,
  });
}

class ScoreProvider with ChangeNotifier {
  late int _myScore;
  late int _myBestScore;
  late String _reasonForDeath = "";
  // final db = FirebaseFirestore.instance;

  List<ScoreOnline> fakeList = [
    ScoreOnline(
      score: 123,
      nameScorer: 'Igor',
    ),
    ScoreOnline(
      score: 60,
      nameScorer: 'Alban',
    ),
    ScoreOnline(
      score: 123,
      nameScorer: 'James',
    ),
  ];

  List<ScoreOnline> threeBestScores = [];

  ScoreProvider() {
    //todo chope le score en local ou en ligne si on le temps
    // Create a new user with a first and last name

// Add a new document with a generated ID
    // db.collection("scoresfirab").add(user).then((DocumentReference doc) =>
    //     print('DocumentSnapshot added with ID: ${doc.id}'));
    _myScore = 0;
    // _myBestScore = 0;
    retrieveBestScores();
    retrieveOnlineBestScores();
  }

  Future<List<ScoreOnline>> bestScores() async {
    // await Future.delayed(Duration(milliseconds: 5000));

    return threeBestScores;
  }

  Future<bool> retrieveBestScores() async {
    final pref = await SharedPreferences.getInstance();

    _myBestScore = pref.getInt('bestScore') ?? 0;
    return true;
  }

  Future<bool> retrieveOnlineBestScores() async {
    // final pref = await SharedPreferences.getInstance();
    // var url = Uri.https('https://snek-a01db-default-rtdb.europe-west1.firebasedatabase.app/', 'score');
    // var response = await http.get(url);
    var client = http.Client();
    try {
      // var url = Uri.https(
      //     'snek-a01db-default-rtdb.europe-west1.firebasedatabase.app',
      //     '/score.json');
      var url = Uri.https(
          'snek-a01db-default-rtdb.europe-west1.firebasedatabase.app',
          '/score.json');
      final response = await http.get(
        url,
      );

      var decoded = jsonDecode(response.body) as Map;

      ///find the 3 best

      var whatisthis = decoded.entries.toList()
        ..sort(((a, b) => int.parse(a.value['bestscore'])
            .compareTo(int.parse(b.value['bestscore']))));

      for (int i = 0; i < 3; i++) {
        var scoreOnlineToAdd = whatisthis.removeLast();
        if (scoreOnlineToAdd != null) {
          threeBestScores.add(ScoreOnline(
              score: int.parse(scoreOnlineToAdd.value['bestscore']),
              nameScorer: scoreOnlineToAdd.key));
        }
      }

      // var response = await client.post(
      //     Uri.https(
      //         'snek-a01db-default-rtdb.europe-west1.firebasedatabase.app',
      //         'scores.json'),
      //     body: {'name': 'doodle', 'color': 'blue'});
      // var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      // var isEmptyResponse = decodedResponse.isEmpty;
      // var uri = Uri.parse(decodedResponse['scores'] as String);
      print(response.toString());
    } finally {
      client.close();
    }

    // _myBestScore = pref.getInt('bestScore') ?? 0;
    return true;
  }

  bool updateScore(int newScore) {
    _myScore = newScore;
    return true;
  }

  Future<bool> updateBestScore(int newScore) async {
    final pref = await SharedPreferences.getInstance();
    pref.setInt('bestScore', newScore);
    _myBestScore = newScore;
    return true;
  }

  bool addScore(int pointToAdd) {
    _myScore += pointToAdd;
    notifyListeners();
    return true;
  }

  void setReasonForDeath(String reasonText) {
    _reasonForDeath = reasonText;
    notifyListeners();
  }

  int get myScore {
    return _myScore;
  }

  int get myBestScore {
    return _myBestScore;
  }

  String get reasonForDeath {
    return _reasonForDeath;
  }
}
