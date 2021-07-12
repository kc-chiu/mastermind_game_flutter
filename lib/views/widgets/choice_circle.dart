import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_state.dart';

// Build a circle for picking a guessed color

class ChoiceCircle extends StatelessWidget {
  ChoiceCircle(this.colorCode);

  final int colorCode;

  @override
  Widget build(BuildContext context) {
    final appState = context.read<AppState>();
    final gameColors = appState.gameColors;

    return Expanded(
      child: InkWell(
        onTap: () => appState.addGuessCode(colorCode),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: gameColors[colorCode],
          ),
        ),
      ),
    );
    ;
  }
}
