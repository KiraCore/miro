class CustomDateTime {
  static DateTime fromSeconds(int seconds) {
    return DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
  }
}

class DateTimeUtils {
  static bool isTheSameDay(DateTime a, DateTime b) {
    return a.day == b.day && a.month == b.month && a.year == b.year;
  }

  static bool isToday(DateTime? a) {
    if (a == null) return false;
    return isTheSameDay(a, DateTime.now());
  }

  static bool isLastWeek(DateTime? a, DateTime? b) {
    if (a == null || b == null) {
      return false;
    }
    bool endDateToday = isTheSameDay(DateTime.now(), b);
    bool startDateLastWeek = isTheSameDay(a, DateTime.now().subtract(const Duration(days: 7)));
    return endDateToday && startDateLastWeek;
  }

  static bool isLastMonth(DateTime? a, DateTime? b) {
    if (a == null || b == null) {
      return false;
    }
    bool endDateToday = isTheSameDay(DateTime.now(), b);
    bool startDateLastWeek = isTheSameDay(a, DateTime.now().subtract(const Duration(days: 30)));
    return endDateToday && startDateLastWeek;
  }
}
