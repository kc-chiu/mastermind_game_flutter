import 'package:flutter/material.dart';
import 'models/models.dart';

class AppState with ChangeNotifier {
  AppState() {
    startGame();
  }

  // Default to use Dark Mode
  var useDarkTheme = true;
  var valueMatchedCode = GameColors.darkModeValueMatched;
  var emptyCode = GameColors.darkModeEmptyCode;
  final positionMatchedCode = GameColors.positionMatched;
  final currentRowCode = GameColors.currentRow;
  var hiddenCodesRowCode = GameColors.hiddenCodesRow;

  void toggleTheme() {
    useDarkTheme = !useDarkTheme;
    valueMatchedCode = useDarkTheme
        ? GameColors.darkModeValueMatched
        : GameColors.lightModeValueMatched;
    emptyCode = useDarkTheme
        ? GameColors.darkModeEmptyCode
        : GameColors.lightModeEmptyCode;
    _setGuessRowsColorCodes();
    notifyListeners();
  }

  int get numberOfGuessRows => Game.numberOfGuessRows;
  List<int> get codeChoices => Game.codeChoices;
  List<Color> get gameColors => GameColors.colors;

  late Game _game;
  late List<int> _hiddenCodes;
  List<int> get hiddenCodes => _hiddenCodes;
  late GameState _gameState;
  late List<Map<String, List<int>>> _guessRowsColorCodes;
  List<Map<String, List<int>>> get guessRowsColorCodes => _guessRowsColorCodes;
  late bool _gameInPlay;
  bool get gameInPlay => _gameInPlay;

  // Stores player's guess before submitting for scoring
  late List<int> _guessCodes;

  void startGame() {
    _game = Game();
    _getHiddenCodes();
    _getGameState();
    _setGameInPlay();
    _resetGuessCodes();
    _setGuessRowsColorCodes();
    notifyListeners();
  }

  void _getHiddenCodes() => _hiddenCodes = _game.hiddenCodes;
  void _getGameState() => _gameState = _game.gameState;
  void _setGameInPlay() => _gameInPlay = _gameState == GameState.playing;
  void _resetGuessCodes() => _guessCodes = [];

  void addGuessCode(int code) {
    if (_gameState == GameState.playing &&
        _guessCodes.length < _hiddenCodes.length) {
      _guessCodes.add(code);
      _setGuessRowsColorCodes();
      notifyListeners();
    }
  }

  void removeGuessCode() {
    if (_gameState == GameState.playing && _guessCodes.isNotEmpty) {
      _guessCodes.removeLast();
      _setGuessRowsColorCodes();
      notifyListeners();
    }
  }

  void checkGuessCodes() {
    if (_gameState == GameState.playing &&
        _guessCodes.length == _hiddenCodes.length) {
      _game.checkGuessCodes(_guessCodes);
      _getGameState();
      _setGameInPlay();
      _resetGuessCodes();
      _setGuessRowsColorCodes();
      notifyListeners();
    }
  }

  void _setGuessRowsColorCodes() {
    final guessesChecked = _game.guessesChecked;
    _guessRowsColorCodes = [];

    // Set color codes of rows with guess checked
    // There will be none when game starts
    guessesChecked.forEach((guess) {
      // Convert guess score into color codes for a row
      final List<int> scoreCodes = [];
      scoreCodes.addAll(
          List.generate(guess.positionsMatched, (_) => positionMatchedCode));
      scoreCodes
          .addAll(List.generate(guess.valuesMatched, (_) => valueMatchedCode));
      scoreCodes.addAll(List.generate(
          _hiddenCodes.length - scoreCodes.length, (_) => emptyCode));
      // Set color codes of the row
      _guessRowsColorCodes.add({
        'icon': [emptyCode],
        'guess': guess.codes,
        'score': scoreCodes
      });
    });

    // The icon color codes of the rows above are all `emptyCode`
    // However, if the player has won already, change the icon color
    // of the last row to `positionMatchedCode`
    if (_gameState == GameState.playerWon) {
      _guessRowsColorCodes.last['icon']![0] = positionMatchedCode;
    }

    // Set the color codes of the current row
    // (if the game is still in play)
    if (_guessRowsColorCodes.length < numberOfGuessRows) {
      // Color codes of guess circles depend on player's guess
      // 'no-guess' positions will be filled with `emptyCode`
      final List<int> guessCodes = [];
      guessCodes.addAll(_guessCodes);
      guessCodes.addAll(List.generate(
          _hiddenCodes.length - guessCodes.length, (_) => emptyCode));

      // If the game is still in play,
      // the icon will indicate the row as current row
      _guessRowsColorCodes.add({
        'icon': [
          _gameState == GameState.playerWon ? emptyCode : currentRowCode
        ],
        'guess': guessCodes,
        'score': List.generate(_hiddenCodes.length, (index) => emptyCode)
      });
    }

    // Set color codes of remaining rows (if any) to `emptyCode`
    _guessRowsColorCodes.addAll(List.generate(
        numberOfGuessRows - _guessRowsColorCodes.length,
        (_) => {
              'icon': [emptyCode],
              'guess': List.generate(_hiddenCodes.length, (_) => emptyCode),
              'score': List.generate(_hiddenCodes.length, (_) => emptyCode)
            }));
  }
}
