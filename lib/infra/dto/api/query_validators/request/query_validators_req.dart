class QueryValidatorsReq {
  /// This is an option to query validator by a given kira address
  final String? address;

  /// This is an option to query all validators
  final bool? all;

  /// This is an option to validators pagination. count_total is set to true
  /// to indicate that the result set should include a count of the total number
  /// of items available for pagination in UIs. count_total is only respected
  /// when offset is used. It is ignored when key is set.
  final bool? countTotal;

  /// This is an option to validators pagination. key is a value returned in
  /// PageResponse.next_key to begin querying the next page most efficiently.
  /// Only one of offset or key should be set.
  // TODO(dominik): Probably not working. How to get this parameter?
  final String? key;

  /// This is an option to validators pagination. limit is the total number
  /// of results to be returned in the result page.
  /// If left empty it will default to a value to be set by each app.
  final String? limit;

  /// This is an option to query validator by a given moniker
  final String? moniker;

  /// This is an option to validators pagination. offset is a numeric
  /// offset that can be used when key is unavailable.
  /// It is less efficient than using key. Only one of offset or key should be set
  final String? offset;

  /// This is an option to query validators by a given proposer address
  final String? proposer;

  /// This is an option to query validator by a given pubkey
  final String? pubkey;

  /// This is an option to query validators by a given status
  final String? status;

  /// This is an option to query validator by a given valoper address
  final String? valkey;

  /// Returns [Status] class only
  final bool? statusOnly;

  QueryValidatorsReq({
    this.address,
    this.all,
    this.countTotal,
    this.key,
    this.limit,
    this.moniker,
    this.offset,
    this.proposer,
    this.pubkey,
    this.status,
    this.valkey,
    this.statusOnly,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'address': address,
      'all': all,
      'count_total': countTotal,
      'key': key,
      'limit': limit,
      'moniker': moniker,
      'offset': offset,
      'proposer': proposer,
      'pubkey': pubkey,
      'status': status,
      'valkey': valkey,
      'status_only': statusOnly,
    };
  }
}
