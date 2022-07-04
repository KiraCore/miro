class PageDetails<T> {
  final int index;
  final List<T> data;
  bool lastPage;

  PageDetails({
    required this.index,
    required this.data,
    this.lastPage = false,
  });

  PageDetails.initial()
      : index = -1,
        lastPage = false,
        data = <T>[];

  @override
  String toString() {
    return 'PageDetails{index: $index, data: $data, lastPage: $lastPage}';
  }
}
