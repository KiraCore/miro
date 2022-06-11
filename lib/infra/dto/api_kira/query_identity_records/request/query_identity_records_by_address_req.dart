import 'package:equatable/equatable.dart';

class QueryIdentityRecordsByAddressReq extends Equatable {
  /// This is the identity record creator address
  final String creator;

  const QueryIdentityRecordsByAddressReq({
    required this.creator,
  });

  @override
  String toString() {
    return 'QueryIdentityRecordsByAddressReq{creator: $creator}';
  }

  @override
  List<Object?> get props => <Object?>[creator];
}
