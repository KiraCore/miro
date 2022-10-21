import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api/query_interx_status/node.dart';
import 'package:miro/infra/dto/api/query_interx_status/pub_key.dart';

class InterxInfo extends Equatable {
  final bool catchingUp;
  final String chainId;
  final String genesisChecksum;
  final String kiraAddress;
  final String kiraPubKey;
  final String latestBlockHeight;
  final String moniker;
  final Node node;
  final PubKey pubKey;
  final String version;
  final String? faucetAddress;

  const InterxInfo({
    required this.catchingUp,
    required this.chainId,
    required this.genesisChecksum,
    required this.kiraAddress,
    required this.kiraPubKey,
    required this.latestBlockHeight,
    required this.moniker,
    required this.node,
    required this.pubKey,
    required this.version,
    this.faucetAddress,
  });

  factory InterxInfo.fromJson(Map<String, dynamic> json) => InterxInfo(
        catchingUp: json['catching_up'] as bool,
        chainId: json['chain_id'] as String,
        genesisChecksum: json['genesis_checksum'] as String,
        kiraAddress: json['kira_addr'] as String,
        kiraPubKey: json['kira_pub_key'] as String,
        latestBlockHeight: json['latest_block_height'] as String,
        moniker: json['moniker'] as String,
        node: Node.fromJson(json['node'] as Map<String, dynamic>),
        pubKey: PubKey.fromJson(json['pub_key'] as Map<String, dynamic>),
        version: json['version'] as String,
        faucetAddress: json['faucet_addr'] as String?,
      );

  @override
  List<Object?> get props => <Object?>[
        catchingUp,
        chainId,
        genesisChecksum,
        kiraAddress,
        kiraPubKey,
        latestBlockHeight,
        moniker,
        node,
        pubKey,
        version,
        faucetAddress,
      ];
}
