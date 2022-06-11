import 'package:equatable/equatable.dart';

class QueryIdentityRecordVerifyRequestsReq extends Equatable {
  /// This is the identity record verify request address (approver or requester)
  final String address;

  /// This is an option for pagination. count_total is set to true
  /// to indicate that the result set should include a count of
  /// the total number of items available for pagination in UIs.
  /// count_total is only respected when offset is used.
  /// It is ignored when key is set
  final bool? countTotal;

  /// This is an option for pagination. key is a value returned in
  /// PageResponse.next_key to begin querying the next page most efficiently.
  /// Only one of offset or key should be set
  final String? key;

  /// This is an option for pagination. limit is the total number of results
  /// to be returned in the result page. If left empty it will default
  /// to a value to be set by each app
  final int? limit;

  /// This is an option for pagination. offset is a numeric offset
  /// that can be used when key is unavailable.
  /// It is less efficient than using key. Only one of offset or key should be set.
  final int? offset;

  const QueryIdentityRecordVerifyRequestsReq({
    required this.address,
    this.countTotal,
    this.key,
    this.limit,
    this.offset,
  });

  @override
  String toString() {
    return 'QueryIdentityRecordVerifyRequestsReq{countTotal: $countTotal, key: $key, limit: $limit, offset: $offset, address: $address}';
  }

  @override
  List<Object?> get props => <Object?>[
        countTotal,
        key,
        limit,
        offset,
        address,
      ];
}
