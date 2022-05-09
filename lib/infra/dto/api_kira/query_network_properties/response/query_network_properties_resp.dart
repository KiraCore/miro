import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/query_network_properties/response/properties.dart';

class QueryNetworkPropertiesResp extends Equatable {
  final Properties properties;

  const QueryNetworkPropertiesResp({
    required this.properties,
  });

  factory QueryNetworkPropertiesResp.fromJson(Map<String, dynamic> json) {
    return QueryNetworkPropertiesResp(
      properties: Properties.fromJson(json['properties'] as Map<String, dynamic>),
    );
  }

  factory QueryNetworkPropertiesResp.mock() {
    return const QueryNetworkPropertiesResp(
      properties: Properties(
        enableForeignFeePayments: true,
        enableTokenBlackList: true,
        inactiveRankDecreasePercent: '50',
        maxMischance: '50',
        maxTxFee: '1000000',
        minIdentityApprovalTip: '200',
        minProposalEnacmentBlocks: '1',
        minProposalEndBlocks: '2',
        minTxFee: '100',
        minValidators: '1',
        minimumProposalEndTime: '300',
        mischanceConfidence: '25',
        mischanceRankDecreaseAmount: '1',
        poorNetworkMaxBankSend: '1000000',
        proposalEnactmentTime: '300',
        uniqueIdentityKeys: 'moniker,username',
        unjailMaxTime: '1209600',
        voteQuorum: '25',
      ),
    );
  }

  @override
  List<Object?> get props => <Object>[properties.hashCode];
}
