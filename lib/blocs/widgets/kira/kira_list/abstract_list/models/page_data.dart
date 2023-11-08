import 'package:equatable/equatable.dart';

class PageData<T> extends Equatable {
  final List<T> listItems;
  final bool lastPageBool;

  const PageData({
    required this.listItems,
    this.lastPageBool = false,
  });

  PageData.initial()
      : listItems = <T>[],
        lastPageBool = false;

  @override
  List<Object?> get props => <Object?>[listItems, lastPageBool];
}
