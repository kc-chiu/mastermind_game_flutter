import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets.dart';
import '../../app_state.dart';

// Compose the row for showing the colors hidden by the Game
// including an icon at both ends of the row and
// the 4 big circles holding the hidden colors

class HiddenCodesRow extends StatelessWidget {
  HiddenCodesRow(this.gameInPlay);

  final bool gameInPlay;

  @override
  Widget build(BuildContext context) {
    final appState = context.read<AppState>();
    final gameColors = appState.gameColors;
    final hiddenCodes = appState.hiddenCodes;
    final iconColor = gameColors[gameInPlay
        ? appState.hiddenCodesRowCode
        : appState.positionMatchedCode];

    // Prepare a list of widgets
    // Then return a row with the list as children
    final hiddenCodesRowChildren = <Widget>[];

    // The beginning icon
    hiddenCodesRowChildren.add(ColorIcon(
      Icons.emoji_objects_outlined,
      iconColor,
    ));

    // The 4 big circles holding the hidden colors
    // They will show the hidden codes once the player wins
    // or the game ends.
    hiddenCodesRowChildren.addAll(List.generate(hiddenCodes.length, (i) {
      final color =
          gameColors[gameInPlay ? appState.hiddenCodesRowCode : hiddenCodes[i]];
      return ColorCircle(color);
    }));

    // The ending icon
    hiddenCodesRowChildren.add(ColorIcon(
      Icons.emoji_objects_outlined,
      iconColor,
    ));

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Row(
          children: hiddenCodesRowChildren,
        ),
      ),
    );
  }
}
