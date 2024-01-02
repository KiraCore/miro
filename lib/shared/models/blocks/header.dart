class Header {
  final String appHash;
  final String chainId;
  final String consensusHash;
  final String dataHash;
  final String evidenceHash;
  final String height;
  final String proposerAddress;
  final DateTime time;
  final String validatorsHash;

  Header({
    required this.appHash,
    required this.chainId,
    required this.consensusHash,
    required this.dataHash,
    required this.evidenceHash,
    required this.height,
    required this.proposerAddress,
    required this.time,
    required this.validatorsHash,
  });

  factory Header.fromJson(Map<String, dynamic> json) => Header(
        appHash: json['app_hash'] as String,
        chainId: json['chain_id'] as String,
        consensusHash: json['consensus_hash'] as String,
        dataHash: json['data_hash'] as String,
        evidenceHash: json['evidence_hash'] as String,
        height: json['height'] as String,
        proposerAddress: json['proposer_address'] as String,
        time: DateTime.parse(json['time'] as String),
        validatorsHash: json['validators_hash'] as String,
      );
}
