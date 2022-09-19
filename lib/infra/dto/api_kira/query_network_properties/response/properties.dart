import 'package:equatable/equatable.dart';

class Properties extends Equatable {
  final bool enableForeignFeePayments;
  final bool enableTokenBlackList;
  final String inactiveRankDecreasePercent;
  final String maxMischance;
  final String maxTxFee;
  final String minIdentityApprovalTip;
  final String minProposalEnactmentBlocks;
  final String minProposalEndBlocks;
  final String minTxFee;
  final String minValidators;
  final String minimumProposalEndTime;
  final String mischanceConfidence;
  final String mischanceRankDecreaseAmount;
  final String poorNetworkMaxBankSend;
  final String proposalEnactmentTime;
  final String uniqueIdentityKeys;
  final String unjailMaxTime;
  final String voteQuorum;

  const Properties({
    required this.enableForeignFeePayments,
    required this.enableTokenBlackList,
    required this.inactiveRankDecreasePercent,
    required this.maxMischance,
    required this.maxTxFee,
    required this.minIdentityApprovalTip,
    required this.minProposalEnactmentBlocks,
    required this.minProposalEndBlocks,
    required this.minTxFee,
    required this.minValidators,
    required this.minimumProposalEndTime,
    required this.mischanceConfidence,
    required this.mischanceRankDecreaseAmount,
    required this.poorNetworkMaxBankSend,
    required this.proposalEnactmentTime,
    required this.uniqueIdentityKeys,
    required this.unjailMaxTime,
    required this.voteQuorum,
  });

  factory Properties.fromJson(Map<String, dynamic> json) {
    return Properties(
      enableForeignFeePayments: json['enable_foreign_fee_payments'] as bool,
      enableTokenBlackList: json['enable_token_blacklist'] as bool,
      inactiveRankDecreasePercent: json['inactive_rank_decrease_percent'] as String,
      maxMischance: json['max_mischance'] as String,
      maxTxFee: json['max_tx_fee'] as String,
      minIdentityApprovalTip: json['min_identity_approval_tip'] as String,
      minProposalEnactmentBlocks: json['min_proposal_enactment_blocks'] as String,
      minProposalEndBlocks: json['min_proposal_end_blocks'] as String,
      minTxFee: json['min_tx_fee'] as String,
      minValidators: json['min_validators'] as String,
      minimumProposalEndTime: json['minimum_proposal_end_time'] as String,
      mischanceConfidence: json['mischance_confidence'] as String,
      mischanceRankDecreaseAmount: json['mischance_rank_decrease_amount'] as String,
      poorNetworkMaxBankSend: json['poor_network_max_bank_send'] as String,
      proposalEnactmentTime: json['proposal_enactment_time'] as String,
      uniqueIdentityKeys: json['unique_identity_keys'] as String,
      unjailMaxTime: json['unjail_max_time'] as String,
      voteQuorum: json['vote_quorum'] as String,
    );
  }

  @override
  List<Object> get props => <Object>[
        enableForeignFeePayments,
        enableTokenBlackList,
        inactiveRankDecreasePercent,
        maxMischance,
        maxTxFee,
        minIdentityApprovalTip,
        minProposalEnactmentBlocks,
        minProposalEndBlocks,
        minTxFee,
        minValidators,
        minimumProposalEndTime,
        mischanceConfidence,
        mischanceRankDecreaseAmount,
        poorNetworkMaxBankSend,
        proposalEnactmentTime,
        uniqueIdentityKeys,
        unjailMaxTime,
        voteQuorum,
      ];
}
