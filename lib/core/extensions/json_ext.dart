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

  DateTime? decodeDateTime(String key) {
    return DateTime.tryParse(decodeStr(key));
  }

  DateTime decodeTimestamp(String key) {
    return DateTime.fromMillisecondsSinceEpoch(decodeInt(key));
  }
}
