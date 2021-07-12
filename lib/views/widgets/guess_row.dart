import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_state.dart';
import 'widgets.dart';

// Compose a row for placing the guessed colors including
// a row indicator arrow, 4 big circles for the guessed colors
// and 4 small circles for showing the guess correctness

class GuessRow extends StatelessWidget {
  GuessRow(this.rowColorCodes);

  final Map<String, List<int>> rowColorCodes;

  @override
  Widget build(BuildContext context) {
    final appState = context.read<AppState>();
    final gameColors = appState.gameColors;

    // Prepare a list of widgets
    // Then return a row with the list as children
    final guessRowChildren = <Widget>[];

    // The row indicator arrow
    final iconCodes = rowColorCodes['icon'];
    guessRowChildren.add(ColorIcon(
      iconCodes![0] != appState.positionMatchedCode
          ? Icons.play_arrow
          : Icons.verified,
      gameColors[iconCodes[0]],
      size: iconCodes[0] == appState.currentRowCode ? 48 : 42,
    ));

    // The 4 big circles for placing the guessed colors
    final guessCodes = rowColorCodes['guess'];
    guessRowChildren.addAll(List.generate(
        guessCodes!.length, (i) => ColorCircle(gameColors[guessCodes[i]])));

    // The 4 small circles showing the guess correctness
    final scoreCodes = rowColorCodes['score'];
    final halfScoreCodes = scoreCodes!.length ~/ 2;
    final nCircles = [
      halfScoreCodes,
      scoreCodes.length % 2 == 0 ? halfScoreCodes : halfScoreCodes + 1
    ];
    final offsets = [0, halfScoreCodes];
    guessRowChildren.add(Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
            children: List.generate(
          2,
          (row) => Expanded(
            child: Padding(
              padding: EdgeInsets.all(3.0),
              child: Row(
                  children: List.generate(
                      nCircles[row],
                      (i) => ColorCircle(
                          gameColors[scoreCodes[i + offsets[row]]]))),
            ),
          ),
        )),
      ),
    ));

    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(3.0),
        child: Row(
          children: guessRowChildren,
        ),
      ),
    );
  }
}
