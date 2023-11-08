import 'package:equatable/equatable.dart';

class PaginationDetailsModel extends Equatable {
  final int offset;
  final int limit;

  const PaginationDetailsModel({
    required this.offset,
    required this.limit,
  });

  @override
  List<Object?> get props => <Object?>[offset, limit];
}
