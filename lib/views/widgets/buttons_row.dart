import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_state.dart';
import '../info.dart';

// Build the row of buttons at the screen bottom

class ButtonsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Prepare a list of icons and on-pressed actions of the buttons
    // Then return a row of buttons based on the list
    final List<Map<String, dynamic>> buttons = [
      {
        'icon': Icons.info,
        'action': () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => Info())),
      },
      {
        'icon': Icons.backspace,
        'action': () => context.read<AppState>().removeGuessCode(),
      },
      {
        'icon': Icons.done,
        'action': () => context.read<AppState>().checkGuessCodes(),
      },
      {
        'icon': Icons.play_arrow,
        'action': () {
          if (context.read<AppState>().gameInPlay) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                  title: Text('Start a New Game?'),
                  content: Text('Current game data will be deleted.'),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Cancel')),
                    ElevatedButton(
                        onPressed: () {
                          context.read<AppState>().startGame();
                          Navigator.pop(context);
                        },
                        child: Text('Start'))
                  ]),
            );
          } else {
            context.read<AppState>().startGame();
          }
        },
      },
    ];

    return Row(
        children: List.generate(
            buttons.length,
            (i) => Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                    child: ElevatedButton(
                        onPressed: buttons[i]['action'],
                        child: Icon(buttons[i]['icon'], size: 32)),
                  ),
                )));
  }
}
