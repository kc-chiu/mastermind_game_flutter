import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'views/home.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AppState>(
        create: (context) => AppState(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final useDarkTheme = context.watch<AppState>().useDarkTheme;
    return MaterialApp(
      home: Home(),
      theme: useDarkTheme ? ThemeData.dark() : ThemeData.light(),
    );
  }
}
