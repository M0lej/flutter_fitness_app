extension DoubleExtensions on double {
  double toFixed(int n) => double.parse(toStringAsFixed(n));
}
