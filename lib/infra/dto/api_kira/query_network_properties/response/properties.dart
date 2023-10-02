import 'package:equatable/equatable.dart';

class Properties extends Equatable {
  final String abstentionRankDecreaseAmount;
  final String dappAutoDenounceTime;
  final String dappBondDuration;
  final String dappVerifierBond;
  final bool enableForeignFeePayments;
  final bool enableTokenBlacklist;
  final bool enableTokenWhitelist;
  final String inactiveRankDecreasePercent;
  final String inflationPeriod;
  final String inflationRate;
  final String maxAbstention;
  final String maxAnnualInflation;
  final String maxCustodyBufferSize;
  final String maxCustodyTxSize;
  final String maxDelegators;
  final String maxJailedPercentage;
  final String maxMischance;
  final String maxProposalChecksumSize;
  final String maxProposalDescriptionSize;
  final String maxProposalPollOptionCount;
  final String maxProposalPollOptionSize;
  final String maxProposalReferenceSize;
  final String maxProposalTitleSize;
  final String maxSlashingPercentage;
  final String minCollectiveBond;
  final String minCollectiveBondingTime;
  final String minCollectiveClaimPeriod;
  final String minCustodyReward;
  final String minDelegationPushout;
  final String minIdentityApprovalTip;
  final String minProposalEnactmentBlocks;
  final String minProposalEndBlocks;
  final String minTxFee;
  final String minValidators;
  final String mischanceConfidence;
  final String mischanceRankDecreaseAmount;
  final String minimumProposalEndTime;
  final String proposalEnactmentTime;
  final String poorNetworkMaxBankSend;
  final String ubiHardcap;
  final String unjailMaxTime;
  final String uniqueIdentityKeys;
  final String unstakingPeriod;
  final String validatorRecoveryBond;
  final String validatorsFeeShare;
  final String voteQuorum;

  const Properties({
    required this.abstentionRankDecreaseAmount,
    required this.dappAutoDenounceTime,
    required this.dappBondDuration,
    required this.dappVerifierBond,
    required this.enableForeignFeePayments,
    required this.enableTokenBlacklist,
    required this.enableTokenWhitelist,
    required this.inactiveRankDecreasePercent,
    required this.inflationPeriod,
    required this.inflationRate,
    required this.maxAbstention,
    required this.maxAnnualInflation,
    required this.maxCustodyBufferSize,
    required this.maxCustodyTxSize,
    required this.maxDelegators,
    required this.maxJailedPercentage,
    required this.maxMischance,
    required this.maxProposalChecksumSize,
    required this.maxProposalDescriptionSize,
    required this.maxProposalPollOptionCount,
    required this.maxProposalPollOptionSize,
    required this.maxProposalReferenceSize,
    required this.maxProposalTitleSize,
    required this.maxSlashingPercentage,
    required this.minCollectiveBond,
    required this.minCollectiveBondingTime,
    required this.minCollectiveClaimPeriod,
    required this.minCustodyReward,
    required this.minDelegationPushout,
    required this.minIdentityApprovalTip,
    required this.minProposalEnactmentBlocks,
    required this.minProposalEndBlocks,
    required this.minTxFee,
    required this.minValidators,
    required this.mischanceConfidence,
    required this.mischanceRankDecreaseAmount,
    required this.minimumProposalEndTime,
    required this.proposalEnactmentTime,
    required this.poorNetworkMaxBankSend,
    required this.ubiHardcap,
    required this.unjailMaxTime,
    required this.uniqueIdentityKeys,
    required this.unstakingPeriod,
    required this.validatorRecoveryBond,
    required this.validatorsFeeShare,
    required this.voteQuorum,
  });

  factory Properties.fromJson(Map<String, dynamic> json) {
    return Properties(
      abstentionRankDecreaseAmount: json['abstention_rank_decrease_amount'] as String,
      dappAutoDenounceTime: json['dapp_auto_denounce_time'] as String,
      dappBondDuration: json['dapp_bond_duration'] as String,
      dappVerifierBond: json['dapp_verifier_bond'] as String,
      enableForeignFeePayments: json['enable_foreign_fee_payments'] as bool,
      enableTokenBlacklist: json['enable_token_blacklist'] as bool,
      enableTokenWhitelist: json['enable_token_whitelist'] as bool,
      inactiveRankDecreasePercent: json['inactive_rank_decrease_percent'] as String,
      inflationPeriod: json['inflation_period'] as String,
      inflationRate: json['inflation_rate'] as String,
      maxAbstention: json['max_abstention'] as String,
      maxAnnualInflation: json['max_annual_inflation'] as String,
      maxCustodyBufferSize: json['max_custody_buffer_size'] as String,
      maxCustodyTxSize: json['max_custody_tx_size'] as String,
      maxDelegators: json['max_delegators'] as String,
      maxJailedPercentage: json['max_jailed_percentage'] as String,
      maxMischance: json['max_mischance'] as String,
      maxProposalChecksumSize: json['max_proposal_checksum_size'] as String,
      maxProposalDescriptionSize: json['max_proposal_description_size'] as String,
      maxProposalPollOptionCount: json['max_proposal_poll_option_count'] as String,
      maxProposalPollOptionSize: json['max_proposal_poll_option_size'] as String,
      maxProposalReferenceSize: json['max_proposal_reference_size'] as String,
      maxProposalTitleSize: json['max_proposal_title_size'] as String,
      maxSlashingPercentage: json['max_slashing_percentage'] as String,
      minCollectiveBond: json['min_collective_bond'] as String,
      minCollectiveBondingTime: json['min_collective_bonding_time'] as String,
      minCollectiveClaimPeriod: json['min_collective_claim_period'] as String,
      minCustodyReward: json['min_custody_reward'] as String,
      minDelegationPushout: json['min_delegation_pushout'] as String,
      minIdentityApprovalTip: json['min_identity_approval_tip'] as String,
      minProposalEnactmentBlocks: json['min_proposal_enactment_blocks'] as String,
      minProposalEndBlocks: json['min_proposal_end_blocks'] as String,
      minTxFee: json['min_tx_fee'] as String,
      minValidators: json['min_validators'] as String,
      mischanceConfidence: json['mischance_confidence'] as String,
      mischanceRankDecreaseAmount: json['mischance_rank_decrease_amount'] as String,
      minimumProposalEndTime: json['minimum_proposal_end_time'] as String,
      proposalEnactmentTime: json['proposal_enactment_time'] as String,
      poorNetworkMaxBankSend: json['poor_network_max_bank_send'] as String,
      ubiHardcap: json['ubi_hardcap'] as String,
      unjailMaxTime: json['unjail_max_time'] as String,
      uniqueIdentityKeys: json['unique_identity_keys'] as String,
      unstakingPeriod: json['unstaking_period'] as String,
      validatorRecoveryBond: json['validator_recovery_bond'] as String,
      validatorsFeeShare: json['validators_fee_share'] as String,
      voteQuorum: json['vote_quorum'] as String,
    );
  }

  @override
  List<Object> get props => <Object>[
        abstentionRankDecreaseAmount,
        dappAutoDenounceTime,
        dappBondDuration,
        dappVerifierBond,
        enableForeignFeePayments,
        enableTokenBlacklist,
        enableTokenWhitelist,
        inactiveRankDecreasePercent,
        inflationPeriod,
        inflationRate,
        maxAbstention,
        maxAnnualInflation,
        maxCustodyBufferSize,
        maxCustodyTxSize,
        maxDelegators,
        maxJailedPercentage,
        maxMischance,
        maxProposalChecksumSize,
        maxProposalDescriptionSize,
        maxProposalPollOptionCount,
        maxProposalPollOptionSize,
        maxProposalReferenceSize,
        maxProposalTitleSize,
        maxSlashingPercentage,
        minCollectiveBond,
        minCollectiveBondingTime,
        minCollectiveClaimPeriod,
        minCustodyReward,
        minDelegationPushout,
        minIdentityApprovalTip,
        minProposalEnactmentBlocks,
        minProposalEndBlocks,
        minTxFee,
        minValidators,
        mischanceConfidence,
        mischanceRankDecreaseAmount,
        minimumProposalEndTime,
        proposalEnactmentTime,
        poorNetworkMaxBankSend,
        ubiHardcap,
        unjailMaxTime,
        uniqueIdentityKeys,
        unstakingPeriod,
        validatorRecoveryBond,
        validatorsFeeShare,
        voteQuorum,
      ];
}
