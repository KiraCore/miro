abstract class IListItem {
  String get cacheId;

  bool get isFavourite;

  set isFavourite(bool value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is IListItem && runtimeType == other.runtimeType && cacheId == other.cacheId;

  @override
  int get hashCode => cacheId.hashCode;
}
