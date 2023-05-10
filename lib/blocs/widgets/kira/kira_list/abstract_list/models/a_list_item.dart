abstract class AListItem {
  String get cacheId;

  bool get isFavourite;

  set favourite(bool value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is AListItem && runtimeType == other.runtimeType && cacheId == other.cacheId;

  @override
  int get hashCode => cacheId.hashCode;
}
