import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import 'board.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final useDarkTheme = context.watch<AppState>().useDarkTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Mastermind'),
        actions: [
          IconButton(
            onPressed: () => context.read<AppState>().toggleTheme(),
            icon: Icon(useDarkTheme ? Icons.light_mode : Icons.dark_mode),
          ),
        ],
      ),
      body: Board(),
    );
  }
}
