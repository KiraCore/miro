import 'package:equatable/equatable.dart';

class BlockTimeWrapperModel<T> extends Equatable {
  final T model;
  final DateTime blockDateTime;

  const BlockTimeWrapperModel({
    required this.model,
    required this.blockDateTime,
  });

  @override
  List<Object?> get props => <Object?>[model, blockDateTime];
}
