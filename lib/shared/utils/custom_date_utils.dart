class CustomDateUtils {
  static DateTime buildDateFromSecondsSinceEpoch(int seconds) {
    if (seconds < 0) {
      throw const FormatException('Seconds since epoch cannot be negative');
    } else if (seconds > 8640000000000) {
      throw const FormatException('Seconds since epoch cannot be larger than 8640000000000');
    }
    return DateTime.fromMillisecondsSinceEpoch(seconds * 1000, isUtc: true);
  }

  static int parseDateToSecondsSinceEpoch(DateTime date) {
    return date.millisecondsSinceEpoch ~/ 1000;
  }
}
