extension FormatIntExt on int {
  String get priceFromCents {
    return '\$${(this / 100).toStringAsFixed(2)}';
  }
}
