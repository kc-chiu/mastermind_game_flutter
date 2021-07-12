import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_state.dart';
import 'widgets.dart';

// Compose the row for picking guessed colors including
// an icon at both ends of the row and 6 big color circles

class ChoicesRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = context.read<AppState>();
    final codeChoices = appState.codeChoices;
    final gameColors = appState.gameColors;
    final iconColor = gameColors[appState.currentRowCode];

    // Prepare a list of widgets
    // Then return a row with the list as children
    final choicesRowChildren = <Widget>[];

    // The beginning icon
    choicesRowChildren.add(
      ColorIcon(
        Icons.touch_app_outlined,
        iconColor,
      ),
    );

    // The 6 big color circles for guessed colors
    // choicesRowChildren.addAll(
    // List.generate(nPossibleCodes, (colorCode) => ChoiceCircle(colorCode)));
    codeChoices.forEach(
        (colorCode) => choicesRowChildren.add(ChoiceCircle(colorCode)));
    // The ending icon
    choicesRowChildren.add(ColorIcon(
      Icons.touch_app_outlined,
      iconColor,
    ));

    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(3.0),
        child: Row(
          children: choicesRowChildren,
        ),
      ),
    );
  }
}
