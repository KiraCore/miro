import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api/genesis/genesis_resp.dart';
import 'package:miro/infra/dto/api/query_interx_status/query_interx_status_resp.dart';
import 'package:miro/infra/dto/api/query_validators/response/status.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';

class NetworkInfoModel extends Equatable {
  final String chainId;
  final String interxVersion;
  final int latestBlockHeight;
  final DateTime latestBlockTime;
  final String defaultAddressPrefix;
  final TokenAliasModel defaultTokenAliasModel;
  final int? activeValidators;
  final int? totalValidators;

  const NetworkInfoModel({
    required this.chainId,
    required this.interxVersion,
    required this.latestBlockHeight,
    required this.latestBlockTime,
    required this.defaultAddressPrefix,
    required this.defaultTokenAliasModel,
    this.activeValidators,
    this.totalValidators,
  });

  factory NetworkInfoModel.fromDtos(QueryInterxStatusResp queryInterxStatusResp, Status? status, GenesisResp genesisResp) {
    return NetworkInfoModel(
      chainId: queryInterxStatusResp.interxInfo.chainId,
      interxVersion: queryInterxStatusResp.interxInfo.version,
      latestBlockHeight: int.parse(queryInterxStatusResp.syncInfo.latestBlockHeight),
      latestBlockTime: DateTime.parse(queryInterxStatusResp.syncInfo.latestBlockTime),
      defaultAddressPrefix: genesisResp.bech32Prefix,
      defaultTokenAliasModel: TokenAliasModel.local(genesisResp.defaultDenom),
      activeValidators: status?.activeValidators,
      totalValidators: status?.totalValidators,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        chainId,
        interxVersion,
        latestBlockHeight,
        defaultAddressPrefix,
        defaultTokenAliasModel,
        activeValidators,
        totalValidators,
      ];
}
