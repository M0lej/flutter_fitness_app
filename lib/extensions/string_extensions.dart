extension StringExtensions on String {
  String firstToUpperRestToLower() =>
      '${substring(0, 1).toUpperCase()}${substring(1).toLowerCase()}';
}
