// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('HangMan App', () {
    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    group('Start a new Game', () {
      test('I should find a start game button that takes me to gamescreen',
          () async {
        final newGameBtnFinder = find.byValueKey('new-game-button');
        final newGameTextFinder = find.byValueKey('new-game-text');

        expect(await driver.getText(newGameTextFinder), "New Game");

        // First, tap the button.
        await driver.tap(newGameBtnFinder);

        final guessLetterTextFindert = find.byValueKey('guess-letter-text');

        expect(await driver.getText(guessLetterTextFindert), "Guess Letter");
      });

      test('Scenario: guess correct letter that occurs once', () async {
        final findGuessTextField = find.byValueKey('guess-textfield');
        final guessLetterBtnFinder = find.byValueKey('guess-letter-btn');
        final findBlackWord = find.byValueKey('blank-word');

        expect(await driver.getText(findBlackWord), '------');

        await driver.tap(findGuessTextField);
        await driver.enterText('b');
        await driver.waitFor(find.text('b'));

        await driver.tap(guessLetterBtnFinder);

        // the word is 'banana'
        expect(await driver.getText(findBlackWord), 'b-----');
      });

      test('Scenario: guess correct letter that occurs multiple times',
          () async {
        final findGuessTextField = find.byValueKey('guess-textfield');
        final guessLetterBtnFinder = find.byValueKey('guess-letter-btn');
        final findBlackWord = find.byValueKey('blank-word');

        await driver.tap(findGuessTextField);
        await driver.enterText('n');
        await driver.waitFor(find.text('n'));

        await driver.tap(guessLetterBtnFinder);

        // the word is 'banana'
        expect(await driver.getText(findBlackWord), 'b-n-n-');
      });

      test('Scenario: guess incorrect letter', () async {
        final findGuessTextField = find.byValueKey('guess-textfield');
        final guessLetterBtnFinder = find.byValueKey('guess-letter-btn');
        final findBlackWord = find.byValueKey('blank-word');
        final findGuessesText = find.byValueKey('wrong-guesses');

        await driver.tap(findGuessTextField);
        await driver.enterText('z');
        await driver.waitFor(find.text('z'));

        await driver.tap(guessLetterBtnFinder);

        // the word is 'banana'
        // blank word did not change because of incorrect guess
        expect(await driver.getText(findBlackWord), 'b-n-n-');

        // check that wrong guess has wrong letter
        String guessesList = await driver.getText(findGuessesText);
        expect(guessesList.contains('z'), isTrue);
      });

      test('Scenario: multiple correct and incorrect guesses', () async {
        final findBlackWord = find.byValueKey('blank-word');
        final findGuessesText = find.byValueKey('wrong-guesses');

        expect(await driver.getText(findBlackWord), 'b-n-n-');
        String guessesList = await driver.getText(findGuessesText);

        expect(guessesList.contains('z'), isTrue);
      });

      test('Scenario: game over because I guess the word', () async {
        final findGuessTextField = find.byValueKey('guess-textfield');
        final guessLetterBtnFinder = find.byValueKey('guess-letter-btn');
        final findWinText = find.byValueKey('win-text');
        final newGameBtn = find.byValueKey('new-game-btn');

        await driver.tap(findGuessTextField);
        await driver.enterText('a');
        await driver.waitFor(find.text('a'));

        await driver.tap(guessLetterBtnFinder);

        expect(await driver.getText(findWinText), 'You Win');

        await driver.tap(newGameBtn);
      });

      test('Scenario: game over because I run out of guesses', () async {
        final findGuessTextField = find.byValueKey('guess-textfield');
        final guessLetterBtnFinder = find.byValueKey('guess-letter-btn');
        final findLoseText = find.byValueKey('lose-text');
        final newGameBtn = find.byValueKey('new-game-btn');

        List<String> wrongGuesses = ['q', 'w', 'e', 'r', 't', 'y', 'u'];

        for (int i = 0; i < wrongGuesses.length; i++) {
          await driver.tap(findGuessTextField);
          await driver.enterText(wrongGuesses[i]);
          await driver.waitFor(find.text(wrongGuesses[i]));

          await driver.tap(guessLetterBtnFinder);
        }

        expect(await driver.getText(findLoseText), 'You Lose');

        await driver.tap(newGameBtn);
      });

      test('Scenario: guess correct letter that I have already tried',
          () async {
        final findGuessTextField = find.byValueKey('guess-textfield');
        final guessLetterBtnFinder = find.byValueKey('guess-letter-btn');
 
        String correctLetter = 'b';
        await driver.tap(findGuessTextField);
        await driver.enterText(correctLetter);
        await driver.waitFor(find.text(correctLetter));

        await driver.tap(guessLetterBtnFinder);

        // try guessing same letter again
        await driver.tap(findGuessTextField);
        await driver.enterText(correctLetter);
        await driver.waitFor(find.text(correctLetter));

        await driver.tap(guessLetterBtnFinder);

        expect(find.text('already used that letter'), isNotNull);
      });

      test('Scenario: guess correct letter that I have already tried',
          () async {
        final findGuessTextField = find.byValueKey('guess-textfield');
        final guessLetterBtnFinder = find.byValueKey('guess-letter-btn');

        String wrongLetter = 'q';
        await driver.tap(findGuessTextField);
        await driver.enterText(wrongLetter);
        await driver.waitFor(find.text(wrongLetter));

        await driver.tap(guessLetterBtnFinder);

        await driver.tap(findGuessTextField);
        await driver.enterText(wrongLetter);
        await driver.waitFor(find.text(wrongLetter));

        await driver.tap(guessLetterBtnFinder);

        expect(find.text('already used that letter'), isNotNull);
      });

      test('Scenario: guess correct letter that I have already tried',
          () async {
        final findGuessTextField = find.byValueKey('guess-textfield');
        final guessLetterBtnFinder = find.byValueKey('guess-letter-btn');
        final findLoseText = find.byValueKey('lose-text');

        String wrongLetter = 'q';

        for (int i = 0; i < 10; i++) {
          await driver.tap(findGuessTextField);
          await driver.enterText(wrongLetter);
          await driver.waitFor(find.text(wrongLetter));

          await driver.tap(guessLetterBtnFinder);
        }

        expect(find.text('already used that letter'), isNotNull);
      });
    });
  });
}
