import 'package:miro/infra/dto/api/query_interx_status/pub_key.dart';

class ValidatorInfo {
  final String address;
  final PubKey pubKey;
  final String votingPower;

  ValidatorInfo({
    required this.address,
    required this.pubKey,
    required this.votingPower,
  });

  factory ValidatorInfo.fromJson(Map<String, dynamic> json) => ValidatorInfo(
        address: json['address'] as String,
        pubKey: PubKey.fromJson(json['pub_key'] as Map<String, dynamic>),
        votingPower: json['voting_power'] as String,
      );

  @override
  String toString() {
    return 'ValidatorInfo{address: $address, pubKey: $pubKey, votingPower: $votingPower}';
  }
}