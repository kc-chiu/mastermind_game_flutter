// Represent a player's guess and score
class Guess {
  Guess(this.codes, this.positionsMatched, this.valuesMatched);

  final List<int> codes;
  final int
      positionsMatched; // number of codes that match hidden codes in both position and values
  final int
      valuesMatched; // number of codes that match hidden code values but not position

}
