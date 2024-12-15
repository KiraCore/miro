extension ListExtension<E> on Iterable<E> {
  List<E> filter(bool Function(E element) test) => where(test).toList();

  List<List<E>> chunked(int chunkSize) {
    final List<List<E>> chunks = <List<E>>[];
    for (int i = 0; i < length; i += chunkSize) {
      final int end = i + chunkSize;
      chunks.add(toList().sublist(i, end > length ? length : end));
    }
    return chunks;
  }

  E? elementAtOrNull(int index) => index < length ? elementAt(index) : null;

  E? get firstOrNull => isEmpty ? null : first;

  E? get lastOrNull => isEmpty ? null : last;

  E? firstWhereOrNull(bool Function(E) test) {
    for (E element in this) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }

  List<E> whereNotNull() => where((E element) => element != null).cast<E>().toList();

  Map<K, E> associateBy<K>(K Function(E element) keyEvaluator) {
    final Map<K, E> map = <K, E>{};
    for (final E item in this) {
      final K key = keyEvaluator(item);
      map[key] = item;
    }
    return map;
  }

  Map<K, V> associate<K, V>(K Function(E element) keyEvaluator, V Function(E element) valueTransform) {
    final Map<K, V> map = <K, V>{};
    for (final E item in this) {
      final K key = keyEvaluator(item);
      final V value = valueTransform(item);
      map[key] = value;
    }
    return map;
  }
}

List<E> generateSeparatedList<E>(
  int itemCount, {
  required ListItemBuilder<E> itemBuilder,
  required ListItemBuilder<E> separatorBuilder,
}) {
  if (itemCount == 0) {
    return <E>[];
  }
  return List<E>.generate(itemCount * 2 - 1, (int index) {
    final int itemIndex = index ~/ 2;
    return index.isOdd ? separatorBuilder(itemIndex) : itemBuilder(itemIndex);
  });
}

typedef ListItemBuilder<T> = T Function(int index);
