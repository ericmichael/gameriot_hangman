import 'package:flutter/material.dart';
import 'package:hangman_game/models/hangmangame.dart';

import 'gamescreen.dart';

class WinScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("You Win", key: Key('win-text')),
            SizedBox(
                height: 300,
                child: Image(image: AssetImage('assets/progress_8.png'))),
          ],
        ),
      ),
    ));
  }
}
