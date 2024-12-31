enum TransactionStatus {
  pending,
  approved,
  declined,
  failed,
  ;

  String toMap() => name;

  static TransactionStatus fromMap(dynamic data) {
    return values.byName(data.toString());
  }
}
