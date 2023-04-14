import 'package:equatable/equatable.dart';

class PageData<T> extends Equatable {
  final int index;
  final List<T> listItems;
  final bool isLastPage;

  const PageData({
    required this.index,
    required this.listItems,
    this.isLastPage = false,
  });

  PageData.initial()
      : index = -1,
        listItems = <T>[],
        isLastPage = false;

  @override
  List<Object?> get props => <Object?>[index, listItems, isLastPage];
}
