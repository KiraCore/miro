import 'package:equatable/equatable.dart';

class QueryIdentityRecordReq extends Equatable {
  /// This is the identity record id
  final int id;

  const QueryIdentityRecordReq({
    required this.id,
  });

  @override
  String toString() {
    return 'QueryIdentityRecordReq{id: $id}';
  }

  @override
  List<Object?> get props => <Object?>[id];
}
