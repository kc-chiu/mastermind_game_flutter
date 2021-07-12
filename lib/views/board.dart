import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import 'widgets/widgets.dart';

// Compose the game board including
// rows for placing player's guessed colors,
// a row for the hidden codes,
// a row for choosing colors for a guess,
// a row of buttons for playing the game.

class Board extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = context.read<AppState>();
    final gameColors = appState.gameColors;
    final gameInPlay = context.watch<AppState>().gameInPlay;
    final dividerColor = gameColors[gameInPlay
        ? appState.hiddenCodesRowCode
        : appState.positionMatchedCode];
    final guessRowsColorCodes = context.watch<AppState>().guessRowsColorCodes;

    // Prepare a list of widgets
    // Then return a column with the list as children
    final boardChildren = <Widget>[];
    boardChildren.addAll(List.generate(guessRowsColorCodes.length,
        (row) => GuessRow(guessRowsColorCodes[row])));
    boardChildren.add(Divider(height: 8.0, color: dividerColor));
    boardChildren.add(HiddenCodesRow(gameInPlay));
    boardChildren.add(Divider(height: 8.0, color: dividerColor));
    boardChildren.add(ChoicesRow());
    boardChildren.add(ButtonsRow());

    return Column(
      children: boardChildren,
    );
  }
}
