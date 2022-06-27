class PageDetails<T> {
  final int index;
  final List<T> listItems;
  bool lastPage;

  PageDetails({
    required this.index,
    required this.listItems,
    this.lastPage = false,
  });

  PageDetails.initial()
      : index = -1,
        listItems = <T>[],
        lastPage = false;

  @override
  String toString() {
    return 'PageDetails{index: $index, listItems: $listItems, lastPage: $lastPage}';
  }
}
