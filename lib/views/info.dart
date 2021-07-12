import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Game Info')),
      body: ListView(
        padding: EdgeInsets.all(12.0),
        children: [
          Text('Goal: Guess the 4 colors hidden by the app'),
          Text('It is possible that all 4 colors are the same'),
          Text(''),
          Text('Each row of light grey circles are for one guess'),
          Text(''),
          Text('Dots at the end of each row show the result of the guess'),
          Text(' - Correct color and position: Red dot'),
          Text(' - Correct color but wrong position:'),
          Text('   - Black dot (light mode)'),
          Text('   - White dot (dark mode)'),
          Text(' - Wrong guess: Grey dot'),
          Text(''),
          Text('Near screen bottom:'),
          Text(
              'Blue grey circles between the light bulbs are the hidden colors'),
          Text('6 color circles between the tapping fingers:'),
          Text(
              'Tap a color circle. It will be placed at a guessing circle automatically'),
          Text(''),
          Text('Blue buttons:'),
          Text('"Play" button: Start a new game'),
          Text('"Check" button: Verify your guess'),
          Text('"Backspace": Cancel a previous color'),
          Text('"Info": Show this info'),
        ],
      ),
    );
  }
}
