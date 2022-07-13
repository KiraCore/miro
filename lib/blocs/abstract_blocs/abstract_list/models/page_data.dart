class PageData<T> {
  final int index;
  final List<T> listItems;
  bool isLastPage;

  PageData({
    required this.index,
    required this.listItems,
    this.isLastPage = false,
  });

  PageData.initial()
      : index = -1,
        listItems = <T>[],
        isLastPage = false;

  @override
  String toString() {
    return 'PageData{index: $index, listItems: $listItems, isLastPage: $isLastPage}';
  }
}
