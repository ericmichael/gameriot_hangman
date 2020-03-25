import 'package:flutter/material.dart';
import 'package:hangman_game/models/hangmangame.dart';

import 'losescreen.dart';
import 'winscreen.dart';

class GameScreen extends StatefulWidget {
  HangmanGame game;
  //This should be modified to take in a HangmanGame
  GameScreen(this.game);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final guessTextController = TextEditingController();
  bool validate = false;
  String message = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child: Center(
            child: ListView(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                        child: TextField(
                          key: Key('guess-textfield'),
                          controller: guessTextController,
                          decoration: InputDecoration(
                            labelText: 'Enter New Letter',
                            errorText: validate ? message : null,
                          ),
                        ),
                      ),
                    ),
                    RaisedButton(
                        key: Key('guess-letter-btn'),
                        child:
                            Text('Guess Letter', key: Key('guess-letter-text')),
                        onPressed: () {
                          setState(() {
                            String userGuess = guessTextController.text;

                            try {
                              bool valid = widget.game.guess(userGuess);

                              if (valid) {
                                validate = false;
                              }
                              // guess was a repeat
                              else {
                                validate = true;
                                // if already used that letter
                                if (widget.game.wrong_guesses
                                        .contains(userGuess) ||
                                    widget.game.correct_guesses
                                        .contains(userGuess)) {
                                  message = 'already used that letter';
                                }
                              }

                              guessTextController.text = '';

                              // hide the keyboard 
                              FocusScope.of(context).unfocus();

                              if (widget.game.status == 'win') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WinScreen()));
                              }
                              if (widget.game.status == 'lose') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            LoseScreen(widget.game)));
                              }
                            } catch (e) {
                              message = 'invalid';
                              validate = true;
                            }
                          });
                        })
                  ],
                ),
                SizedBox(
                    height: 250,
                    child: Image(
                        image: AssetImage(
                            'assets/progress_${widget.game.wrong_guesses.length}.png'))),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(widget.game.blanks_with_correct_guesses,
                        key: Key('blank-word'),
                        style: TextStyle(
                          fontSize: 60,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('wrong guesses: ' + widget.game.wrong_guesses,
                      key: Key('wrong-guesses'), style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
