import 'guess.dart';
import 'dart:math';

class Game {
  Game() {
    // Generate the codes to be guessed by the player
    _genHiddenCodes();
    _gameState = GameState.playing;
  }

  // Number of rows on the game board for guessing the hidden codes
  static const _numberOfGuessRows = 10;
  static int get numberOfGuessRows => _numberOfGuessRows;

  // Number of codes to be guessed
  // Feasible values for mobile phone screens: 4, 5 and 6
  static const _numberOfHiddenCodes = 4;

  // Possible hidden code values: [0, 1, 2,...]
  static List<int> _codeChoices = List.generate(6, (code) => code);
  static List<int> get codeChoices => _codeChoices;

  late List<int> _hiddenCodes;
  List<int> get hiddenCodes => _hiddenCodes;
  late GameState _gameState;
  GameState get gameState => _gameState;

  // Player's guess and score are stored in a Guess object
  // Guess objects are stored in this list
  final List<Guess> _guessesChecked = [];
  List<Guess> get guessesChecked => _guessesChecked;

  void _genHiddenCodes() {
    final random = Random();
    _hiddenCodes = List.generate(
        _numberOfHiddenCodes, (_) => random.nextInt(_codeChoices.length));
  }

  void checkGuessCodes(List<int> codes) {
    final guessCodes = List.from(codes);
    final hiddenCodes = List.from(_hiddenCodes);
    final matchedPositions = [];
    for (int i = 0; i < guessCodes.length; i++) {
      if (guessCodes[i] == hiddenCodes[i]) {
        matchedPositions.add(guessCodes[i]);
      }
    }

    // Remove the exactly matched codes before checking for value match
    matchedPositions.forEach((code) {
      guessCodes.remove(code);
      hiddenCodes.remove(code);
    });

    var valuesMatched = 0;
    guessCodes.forEach((code) {
      if (hiddenCodes.contains(code)) {
        valuesMatched += 1;
        // Remove a value matched code to avoid duplicated counts
        hiddenCodes.remove(code);
      }
    });

    // Store the guess codes and score in a Guess object
    _guessesChecked.add(Guess(codes, matchedPositions.length, valuesMatched));

    _setGameState();
  }

  void _setGameState() {
    if (_guessesChecked.last.positionsMatched == _numberOfHiddenCodes) {
      _gameState = GameState.playerWon;
    } else if (_guessesChecked.length == numberOfGuessRows) {
      _gameState = GameState.over;
    }
  }
}

enum GameState { playing, playerWon, over }
