extension FormatExt on String {
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
