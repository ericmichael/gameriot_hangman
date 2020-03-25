## The story up until now

You've been contacted by GameRiot, Inc. GameRiot is a company that specializes in mobile games for iOS and Android. GameRiot has been in a slump for some time now. Small mobile games just aren't making as much money as they need to. To try to increase profits, Bob Stark (the CEO) has ordered each developer to try to come up with a small game that can be launched quickly, cheaply, & profitably. Mr. Stark is willing to take some losses if some games don't make any money. Mr. Stark, although he can be *sometimes cheap*, is huge on process, agile, and dev ops. He thinks that small groups of developers should be able to add to the companies bottom line (his wallet) by working smart and shipping quickly.



Rick Hernandez was a developer working at GameRiot. Hangman was his project. He was new to the company, fresh out of university. His experience was in C++, Java, algorithms, and machine learning. He also knew a little bit of web development. Mobile development was still pretty new to him so his developer friends at GameRiot were showing him the ropes. Rick was a good guy but he didn't always make the right choices. Getting a job as a programmer was always one of his dreams but his real passion was music. One day he received the call to tour with the Trans-Siberian Orchestra playing violin -- this was one of his bigger dreams. He had to take it and resigned immediately at GameRiot.



You have now inherited Rick's codebase. Rick was somewhat familiar with the right process although he made a lot of mistakes. He wasn't using version control from the begininng. When he finally checked in all his files, he did so to master --- and he forgot some. Some files are missing. Also although he has tests, not all of them pass.



Fortunately, Mr. Stark conveyed the importance of testing to all his employees and at least that stuck. All the tests are there but a few of them are failing due to missing files. Some tests are failing because the UI code was never finished.



This code base is what is considered **legacy code** because:

- it stills meets the customer's need but:
  - you didn't write it and it's poorly document or
  - you did write it, but a long time ago (and it's poorly documented) or
  - it lacks good tests (regardless of who wrote it)



In this case it is because you didn't write it and it's poorly documented.

One of the many benefits of testing is that is kind of *serves as documentation*. It tells us what the features are and what it is supposed to do. Fortunately for you, Rick did his best to properly test his code.



Our goal now is to take control of this project, bring it back to life, and make it a success.



----------------------------------------------



# Hangman Game

A Hangman Flutter app with unit, widget, and integration tests.



# HangmanGame Class

It handles the game logic

```dart
    // pass in the secret word
    var game = HangmanGame('banana');

    bool wasAbleToMakeGuess = game.guess('b');
    print(game.blanks_with_correct_guesses) // b-----
    print(game.status) //returns win, lose, or play
    
```



# HangmanGame Class Unit Test

to run test do

```console
flutter test test/hangmangame_test.dart
```

Or in VS Code

1. Open the test/hangmangame_test.dart file
2. While in the test/hangmangame_test.dart file
3. Select the Debug menu
4. Click the Run Without Debuging option



## Overview of unit tests

### Making a new game
* tests word is initialized
* tests correct_guesses is empty at first
* tests wrong_guesses is empty at first



### Guessing Behavior (function guess(String letter))

* tests if user guess is not a letter an ArgumentError is thrown
* tests if user guess is correct it's added correct_guesses
* tests if user guess is incorrect it's added wrong_guesses
* tests guess function return true if user guess was accepted (note: does not return if guess was correct or wrong just if it was accepted)
* tests guess function returns false for duplicate letter guess
* tests that guess function is case insensitive



### Displaying Blanks with Correct Guesses

```dart
    var game = HangmanGame('banana');

    print(game.blanks_with_correct_guesses) // ------

    game.guess('b');
    game.guess('n');

    print(game.blanks_with_correct_guesses) // b-n-n-
```
* tests that at first all letters are '-' for 
* tests that when a  guess is made blanks_with_correct_guesses is updated properly



### Game Status

```dart
    var game = HangmanGame('car');

    print(game.status) // play

    game.guess('c');
    game.guess('a')
    game.guess('r');

    print(game.status) // win
```
* test status is update to win when user guesses all letters
* test status is update to lose after 7 incorrect guesses
* test status is play otherwise



# Widget Tests

We use unit test to test our pure classes, functions etc. and logic but now to test Widget we use Flutter's Test Widget package it work in the same manner as unit tests but provide tools to interact with Widgets 
like tapping buttons, finding text, entering text, searching the widget tree.

```console
flutter test test/widget_test.dart
```

Or in VS Code

1. Open the test/widget_test.dart file
2. While in the test/widget_test.dart file
3. Select the Debug menu
4. Click the Run Without Debuging option



# Integration Tests

Unit tests and widget tests are handy for testing individual classes, functions, or widgets. While Integration Test test applications as a whole running on a device. It tests UI as well as the flow between screens.

To run the Integration Test you will need a device connected or a simulator running.

Use the following command to run the integration tests

```console
flutter drive --target=test_driver/app.dart
```



## Overview of integration tests

At a highlevel the integration test works like how a user would interact with the app.

It makes sure the user can go from the Main Screen to the Game Screen and play the game. We know the game logic works because of our unit test now we need to test that the UI shows this interactions as the user plays and tries diffrent cases. The integration test runs various cases like inputting correct, wrong, duplicate, invalid guesses. As well as testing the flow from the Game Page to Winning or Losing Page.





