class EmvCard {
  final String? number;
  final String? expire;
  final String? holder;
  final String? type;
  final String? status;
  final bool? isEmpty;

  const EmvCard({
    this.number,
    this.expire,
    this.holder,
    this.type,
    this.status,
    this.isEmpty,
  });

  factory EmvCard.fromMap(dynamic data) {
    final map = Map<String, dynamic>.from(data ?? {});

    return EmvCard(
      number: map['number']?.toString(),
      expire: map['expire']?.toString(),
      holder: map['holder']?.toString(),
      type: map['type']?.toString(),
      status: map['status']?.toString(),
      isEmpty: map['is_empty']?.toString() == "true",
    );
  }
}
