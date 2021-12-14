class QueryAccountResp {
  final String type;
  final String accountNumber;
  final String address;
  final String? pubKey;
  final String? sequence;

  QueryAccountResp({
    required this.type,
    required this.accountNumber,
    required this.address,
    this.pubKey,
    this.sequence,
  });

  factory QueryAccountResp.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> accountJson = json['account'] as Map<String, dynamic>;

    return QueryAccountResp(
      type: accountJson['@type'] as String,
      accountNumber: accountJson['account_number'] as String,
      address: accountJson['address'] as String,
      pubKey: accountJson['pub_key'] as String?,
      sequence: accountJson['sequence'] as String?,
    );
  }

  @override
  String toString() {
    return 'QueryAccountResp{type: $type, accountNumber: $accountNumber, address: $address, pubKey: $pubKey, sequence: $sequence}';
  }
}
