extension StringCasingExtension on String {
  /// Capitalizes the first letter of the string.
  String toCapitalized() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
