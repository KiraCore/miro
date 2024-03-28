import 'package:equatable/equatable.dart';

class PageData<T> extends Equatable {
  final List<T> listItems;
  final bool lastPageBool;
  final DateTime? blockDateTime;
  final DateTime? cacheExpirationDateTime;

  const PageData({
    required this.listItems,
    this.blockDateTime,
    this.cacheExpirationDateTime,
    this.lastPageBool = false,
  });

  PageData.initial()
      : listItems = <T>[],
        blockDateTime = null,
        cacheExpirationDateTime = null,
        lastPageBool = false;

  PageData<T> copyWith({
    List<T>? listItems,
    bool? lastPageBool,
    DateTime? blockDateTime,
    DateTime? cacheExpirationDateTime,
  }) {
    return PageData<T>(
      listItems: listItems ?? this.listItems,
      lastPageBool: lastPageBool ?? this.lastPageBool,
      blockDateTime: blockDateTime ?? this.blockDateTime,
      cacheExpirationDateTime: cacheExpirationDateTime ?? this.cacheExpirationDateTime,
    );
  }

  @override
  List<Object?> get props => <Object?>[listItems, lastPageBool, blockDateTime, cacheExpirationDateTime];
}
