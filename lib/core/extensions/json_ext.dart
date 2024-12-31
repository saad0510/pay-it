import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;

extension DeSerializationExt on Map {
  String decodeStr(String key) {
    return this[key]?.toString() ?? '';
  }

  String? decodeMaybeStr(String key) {
    return this[key]?.toString();
  }

  int decodeInt(String key) {
    return int.tryParse(decodeStr(key)) ?? 0;
  }

  double decodeDouble(String key) {
    return double.tryParse(decodeStr(key)) ?? 0;
  }

  bool decodeBool(String key) {
    return decodeStr(key) == 'true';
  }

  List decodeList(String key) {
    return List.from(this[key] ?? []);
  }

  DateTime decodeDateTime(String key) {
    final value = this[key];

    if (value is String) return DateTime.parse(decodeStr(key));
    if (value is int) return DateTime.fromMillisecondsSinceEpoch(decodeInt(key));
    if (value is Timestamp) return value.toDate();

    throw UnimplementedError('unsupported DateTime encoding');
  }
}

extension SerializationDateTimeExt on DateTime {
  Timestamp toFirebaseTimestamp() {
    return Timestamp.fromDate(this);
  }
}
