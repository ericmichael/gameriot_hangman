import 'package:flutter/material.dart';
import 'package:hangman_game/models/hangmangame.dart';

import 'gamescreen.dart';

class LoseScreen extends StatelessWidget {
  HangmanGame game;
  //This should be modified to take in a HangmanGame
  LoseScreen(this.game);

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("You Lose", key: Key('lose-text')),
                    SizedBox(
                height: 300,
                child: Image(image: AssetImage('assets/progress_7.png'))),
            Text('word was: ${game.word}'),
          ],
        ),
      ),
    ));
  }
}
