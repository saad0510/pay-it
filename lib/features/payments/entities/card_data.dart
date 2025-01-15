class CardData {
  final String holderName;
  final String cardNumber;
  final String applicationName;
  final String expirtyDate;
  final bool isEmpty;

  const CardData({
    required this.holderName,
    required this.cardNumber,
    required this.applicationName,
    required this.expirtyDate,
    required this.isEmpty,
  });

  CardData copyWith({
    String? holderName,
    String? cardNumber,
    String? applicationName,
    String? expirtyDate,
    bool? isEmpty,
  }) {
    return CardData(
      holderName: holderName ?? this.holderName,
      cardNumber: cardNumber ?? this.cardNumber,
      applicationName: applicationName ?? this.applicationName,
      expirtyDate: expirtyDate ?? this.expirtyDate,
      isEmpty: isEmpty ?? this.isEmpty,
    );
  }
}
