class ListUtils {
  static List<T> getSafeSublist<T>({required List<T> list, required int start, required int end}) {
    int startIndex = start < 0 ? 0 : start;
    if (startIndex > list.length) {
      return List<T>.empty(growable: true);
    }
    if (list.length < end) {
      return list.sublist(startIndex, list.length);
    } else {
      return list.sublist(startIndex, end);
    }
  }
}
