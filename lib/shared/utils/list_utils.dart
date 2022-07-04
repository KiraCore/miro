class ListUtils {
  static List<dynamic> safeSublist(List<dynamic> list, int start, int end) {
    int startIndex = start < 0 ? 0 : start;
    if (list.length < end) {
      return list.sublist(startIndex, list.length);
    } else {
      return list.sublist(startIndex, end);
    }
  }
}
