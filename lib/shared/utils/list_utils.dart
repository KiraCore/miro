extension SafeSublistExtension<T> on List<T> {
  List<T> safeSublist(int start, int end) {
    int startIndex = start < 0 ? 0 : start;
    if (length < end) {
      return sublist(startIndex, length);
    } else {
      return sublist(startIndex, end);
    }
  }
}
