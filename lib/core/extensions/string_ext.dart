extension FormatStringExt on String {
  String interpolate(String x, int n) {
    final buffer = StringBuffer();
    final str = replaceAll(x, '');

    for (int i = 0; i < str.length; i++) {
      final nthChar = (i + 1) % n == 0;
      final isEnd = i == str.length - 1;

      buffer.write(str[i]);
      if (nthChar && !isEnd) buffer.write(x);
    }
    return buffer.toString();
  }
}

extension TransformTextExt on String {
  String capitalize() {
    return this[0].toUpperCase() + substring(1);
  }

  String camelCaseToString() {
    final first = this[0].toUpperCase();

    String body = substring(1);
    body = body.splitMapJoin(
      RegExp(r'[A-Z]'),
      onMatch: (m) => ' ${m.group(0)}',
      onNonMatch: (n) => n,
    );
    return first + body.trim();
  }

  String camelCaseToSnakeCase() {
    final body = splitMapJoin(
      RegExp(r'[A-Z]'),
      onMatch: (m) => '_${m.group(0)?.toLowerCase()}',
      onNonMatch: (n) => n,
    );
    return body;
  }
}

extension SearchExt on String {
  bool search(String subStr) {
    return trim().toLowerCase().contains(subStr.trim().toLowerCase());
  }
}
