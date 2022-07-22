import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api/query_interx_status/query_interx_status_resp.dart';
import 'package:miro/infra/dto/api/query_validators/response/status.dart';

class NetworkInfoModel extends Equatable {
  final String chainId;
  final String interxVersion;
  final int latestBlockHeight;
  final DateTime latestBlockTime;
  final int? activeValidators;
  final int? totalValidators;

  const NetworkInfoModel({
    required this.chainId,
    required this.interxVersion,
    required this.latestBlockHeight,
    required this.latestBlockTime,
    this.activeValidators,
    this.totalValidators,
  });

  factory NetworkInfoModel.fromDto(QueryInterxStatusResp queryInterxStatusResp, Status? status) {
    return NetworkInfoModel(
      chainId: queryInterxStatusResp.interxInfo.chainId,
      interxVersion: queryInterxStatusResp.interxInfo.version,
      latestBlockHeight: int.parse(queryInterxStatusResp.syncInfo.latestBlockHeight),
      latestBlockTime: DateTime.parse(queryInterxStatusResp.syncInfo.latestBlockTime),
      activeValidators: status?.activeValidators,
      totalValidators: status?.totalValidators,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        chainId,
        interxVersion,
        latestBlockHeight,
        activeValidators,
        totalValidators,
      ];
}
