import 'package:flutter/material.dart';
import 'package:hangman_game/models/hangmangame.dart';

import 'gamescreen.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hangman"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Hangman Game"),
            RaisedButton(
              key: Key('new-game-button'),
              child: Text("New Game", key: Key('new-game-text')),
              onPressed: () {
                //instantiate a new HangmanGame where the word is "algorithm"
                //Push a GameScreen and give it the HangmanGame
                HangmanGame game = HangmanGame('banana');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GameScreen(game)),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
