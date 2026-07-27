extension IntExtensions on int {
  String toTwoDigitString() => this < 10 ? "0$this" : toString();
}
