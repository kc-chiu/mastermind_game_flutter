import 'package:flutter/material.dart';

class GameColors {
  static const colors = [
    Colors.red, // 0
    Colors.orange, // 1
    Colors.yellow, // 2
    Colors.green, // 3
    Colors.blue, // 4 also for currentRow
    Colors.purple, // 5
    Colors.redAccent, // 6 positionMatched
    Colors.white, // 7 darkModeValueMatched
    Colors.black, // 8 lightModeValueMatched
    Colors.white12, // 9 darkModeEmptyCode
    Colors.black12, // 10 lightModeEmptyCode
    Colors.blueGrey // 11 solutionRowDefault
  ];

  static const currentRow = 4;
  static const positionMatched = 6;
  static const darkModeValueMatched = 7;
  static const lightModeValueMatched = 8;
  static const darkModeEmptyCode = 9;
  static const lightModeEmptyCode = 10;
  static const hiddenCodesRow = 11;
}
